import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodie/features/orderfood/domain/repositories/cartrepo.dart';
import 'package:foodie/features/userdetails/presentation/provider/getidprovider.dart';
import 'package:foodie/features/userdetails/presentation/provider/getregisteredId.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../orders/data/models/fetchcartmodel.dart';
import '../../../orders/data/models/ordermodel.dart';
import '../../data/models/SendCoupon.dart';
import '../../data/models/SendLocation.dart';
import '../../data/models/verifycoupon.dart';

class GetCartPro extends ChangeNotifier {
  int totalcartcall = 0;
  final CartRepo cartRepo;
  GetCartPro(this.cartRepo);
  List<Pagnited> cartresult = [];
  List<Pagnited> fetchresult = [];
  bool loading = true;
  int sumget = 0;
  double moneytopay = 0.00;
  List getTotal = [];
  int delivery = 0;
  String stringmoney = '';
  bool usedefault = true;
  String coupon = '';
  String whatsappnumber = '';
  String perlocation = '';
  String location = '';
  bool verified = false;
  String msg = '';
  bool error = false;
  String type = '';
  int? amount = 0;
  String status = '';
  String? success = '';
  int? discount = 0;
  Timer? t;
  String address = '';
  String? tokenregistered;
  String phone = '';
  String notloggednumber = '';
  String notloggedaddress = '';
  String? notloggedlocation = '';
  String notloggedname = '';
  String firstname = '';
  String email = '';
  String notloggedemail = '';

  Future<void> getCart() async {
    loading = true;
    final prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("ID") ?? 0;

    String email = prefs.getString("email") ?? '';

    String token = prefs.getString("tokenregistered") ?? '';
    print(token);

    FetchcartModel getfetchmodel() {
      FetchcartModel fetchmodel =
          FetchcartModel(id: id.toString(), email: email);

      if (token != '') {
        fetchmodel = FetchcartModel(id: '', email: email);
      } else {
        fetchmodel = FetchcartModel(id: id.toString(), email: '');
      }
      return fetchmodel;
    }

    final response = await cartRepo.getCart(getfetchmodel());

    final data = CartRecieveModel.fromJson(response[0]);

    fetchresult = data.result.pagnited;

    fetchresult.sort((a, b) => a.date.compareTo(b.date));

    if (token != '') {
      cartresult = fetchresult
          .where((element) =>
              element.order == false && element.pagnitedId == email)
          .toList();
    } else {
      cartresult =
          fetchresult.where((element) => element.order == false).toList();
    }

    List multiadd = [];
    for (var i = 0; i < cartresult.length; i++) {
      if (cartresult[i].multiple.runtimeType == String) {
        multiadd.add(int.parse(cartresult[i].multiple));
      } else {
        multiadd.add(cartresult[i].multiple);
      }
    }
    if (multiadd.isNotEmpty) {
      final limitcart = multiadd.reduce((a, b) => a + b);
      totalcartcall = ((limitcart / 5) + 1).floor();
    }
    totalcart();
    loading = false;
    notifyListeners();
  }

  Future<void> verifycoupon(code) async {
    moneytopay = (sumget + (delivery * totalcartcall)).toDouble();
    stringmoney = moneytopay.toString();
    try {
      coupon = code;
      loading = true;
      Sendcoupon send = Sendcoupon(code: code);
      var response = await cartRepo.verifycoupon(send);

      final coupondetails = VerifyCoupon.fromJson(response[0]);

      type = coupondetails.type;

      msg = coupondetails.msg;
      success = coupondetails.status;
      if (success == 'success') {
        verified = true;
        amount = coupondetails.amount;
        discount = coupondetails.discount;
        if (type == 'discount') {
          if (moneytopay > 5000) {
            final dis = (discount! / 100) * 5000;
            moneytopay = moneytopay - dis;
            stringmoney = moneytopay.toString();
          } else {
            final dis = (discount! / 100) * moneytopay;
            moneytopay = moneytopay - dis;
            stringmoney = moneytopay.toString();
          }
        } else if (type == 'money') {
          moneytopay = (moneytopay - amount!.toDouble());
          stringmoney = moneytopay.toString();
        }
      } else {
        verified = false;
      }
    } catch (e) {
      print(e);
    } finally {
      loading = false;
    }
    notifyListeners();
  }
  void disposediscount() {
    verified = false;
    discount = 0;
    amount = 0;
  }

