import 'package:flutter/material.dart';
import 'package:foodie/features/orders/domain/repositories/order_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/fetchcartmodel.dart';
import '../../data/models/ordermodel.dart';

class GetOrderPro extends ChangeNotifier {
  final OrderRepo orderRepo;

  GetOrderPro(this.orderRepo);
  List<Pagnited> fetchresult = [];
  List<Pagnited> orderesult = [];
  bool isloadmore = false;
  bool hasnextpage = true;
  bool loading = true;
  int page = 1;
  List selected = [0];
  List<List<dynamic>> itemsquote = [];
  void getindex(index) {
    selected.clear();
    selected.add(index);
    notifyListeners();
  }

  void clearresult() {
    orderesult.clear();
    fetchresult.clear;
    notifyListeners();
  }

  Future<void> getorder() async {
    loading = true;
    orderesult.clear();
    fetchresult.clear;
    final prefs = await SharedPreferences.getInstance();
    int? ID = prefs.getInt("ID");
    String id = ID.toString();
    String email = prefs.getString("email") ?? '';
    FetchcartModel getfetchmodel() {
      FetchcartModel fetchmodel = FetchcartModel(id: id, email: email);

      if (selected.contains(0)) {
        fetchmodel = FetchcartModel(id: id, email: email);
      } else if (selected.contains(1)) {
        fetchmodel = FetchcartModel(id: '', email: email);
      } else if (selected.contains(2)) {
        fetchmodel = FetchcartModel(id: id, email: '');
      }
      return fetchmodel;
    }

    final returnresponse = await orderRepo.getorder(page, getfetchmodel());

    final data = CartRecieveModel.fromJson(returnresponse[0]);

    fetchresult = data.result.pagnited;

    fetchresult.sort((a, b) => b.date.compareTo(a.date));

    orderesult
        .addAll(fetchresult.where((element) => element.order == true).toList());
    final loadmore = data.result.next;

    if (loadmore.page == page) {
      hasnextpage = false;
    } else {
      hasnextpage = true;
    }
    for (var i = 0; i < orderesult.length; i++) {
      var productMap = [orderesult[i].status, orderesult[i].ordernum];
      itemsquote.add(productMap);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> loadmore() async {
    final prefs = await SharedPreferences.getInstance();
    int? ID = prefs.getInt("ID");
    String id = ID.toString();
    String email = prefs.getString("email") ?? '';
    FetchcartModel getfetchmodel() {
      FetchcartModel fetchmodel = FetchcartModel(id: id, email: email);

      if (selected.contains(0)) {
        fetchmodel = FetchcartModel(id: id, email: email);
      } else if (selected.contains(1)) {
        fetchmodel = FetchcartModel(id: '', email: email);
      } else if (selected.contains(2)) {
        fetchmodel = FetchcartModel(id: id, email: '');
      }
      return fetchmodel;
    }

    if (hasnextpage == true && isloadmore == false && loading == false) {
      isloadmore = true;
      page += 1;
      print(page);
      notifyListeners();
      final returnresponse = await orderRepo.getorder(page, getfetchmodel());

      final data = CartRecieveModel.fromJson(returnresponse[0]);

      fetchresult = data.result.pagnited;

      fetchresult.sort((a, b) => b.date.compareTo(a.date));

      orderesult.addAll(
          fetchresult.where((element) => element.order == true).toList());
      final loadmore = data.result.next;
      if (loadmore.page == page) {
        hasnextpage = false;
      } else {
        hasnextpage = true;
      }
      for (var i = 0; i < orderesult.length; i++) {
        var productMap = [orderesult[i].status, orderesult[i].ordernum];
        itemsquote.add(productMap);
      }
      isloadmore = false;
      notifyListeners();
    }
  }
}
