import 'package:flutter/material.dart';

import '../loading_widget.dart';
import '../retry_widget.dart';

class StreamWidget<T> extends StatelessWidget {
  final Stream<T> stream;
  final Function() onRetry;
  final Widget loadingWidget;
  final Widget Function(T data) child;
  final T? initial;

  const StreamWidget({
    Key? key,
    required this.stream,
    required this.onRetry,
    this.loadingWidget = const LoadingWidget(),
    required this.child,
    this.initial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      initialData: initial,
      stream: stream,
      builder: (context, snap) {
        if (snap.hasData && snap.data != null) return child(snap.data!);
        if (snap.hasError) return RetryWidget(onRetry: onRetry);
        return loadingWidget;
      },
    );
  }
}
