import 'dart:developer';

import 'package:foodie/features/userdetails/data/repositories/detailsrepo.dart';

import '../../data/models/fetchidmodel.dart';

abstract class Userdetailsrepository {
  Future<int> getId();
  Future<List<Prev>> getregisteredId();
  Future<void> sendtoken(token);
  Future<String?> getaddress();
}

class UserdetailrepoImpl implements Userdetailsrepository {
  final UserdetailsDatasource userdetailsDatasource;

  UserdetailrepoImpl(this.userdetailsDatasource);

  @override
  Future<int> getId() async {
    int response = 0;
    try {
      response = await userdetailsDatasource.getId();
    } catch (e) {
      log(e.toString());
    }
    return response;
  }

  @override
  Future<String?> getaddress() {
    // TODO: implement getaddress
    throw UnimplementedError();
  }

  @override
  Future<List<Prev>> getregisteredId() async {
    List<Prev> result = [];
    try {
      result = await userdetailsDatasource.getregisteredId();
    } catch (e) {
      log(e.toString());
    }
    return result;
  }

  @override
  Future<void> sendtoken(token) {
    // TODO: implement sendtoken
    throw UnimplementedError();
  }
}
