import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/widgets/stream/stream_widget.dart';
import 'package:lechoix/data/model/PaginationModel.dart';
import 'package:lechoix/data/pair.dart';

import '../loading_widget.dart';
import '../no_result_widget.dart';
import '../retry_widget.dart';

class PaginatedGridWidget<T> extends StatefulWidget {
  final Stream<Pair<List<T>, PaginationModel>?> stream;
  final Function() onRetry;
  final Function() onLoadMore;
  final Widget Function(T data) child;
  final Function(PaginationModel model) onPaginationReceived;
  final Pair<List<T>, PaginationModel>? initial;
  final EdgeInsets padding;
  final bool reverse;
  final Widget loadingWidget;
  final Widget? topWidget;
  final bool showNoResult;

  const PaginatedGridWidget({
    super.key,
    required this.stream,
    required this.onRetry,
    required this.onLoadMore,
    required this.child,
    required this.onPaginationReceived,
    this.initial,
    this.padding = const EdgeInsets.all(UIConstants.screenPadding),
    this.reverse = false,
    this.loadingWidget = const LoadingWidget(),
    this.topWidget,
    this.showNoResult = true,
  });

  @override
  State<PaginatedGridWidget<T>> createState() => _PaginatedGridWidgetState<T>();
}

class _PaginatedGridWidgetState<T> extends State<PaginatedGridWidget<T>> {
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
      _isLoading = true;
      _loadMoreController.add(_isLoading);
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<Pair<List<T>, PaginationModel>?>(
            initialData: widget.initial,
            stream: widget.stream,
            builder: (context, snap) {
              if (snap.hasData && snap.data != null) {
                var list = snap.data?.first ?? [];
                widget.onPaginationReceived(snap.data!.last);
                _isLoading = false;
                _loadMoreController.add(_isLoading);
                _isEndOfList = snap.data?.last.isEndOfList ?? false;

                return ListView(
                  padding: EdgeInsets.zero,
                  controller: _scrollController,
                  children: [
                    widget.topWidget ?? Container(),
                    list.isEmpty
                        ? const NoResultWidget()
                        : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: widget.padding,
                            reverse: widget.reverse,
                            itemCount: list.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.5,
                              crossAxisSpacing: 16.0,
                              mainAxisSpacing: 16.0,
                            ),
                            itemBuilder: (context, index) {
                              return widget.child(list[index]);
                            },
                          )
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
          child: (isLoading) => Visibility(
            visible: isLoading,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const CircularProgressIndicator(),
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
