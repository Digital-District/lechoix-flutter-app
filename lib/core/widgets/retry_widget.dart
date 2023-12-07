import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/local_helper.dart';
import 'package:lechoix/core/widgets/space_widget.dart';

import 'button/elevated_button_widget.dart';

class RetryWidget extends StatelessWidget {
  final String? msg;
  final Function() onRetry;

  const RetryWidget({
    Key? key,
    this.msg,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/img_connection_error.png", scale: 4),
          const VerticalSpace(32),
          Text(
            msg ?? "Something Went Wrong".localize(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const VerticalSpace(32),
          ElevatedButtonWidget(
            onClick: onRetry,
            child: Text("Retry".localize()),
          ),
        ],
      ),
    );
  }
}
