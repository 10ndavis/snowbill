class Debt {
  Debt({
    required this.monthlyPayment,
    required this.remainingBalance,
    required this.name,
  });
  double monthlyPayment;
  double remainingBalance;
  String name;

  double remainingPayments({double extra = 0}) {
    return remainingBalance / (monthlyPayment + extra);
  }

  Map<String, dynamic> toMap() {
    return {
      'monthlyPayment': monthlyPayment,
      'remainingBalance': remainingBalance,
      'name': name,
    };
  }
}
