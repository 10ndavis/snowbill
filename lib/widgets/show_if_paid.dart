import 'package:flutter/material.dart';

class ShowIfPaid extends StatelessWidget {
  const ShowIfPaid({Key? key, required this.child}) : super(key: key);
  final bool hasPaid = false;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return hasPaid ? child : const SizedBox.shrink();
  }
}
