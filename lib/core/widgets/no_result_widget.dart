import 'package:flutter/material.dart';

import '../util/utils/local_helper.dart';
import 'space_widget.dart';

class NoResultWidget extends StatelessWidget {
  final String? msg;

  const NoResultWidget({super.key, this.msg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/img_empty_result.png", scale: 4),
          const VerticalSpace(32),
          Text(
            msg ?? "No Result found". localize(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
