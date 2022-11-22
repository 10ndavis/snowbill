import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowbill/providers/snowball_provider.dart';
import 'package:snowbill/widgets/add_debt_sheet.dart';

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
              // snowballProvider.addDebt(Debt(monthlyPayment: 200, remainingBalance: 2000, name: 'test'));
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return AddDebtSheet();
                },
              );
            },
            child: DottedBorder(
              radius: Radius.circular(8),
              color: Theme.of(context).cardColor,
              dashPattern: [20, 5],
              strokeWidth: 2,
              borderType: BorderType.RRect,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
