import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:Snowbill/models/debt_calculation_container.dart';
import 'package:Snowbill/providers/snowball_provider.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({Key? key}) : super(key: key);

  Color calculateColor(int index) {
    return const Color.fromRGBO(89, 207, 206, 1).withOpacity(double.parse('0.${index + 1}'));
  }

  Widget buildKey(SnowballProvider snowballProvider) {
    return Column(
      children: [
        ...snowballProvider.snowball.snowBallPayments().asMap().entries.map(
          (entry) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: calculateColor(entry.key),
                      border: Border.all(color: Colors.black87, width: 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(entry.value.debt.name),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(locale: 'en', symbol: '\$', decimalDigits: 0);

    return Consumer<SnowballProvider>(builder: (context, SnowballProvider snowballProvider, _) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Debt by Size',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                AspectRatio(
                  aspectRatio: 19.5 / 9,
                  child: PieChart(
                    PieChartData(
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 2,
                      centerSpaceRadius: 0,
                      sections: [
                        ...snowballProvider.snowball.snowBallPayments().asMap().entries.map(
                          (entry) {
                            DebtCalculationContainer currentDebt = entry.value;
                            int index = entry.key;
                            return PieChartSectionData(
                              color: calculateColor(index),
                              value: currentDebt.debt.remainingBalance / snowballProvider.snowball.totalDebt,
                              title: currencyFormatter.format(currentDebt.debt.remainingBalance),
                              // radius: radius,
                              titleStyle: const TextStyle(
                                // fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffffffff),
                              ),
                              badgePositionPercentageOffset: .98,
                              radius: 100,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, top: 40),
                  child: Text(
                    'Debt by Time',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                AspectRatio(
                  aspectRatio: 19.5 / 9,
                  child: PieChart(
                    PieChartData(
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 2,
                      centerSpaceRadius: 0,
                      sections: [
                        ...snowballProvider.snowball.snowBallPayments().asMap().entries.map(
                          (entry) {
                            DebtCalculationContainer currentDebt = entry.value;
                            int index = entry.key;
                            return PieChartSectionData(
                              color: calculateColor(index),
                              value: currentDebt.totalPayments /
                                  snowballProvider.snowball.snowBallPayments().last.totalPayments,
                              title: '${currentDebt.totalPayments}mo',
                              // radius: radius,
                              titleStyle: const TextStyle(
                                // fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffffffff),
                              ),
                              badgePositionPercentageOffset: .98,
                              radius: 100,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: buildKey(snowballProvider),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
