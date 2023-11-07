import 'package:flutter/material.dart';
import 'package:foodie/features/changeaddress/data/models/changeAddress.dart';
import 'package:foodie/features/changeaddress/domain/repositories/changeAdressrepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeAddressPro extends ChangeNotifier {
  final ChangeAddressRepo changeAddressRepo;

  ChangeAddressPro(this.changeAddressRepo);
  List result = [];
  String msg = '';
  bool error = false;
  Future<void> changeaddress(phone, location, address) async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    ChangeAddress change = ChangeAddress(
        email: email, address: address, phone: phone, location: location);
    result = await changeAddressRepo.changeAddress(change);
    msg = result[1];
    error = result[0];
    notifyListeners();
  }
}
