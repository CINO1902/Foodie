import 'package:flutter/material.dart';
import 'package:foodie/features/userdetails/domain/repositories/userdetails_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetIdprovider extends ChangeNotifier {
  final Userdetailsrepository userdetailsrepository;

  GetIdprovider(this.userdetailsrepository);
  int id = 0;
  String notloggedaddress = '';
  String notloggedemail = '';
  String notloggednumber = '';
  String notloggedname = '';
  String? notloggedlocation;
    String fullname = '';
  String number = '';
  String address = '';
  bool usedefault = true;
  String location = '';
  bool loading = true;
  Future<void> getID() async {
    id = await userdetailsrepository.getId();
    loading = false;
    final prefs = await SharedPreferences.getInstance();
    // print(id);
    await prefs.setInt("ID", id);
    notifyListeners();
  }

  Future<String?> getaddress() async {
    final _pref = await SharedPreferences.getInstance();

    notloggedemail = _pref.getString('notloggedemail') ?? '';
    notloggednumber = _pref.getString('notloggednumber') ?? '';
    notloggedname = _pref.getString('notloggedname') ?? '';
    notloggedlocation = _pref.getString('notloggedlocation');
    notloggedaddress = _pref.getString('address') ?? '';

    return notloggedaddress;
  }
    void gettempaddress(fullname1, phone1, address1, location1) {
    fullname = fullname1;
    number = phone1;
    address = address1;
    usedefault = false;
    location = location1;
    notifyListeners();
  }

  void saveaddress(address, email1, number, name, location1) async {
    final _pref = await SharedPreferences.getInstance();

    _pref.setString('address', address);
    _pref.setString('notloggedemail', email1);
    _pref.setString('notloggednumber', number);
    _pref.setString('notloggedname', name);
    _pref.setString('notloggedlocation', location1);
    getaddress();
    notifyListeners();
  }
}
