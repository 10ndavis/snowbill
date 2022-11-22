import 'package:intl/intl.dart';
import 'package:snowbill/models/debt.dart';

class DebtCalculationContainer {
  DebtCalculationContainer({required this.debt}) {
    balance = debt.remainingBalance;
  }

  Debt debt;
  late double balance;
  int totalPayments = 0;

  String get payoffMonthString {
    DateTime today = DateTime.now();
    DateTime payoffDate = DateTime(today.year, today.month + totalPayments, today.day);

    final DateFormat formatter = DateFormat('MM/yy');
    final String formatted = formatter.format(payoffDate);

    return formatted;
  }

  /// Makes a payment. If the payment is more than the balance,
  /// zero out the balance and return the overpaid amount.
  double makePayment({double extra = 0}) {
    totalPayments++;

    double newBalance = balance - (debt.monthlyPayment + extra);
    if (newBalance < 0) {
      balance = 0;
      return newBalance * -1;
    }

    balance = newBalance;
    return 0;
  }

  bool get hasBalance => balance != 0;
}
