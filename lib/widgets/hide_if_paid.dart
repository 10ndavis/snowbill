import 'package:flutter/material.dart';

class HideIfPaid extends StatelessWidget {
  const HideIfPaid({Key? key, required this.childBuilder}) : super(key: key);
  final bool hasPaid = true;
  final Widget Function() childBuilder;

  @override
  Widget build(BuildContext context) {
    return hasPaid ? const SizedBox.shrink() : childBuilder();
  }
}
