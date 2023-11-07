import 'package:flutter/material.dart';

import 'package:foodie/features/getslide/domain/repositories/slide_repository.dart';

class Getslideprovider extends ChangeNotifier {
  final Sliderepository sliderepo;
  Getslideprovider(this.sliderepo);
  bool loading = true;
  List result = [];
  List itemsslide = [];
  List linkios = [];
  List linkandroid = [];
  String sucess = '';
  Future<List> actionbtn() async {
    result = await sliderepo.getSlide();
    linkandroid = result[1];
    itemsslide = result[0];
    linkios = result[2];
    sucess = result[3];
    loading = false;
    notifyListeners();
    return result;
  }
}
