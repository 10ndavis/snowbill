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

  // gets the remainingInterest
  double get remainingInterest {
    // Step 1: Calculate the Monthly Interest Rate
    double monthlyInterestRate = interestRate / 12 / 100;

    // Step 2: Calculate the Monthly Interest Payment
    double monthlyInterestPayment = remainingBalance * monthlyInterestRate;

    // Step 3: Estimate the Remaining Interest (Approximate)
    double approximateRemainingInterest = monthlyInterestPayment * remainingPayments();

    return approximateRemainingInterest;
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
