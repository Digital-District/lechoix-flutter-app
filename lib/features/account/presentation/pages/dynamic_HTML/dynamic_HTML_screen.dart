import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../core/widgets/stream/stream_widget.dart';
import '../../cubit/dynamic_HTML_bloc.dart';

class DynamicHTMLScreen extends StatefulWidget {
  final String screenTitle;

  final String pageKey;

  const DynamicHTMLScreen(this.screenTitle, this.pageKey, {super.key});

  @override
  State<StatefulWidget> createState() => _DynamicHTMLScreenState();
}

class _DynamicHTMLScreenState
    extends BaseState<DynamicHTMLScreen, DynamicHTMLBloc> {
  @override
  void initBloc() {
    bloc = DynamicHTMLBloc(this, widget.pageKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(centerWidget: Text(localize(widget.screenTitle))),
      body: StreamWidget<String?>(
          stream: bloc.controller.stream,
          onRetry: bloc.getData,
          child: (data) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Html(data: data),
            );
          }),
    );
  }
}
