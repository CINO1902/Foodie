import 'dart:developer';

import 'package:foodie/features/changeaddress/data/models/changeAddress.dart';
import 'package:foodie/features/changeaddress/data/repositories/changeaddress_repo.dart';

abstract class ChangeAddressRepo {
  Future<List> changeAddress(ChangeAddress change);
}

class ChangeAddressRepoimp implements ChangeAddressRepo {
  final ChangeAddressDataSource changeAddressDataSource;

  ChangeAddressRepoimp(this.changeAddressDataSource);
  @override
  Future<List> changeAddress(ChangeAddress change) async {
    List result = [];
    try {
      result = await changeAddressDataSource.changeAddress(change);
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}
