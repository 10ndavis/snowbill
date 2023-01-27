import 'package:snowbill/providers/snowball_provider.dart';
import 'package:snowbill/widgets/add_debt_sheet.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDebtCard extends StatelessWidget {
  const AddDebtCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SnowballProvider>(
      builder: (context, SnowballProvider snowballProvider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return const AddDebtSheet();
                },
              );
            },
            child: DottedBorder(
              radius: const Radius.circular(8),
              color: Theme.of(context).cardColor,
              dashPattern: const [20, 5],
              strokeWidth: 2,
              borderType: BorderType.RRect,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Add a Debt'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
