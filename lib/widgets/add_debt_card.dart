import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowbill/providers/snowball_provider.dart';
import 'package:snowbill/providers/subscription_provider.dart';
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
              SubscriptionProvider subProv = Provider.of<SubscriptionProvider>(context, listen: false);

              // if the user has not paid and has reached the max number of debts
              // show a dialog that asks them to purchase the app
              if (!subProv.hasPaid && snowballProvider.snowball.debts.length >= subProv.maxDebts) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Upgrade to Pro'),
                      backgroundColor: Theme.of(context).cardColor,
                      content: const Text(
                        'You have reached the maximum number of debts allowed in the free version of the app. Please upgrade to the pro version to add more debts.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            subProv.buyPremium();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Upgrade',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return const AddDebtSheet();
                  },
                );
              }
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
