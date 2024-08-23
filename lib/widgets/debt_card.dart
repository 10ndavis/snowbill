import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowbill/models/debt_calculation_container.dart';
import 'package:snowbill/providers/snowball_provider.dart';
import 'package:snowbill/widgets/add_debt_sheet.dart';

class DebtCard extends StatelessWidget {
  const DebtCard({Key? key, required this.container}) : super(key: key);
  final DebtCalculationContainer container;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return AddDebtSheet(
              container: container,
            );
          },
        );
      },
      child: ListTile(
        key: UniqueKey(),
        title: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          child: Dismissible(
            onDismissed: (DismissDirection direction) {
              Provider.of<SnowballProvider>(context, listen: false).deleteDebt(container.debt);
            },
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.redAccent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          container.debt.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Text(
                        'Payoff: ${container.payoffMonthString} (${container.totalPayments} mo)',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Remaining: ',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextSpan(
                                text: '\$${container.debt.remainingBalance.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.redAccent),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Interest Saved: ',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextSpan(
                                text: '\$${container.interestSaved.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.greenAccent),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
