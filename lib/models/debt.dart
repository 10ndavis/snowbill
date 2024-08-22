class Debt {
  Debt({
    required this.monthlyPayment,
    required this.remainingBalance,
    required this.name,
    required this.createdAt,
    required this.interestRate,
  });
  double monthlyPayment;
  double remainingBalance;
  String name;
  DateTime createdAt;
  double interestRate;

  double remainingPayments({double extra = 0}) {
    if (remainingBalance == 0 || monthlyPayment == 0) return 0;
    return remainingBalance / (monthlyPayment + extra);
  }

  Map<String, dynamic> toMap() {
    return {
      'monthlyPayment': monthlyPayment,
      'remainingBalance': remainingBalance,
      'name': name,
      'createdAt': createdAt.toString(),
      'interestRate': interestRate,
    };
  }
}
