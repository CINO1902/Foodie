import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../SelectExtrafood/presentation/provider/calculate.dart';
import '../../data/models/cartmodel.dart';
import '../../domain/repositories/sendcartRepo.dart';

class addTocart extends ChangeNotifier {
  final SendCartRepository sendCartRepository;

  List Clickedfood = [];
  List cart = [];
  List cartList = [];
  String food = '';
  int amount = 0;
  List<Map<String, dynamic>> extras = [];
  int multiple = 1;
  String image = '';
  Map map = {};
  num total = 0;
  bool buynow = false;
  bool waitresponse = false;
  String msg1 = '';
  String success = '';
  bool loading = false;
  String msg = '';
  bool error = false;
  List response = [];

  addTocart(this.sendCartRepository);

  void clearList() {
    Clickedfood.clear();
    extras.clear();
  }

  void getClickedfood() {
    food = Clickedfood[0];
    amount = Clickedfood[2];
    image = Clickedfood[1];
    maplist();

    loading = true;
    notifyListeners();
  }

  void maplist() {
    cart.clear();
    cartList.clear();
    cart.add(food);
    cart.add(amount);
    cart.add(extras);
    cart.add(multiple);
    cart.add(total);
    cart.add(image);

    cartList.addAll(cart);

    notifyListeners();
  }

  void removecart(index) {
    if (index < 1) {
      for (var i = index + 5; index - 1 < i; i--) {
        cartList.removeAt(i);
      }
    } else {
      for (var i = index * 6 + 5; index * 6 - 1 < i; i--) {
        cartList.removeAt(i);
      }
    }
    notifyListeners();
  }

  void checkbuy() {
    buynow = false;

    notifyListeners();
  }

  Future<void> sendcart() async {
    final prefs = await SharedPreferences.getInstance();
    var ID;
    String? token = prefs.getString("tokenregistered");
    if (token != null) {
      ID = prefs.getString('email');
    } else {
      ID = prefs.getInt("ID");
      print(ID);
    }

    CartModel cartdata = CartModel(
        id: ID.toString(),
        food: food,
        amount: amount.toString(),
        extras: extras,
        multiple: multiple.toString(),
        total: total.toString(),
        version: 2,
        image: image);
    loading = true;
    response = await sendCartRepository.sendcartresponse(cartdata);

    msg = response[0][0];
    error = response[1][0];
    loading = false;
    notifyListeners();
  }

  void update(calculatemeal calculatmeal) {
    Clickedfood = calculatmeal.clickedfood;
    extras = calculatmeal.total1();
    multiple = calculatmeal.dupplicate;
    total = calculatmeal.total();
  }
}

class showrecent with ChangeNotifier {
  int index = 0;
  int group = 0;

  showindex(index1) {
    index = index1;
    group = index1;

    notifyListeners();
  }

  disposeint() {
    index = 0;
    group = 0;
  }
}
