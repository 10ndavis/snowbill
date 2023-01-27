import 'package:flutter/material.dart';

class HideIfPaid extends StatelessWidget {
  const HideIfPaid({Key? key, required this.child}) : super(key: key);
  final bool hasPaid = false;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return hasPaid ? const SizedBox.shrink() : child;
  }
}
