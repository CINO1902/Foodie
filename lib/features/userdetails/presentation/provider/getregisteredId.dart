import 'package:flutter/material.dart';
import 'package:foodie/features/userdetails/domain/repositories/userdetails_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/fetchidmodel.dart';

class GetregisteredIdprovider extends ChangeNotifier {
  final Userdetailsrepository userdetailsrepository;

  GetregisteredIdprovider(this.userdetailsrepository);
  int index = 0;
  int group = 0;
  List<Prev> result = [];
  bool loading = true;
  String? tokenregistered;
  String address = '';
  String firstname = '';
  bool verified = false;
  bool usedefault = true;
  String lastname = '';
  String phone = '';
  String email = '';
  String referal = '';
  String location = '';
  int numberrefer = 0;
  Future<void> getregisteredID() async {
    final prefs = await SharedPreferences.getInstance();
    tokenregistered = prefs.getString('tokenregistered');
    result = await userdetailsrepository.getregisteredId();
    firstname = result[0].firstname ?? '';
    lastname = result[0].lastname ?? '';
    verified = result[0].verified ?? false;
    referal = result[0].referalid ?? '';
    address = result[0].address ?? '';
    location = result[0].location ?? '';
    phone = result[0].phone ?? '';
    email = result[0].email ?? '';
    numberrefer = result[1].numberrefer ?? 0;
    loading = false;
    notifyListeners();
  }

  Future<void> checkregisteredlogg() async {
    final prefs = await SharedPreferences.getInstance();
    tokenregistered = prefs.getString('tokenregistered');
  }

  bool checkaddress() {
    bool a = true;

    if (address == '') {
      a = false;
    } else {
      a = true;
    }
    return a;
  }

  showindex(index1) {
    index = index1;
    group = index1;

    notifyListeners();
  }

  void usedefaultaddress() {
    usedefault = true;
    notifyListeners();
  }

  disposeint() {
    index = 0;
    group = 0;
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("tokenregistered");
    prefs.remove('email');
    prefs.remove('subscribed');
    checkregisteredlogg();
  }
}
