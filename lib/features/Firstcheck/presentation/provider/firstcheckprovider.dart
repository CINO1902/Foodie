import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodie/features/Firstcheck/domain/repositories/firstcheck_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class firstcheckprovider extends ChangeNotifier {
  final Firscheckrepository firstcheckrepo;
  firstcheckprovider(this.firstcheckrepo);
  bool loading = false;
  bool error = false;
  String msg = '';
  List result = [];
  Future<void> actionbtn() async {
    loading = true;
    notifyListeners();
    try {
      result = await firstcheckrepo.createnonusertoken();
      loading = false;

      if (result[0] != 'success') {
        error = true;
      } else {
        error = false;
      }
      notifyListeners();
      msg = result[1];
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", result[2]);
    } catch (e) {
      error = true;
      msg = 'Something Went Wrong';
      notifyListeners();
    }
  }
}
