// ignore: file_names
import 'dart:developer';

import 'package:foodie/features/SelectExtrafood/data/repositories/extrafood_repo.dart';

abstract class ExtrafoodRepository {
  Future<List<List>> getEstras(canceltoken, id);
}

class ExtrafoodImp implements ExtrafoodRepository {
  final ExtrafoodDataSource extrafoodDataSource;

  ExtrafoodImp(this.extrafoodDataSource);
  @override
  Future<List<List>> getEstras(canceltoken, id) async {
    List<List> result = [];
    try {
      result = await extrafoodDataSource.getEstras(canceltoken, id);
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}