  Future<void> locationa() async {
    error = false;
    loading = true;
    String getlocation() {
      String locate = '';
      if (usedefault == true) {
        locate = perlocation;
      } else {
        locate = location;
      }
      return locate;
    }

    try {
      loading = true;
      Sendlocation send = Sendlocation(location: getlocation());
      var response = await cartRepo.sendlocation(send);

      final data = response[0];
      whatsappnumber = data["number"];
      delivery = data['msg'] * totalcartcall;
      moneytopay = (sumget + delivery).toDouble();
      stringmoney = moneytopay.toString();
    } catch (e) {
      print(e);
      error = true;
    } finally {
      loading = false;
    }
    notifyListeners();
  }

  Future<void> removecart(id) async {
    error = false;
    loading = true;
    String getlocation() {
      String locate = '';
      if (usedefault == true) {
        locate = perlocation;
      } else {
        locate = location;
      }
      return locate;
    }

    try {
      loading = true;

      var response = await cartRepo.removecart(id);

      final data = response[0];
      msg = data["msg"];
      status = data['status'];
      print(status);
    } catch (e) {
      print(e);
      
      error = true;
    } finally {
      loading = false;
    }
    getCart();
    notifyListeners();
  }

  Future<void> removecartspecial(id) async {
    error = false;
    loading = true;
    String getlocation() {
      String locate = '';
      if (usedefault == true) {
        locate = perlocation;
      } else {
        locate = location;
      }
      return locate;
    }

    try {
      loading = true;

      var response = await cartRepo.removecartspecial(id);

      final data = response[0];
      msg = data["msg"];
    } catch (e) {
      print(e);
      error = true;
    } finally {
      loading = false;
    }
    getCart();
    notifyListeners();
  }

  void totalcart() {
    getTotal.clear();
    if (cartresult.isNotEmpty) {
      for (var i = 0; i < cartresult.length; i++) {
        if (cartresult[i].specialName == null) {
          getTotal.add(int.parse(cartresult[i].total!));
        } else {
          getTotal.add(int.parse(cartresult[i].amount.toString()));
        }
      }
    }
    if (getTotal.isNotEmpty) {
      sumget = getTotal.reduce((a, b) => a + b);
    }
    notifyListeners();
  }

  String numberdecide() {
    String getnum = '';
    if (tokenregistered != null) {
      getnum = phone;
    } else {
      getnum = notloggednumber;
    }
    return getnum;
  }

  String emaildecide() {
    String getmail = '';
    if (tokenregistered != null) {
      getmail = email;
    } else {
      getmail = notloggedemail;
    }
    return getmail;
  }

  String namedecide() {
    String getname = '';
    if (tokenregistered != null) {
      getname = firstname;
    } else {
      getname = notloggedname;
    }
    return getname;
  }

  String locationdecide() {
    String getlocation = '';
    if (tokenregistered != null) {
      getlocation = location;
    } else {
      getlocation = notloggedlocation ?? '';
    }
    return getlocation;
  }

  String addressdecide() {
    String getadd = '';
    if (tokenregistered != null) {
      getadd = address;
    } else {
      getadd = notloggedaddress;
    }
    return getadd;
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

  void update(GetIdprovider getIdprovider,
      GetregisteredIdprovider getregisteredIdprovider) {
    address = getregisteredIdprovider.address;
    tokenregistered = getregisteredIdprovider.tokenregistered;
    email = getregisteredIdprovider.email;
    phone = getregisteredIdprovider.phone;
    firstname = getregisteredIdprovider.firstname;
    address = getregisteredIdprovider.address;
    location = getregisteredIdprovider.location;
    notloggedname = getIdprovider.notloggedname;
    notloggedemail = getIdprovider.notloggedemail;
    notloggednumber = getIdprovider.notloggednumber;
    notloggedlocation = getIdprovider.notloggedlocation;
    notloggedaddress = getIdprovider.notloggedaddress;
  }
}
