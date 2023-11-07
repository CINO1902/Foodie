import 'dart:developer';

import 'package:foodie/features/Firstcheck/data/repositories/firstcheckrepo.dart';

abstract class Firscheckrepository {
  Future<List<dynamic>> createnonusertoken();
}

class Firstcheckimp implements Firscheckrepository {
  final FirscheckDatasource firstDatasource;

  Firstcheckimp(this.firstDatasource);
  @override
  Future<List<dynamic>> createnonusertoken() async {
    List result = [];
    try {
      result = await firstDatasource.createnonusertoken();
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}
