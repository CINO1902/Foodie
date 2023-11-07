import 'dart:developer';

import 'package:foodie/features/getfoodfeed/data/repositories/getfooddatasource.dart';

abstract class GetfoodRepository {
  Future<List<List>> getDatasource();
  Future<List<List>> getcustomfood();
}

class GetfoodDataimp implements GetfoodRepository {
  final GetfoodDataSource getfoodDataSource;

  GetfoodDataimp(this.getfoodDataSource);

  @override
  Future<List<List>> getDatasource() async {
    List<List> result = [];
    print('getting food from repo');
    try {
      result = await getfoodDataSource.getDatasource();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    return result;
  }

  @override
  Future<List<List>> getcustomfood() async {
    List<List> result = [];
    try {
      result = await getfoodDataSource.getcustomfood();
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}
