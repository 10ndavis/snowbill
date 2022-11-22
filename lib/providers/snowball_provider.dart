import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snowbill/models/debt.dart';
import 'package:snowbill/models/debtSnowball.dart';

class SnowballProvider with ChangeNotifier {
  SharedPreferences? _prefs;

  Future<bool> init() async {
    _prefs = await SharedPreferences.getInstance();
    String? snowballJson = _prefs?.getString('snowball');
    if (snowballJson != null) {
      Map<String, dynamic> json = jsonDecode(snowballJson);
      _snowball = DebtSnowball.fromJson(json);
    }
    notifyListeners();
    return true;
  }

  void saveToStorage() {
    Map<String, dynamic>? jsonMap = _snowball?.toMap();
    if (jsonMap != null) {
      // print(jsonEncode(jsonMap));
      // String jsonString = jsonEncode(jsonMap);
      // print(jsonString);
      _prefs?.setString('snowball', jsonEncode(_snowball?.toMap()));
    }
  }

  DebtSnowball? _snowball;

  void addDebt(Debt debt) {
    _snowball?.debts.add(debt);
    saveToStorage();
    notifyListeners();
  }

  void deleteDebt(Debt debt) {
    _snowball?.debts.remove(debt);
    saveToStorage();
    notifyListeners();
  }

  void updateExtraPayment(double value) {
    _snowball?.extra = value;
    saveToStorage();
    notifyListeners();
  }

  DebtSnowball get snowball {
    return _snowball ??= DebtSnowball();
  }

  set snowball(DebtSnowball snowball) {
    _snowball = snowball;
    saveToStorage();

    notifyListeners();
  }
}
