import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowbill/models/debt_calculation_container.dart';
import 'package:snowbill/providers/snowball_provider.dart';
import 'package:snowbill/widgets/add_debt_card.dart';
import 'package:snowbill/widgets/debt_card.dart';

class DebtList extends StatelessWidget {
  const DebtList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SnowballProvider>(
      builder: (context, SnowballProvider snowballProvider, _) {
        return Column(
          children: [
            ...snowballProvider.snowball.snowBallPayments().map(
              (DebtCalculationContainer container) {
                return DebtCard(container: container);
              },
            ).toList(),
            AddDebtCard(),
          ],
        );
      },
    );
  }
}
