import 'package:flutter/material.dart';

class SubscriptionProvider extends ChangeNotifier {
  int maxDebts = 4;
  bool hasPaid = true;

  Future<void> buyPremium() async {
    // simulate a purchase
    await Future.delayed(const Duration(seconds: 2));
    hasPaid = true;
    notifyListeners();
  }
}
