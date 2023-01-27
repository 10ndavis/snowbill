// ignore_for_file: file_names

import 'package:Snowbill/models/debt.dart';
import 'package:Snowbill/models/debt_calculation_container.dart';

class DebtSnowball {
  DebtSnowball();

  DebtSnowball.fromJson(Map<String, dynamic> json) {
    dynamic jsonDebts = json['debts'];

    extra = json['extra'];
    debts = jsonDebts.values.map<Debt>((dynamic debt) {
      return Debt(
          monthlyPayment: debt['monthlyPayment'],
          remainingBalance: debt['remainingBalance'],
          name: debt['name'],
          createdAt: DateTime.parse(debt['createdAt']),
          interestRate: debt['interestRate']);
    }).toList();
  }

  List<Debt> debts = [];
  double extra = 0;

  double get totalDebt => debts.fold(0, (acc, current) => acc += current.remainingBalance);

  List<DebtCalculationContainer> snowBallPayments() {
    // if there are no debts, return an empty list
    if (debts.isEmpty) return [];

    // sort by payments to get the highest number of payments
    debts.sort((debtOne, debtTwo) => (debtOne.remainingPayments() - debtTwo.remainingPayments()).ceil());
    Debt longestPayoff = debts.last;

    // sort by remaining balance, to get proper order to display on the UI and run the snowball
    // calculations against
    debts.sort((debtOne, debtTwo) => (debtOne.remainingBalance - debtTwo.remainingBalance).ceil());

    List<DebtCalculationContainer> calculators = debts.map((Debt debt) {
      return DebtCalculationContainer(debt: debt);
    }).toList();

    double monthlyExtra = extra;
    double paidOffExtra = 0;
    double carryOver = 0;

    // TODO: make this work with interest

    for (int i = 0; i < longestPayoff.remainingPayments(); i++) {
      // at the beginning of each month, add the one time monthly payment
      // this includes an "extra" as well as prior paid off debts
      monthlyExtra = extra + paidOffExtra;

      for (DebtCalculationContainer debt in calculators) {
        // if the debt has a balance, we need to make a payment
        if (debt.hasBalance) {
          // make a payment, and keep any carry over
          carryOver = debt.makePayment(extra: monthlyExtra + carryOver);

          // set monthly back to zero since it can only be used once a month
          monthlyExtra = 0;

          if (!debt.hasBalance) {
            // if the debt is now paid off, we need to apply that payment amount to our monthly payment for this bill
            paidOffExtra += debt.debt.monthlyPayment;
          }
        }
      }
    }
    return calculators;
  }

  Map<String, dynamic> toMap() {
    return {
      'extra': extra,
      'debts': debts.toMap(),
    };
  }
}

extension SnowballExtension on List<Debt> {
  Map<String, Map<String, dynamic>> toMap() {
    List<Map<String, dynamic>> results = map((Debt debt) {
      return debt.toMap();
    }).toList();
    Map<String, Map<String, dynamic>> resultMap = {};
    for (int i = 0; i < results.length; i++) {
      resultMap['$i'] = results[i];
    }

    return resultMap;
  }
}
