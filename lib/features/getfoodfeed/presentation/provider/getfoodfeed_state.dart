import 'package:flutter/material.dart';
import 'package:foodie/features/getfoodfeed/data/models/getfoodmodel.dart';
import 'package:foodie/features/getfoodfeed/domain/repositories/getfood_repo.dart';

class getfoodprovider extends ChangeNotifier {
  final GetfoodRepository getfoodRepository;

  getfoodprovider(this.getfoodRepository);
  List<Item> foodItem = [];
  List returnvalues = [];
  bool error = false;
  bool loading = true;
  Future<void> getfood() async {
    loading = true;
    print('getting food from provider');
    returnvalues = await getfoodRepository.getDatasource();
    foodItem = returnvalues[0];
    error = returnvalues[1][0];
    loading = false;
    notifyListeners();
  }
}
