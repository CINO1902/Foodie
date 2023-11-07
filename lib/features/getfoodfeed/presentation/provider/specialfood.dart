import 'package:flutter/material.dart';

import 'package:foodie/features/getfoodfeed/data/models/specialfood.dart';
import 'package:foodie/features/getfoodfeed/domain/repositories/getfood_repo.dart';

class getspecialfoodprovider extends ChangeNotifier {
  final GetfoodRepository getfoodRepository;

  getspecialfoodprovider(this.getfoodRepository);
  List<Msg> foodItem = [];
  List returnvalues = [];
  bool error = false;
  bool loading = false;
  Future<void> getfood() async {
    loading = true;
    returnvalues = await getfoodRepository.getcustomfood();

    foodItem = returnvalues[0];
    error = returnvalues[1][0];
    loading = false;
    notifyListeners();
  }
}
