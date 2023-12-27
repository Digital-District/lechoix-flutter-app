import 'package:flutter/material.dart';

import '../loading_widget.dart';
import '../no_result_widget.dart';
import '../retry_widget.dart';

class StreamListWidget<T> extends StatelessWidget {
  final Stream<List<T>?> stream;
  final Function() onRetry;
  final Widget loadingWidget;
  final Widget noResultWidget;

  final Widget Function(T data) child;
  final List<T>? initial;
  final EdgeInsets padding;
  final bool reverse;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final Axis scrollDirection;

  const StreamListWidget({
    super.key,
    required this.stream,
    required this.onRetry,
    this.loadingWidget = const LoadingWidget(),
    this.noResultWidget = const NoResultWidget(),
    required this.child,
    this.initial,
    this.padding = const EdgeInsets.all(0),
    this.reverse = false,
    this.scrollController,
    this.physics,
    this.scrollDirection = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T>?>(
      initialData: initial,
      stream: stream,
      builder: (context, snap) {
        if (snap.hasData && snap.data != null) {
          var list = snap.data ?? [];
          return list.isEmpty
              ? noResultWidget
              : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: scrollDirection,
                  padding: padding,
                  reverse: reverse,
                  physics: physics,
                  controller: scrollController,
                  itemCount: list.length,
                  itemBuilder: (context, index) => child(list[index]),
                );
        } else if (snap.hasError) {
          return RetryWidget(onRetry: onRetry);
        } else {
          return loadingWidget;
        }
      },
    );
  }
}
