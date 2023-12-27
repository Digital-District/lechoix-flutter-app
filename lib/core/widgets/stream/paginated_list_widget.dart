import 'dart:async';

import 'package:flutter/material.dart';

import '../../util/utils/consts/ui_constants.dart';
import '../loading_widget.dart';
import '../no_result_widget.dart';
import '../retry_widget.dart';
import 'stream_widget.dart';

class PaginatedListWidget<T> extends StatefulWidget {
  final Stream<PaginationHolder<T>?> stream;
  final Function() onRetry;
  final Function() onLoadMore;
  final Widget Function(T data) child;
  final PaginationHolder<T>? initial;
  final EdgeInsets padding;
  final bool reverse;
  final Widget loadingWidget;
  final Widget? topWidget;
  final bool showNoResult;

  const PaginatedListWidget({
    super.key,
    required this.stream,
    required this.onRetry,
    required this.onLoadMore,
    required this.child,
    this.initial,
    this.padding = const EdgeInsets.all(UIConstants.screenPadding),
    this.reverse = false,
    this.loadingWidget = const LoadingWidget(),
    this.topWidget,
    this.showNoResult = true,
  });

  @override
  State<PaginatedListWidget<T>> createState() => _PaginatedListWidgetState<T>();
}

class _PaginatedListWidgetState<T> extends State<PaginatedListWidget<T>> {
  final StreamController<bool> _loadMoreController = StreamController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  bool _isEndOfList = false;

  @override
  void initState() {
    _scrollController.addListener(_loadMore);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMore);
    _scrollController.dispose();
    _loadMoreController.close();
    super.dispose();
  }

  void _loadMore() async {
    if (_scrollController.position.extentAfter < 300 &&
        !_isLoading &&
        !_isEndOfList) {
      widget.onLoadMore();
      _isLoading = true;
      _loadMoreController.add(_isLoading);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<PaginationHolder<T>?>(
            initialData: widget.initial,
            stream: widget.stream,
            builder: (context, snap) {
              if (snap.hasData && snap.data != null) {
                var list = snap.data?.list ?? [];

                _isLoading = false;
                _loadMoreController.add(_isLoading);
                _isEndOfList = snap.data?.isEndOfList ?? false;

                return list.isEmpty
                    ? Column(
                        children: [
                          if (widget.topWidget != null) widget.topWidget!,
                          if (widget.showNoResult)
                            const Expanded(child: NoResultWidget()),
                        ],
                      )
                    : ListView(
                        controller: _scrollController,
                        children: [
                          if (widget.topWidget != null) widget.topWidget!,
                          ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: widget.padding,
                            reverse: widget.reverse,
                            itemCount: list.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                widget.child(list[index]),
                          ),
                        ],
                      );
              } else if (snap.hasError) {
                return RetryWidget(onRetry: widget.onRetry);
              } else {
                return widget.loadingWidget;
              }
            },
          ),
        ),
        StreamWidget<bool>(
          stream: _loadMoreController.stream,
          onRetry: () {},
          initial: false,
          child: (isLoading) => AnimatedSize(
            duration: const Duration(milliseconds: 400),
            child: Visibility(
              visible: isLoading,
              child: Container(
                key: const ValueKey(1),
                padding: const EdgeInsets.all(8),
                child: const CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PaginationHolder<T> {
  List<T> list;
  bool isEndOfList;

  PaginationHolder(this.list, this.isEndOfList);
}
