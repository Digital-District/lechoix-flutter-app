import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lechoix/core/base/base_state.dart';
import 'package:lechoix/core/widgets/app_bar_widget.dart';

import '../../../../core/base/dummy_bloc.dart';

class SizeGuideScreen extends StatefulWidget {
  final String htmlContent;

  SizeGuideScreen(this.htmlContent, {super.key});

  @override
  State<StatefulWidget> createState() => _SizeGuideScreenState();
}

class _SizeGuideScreenState extends BaseState<SizeGuideScreen, DummyBloc> {
  @override
  void initBloc() {
    bloc = DummyBloc(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        centerWidget: Text(
          localize("Size Guide"),
        ),
      ),
      body: Html(data: widget.htmlContent),
    );
  }
}
