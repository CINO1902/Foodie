import 'dart:developer';

import 'package:foodie/features/collecttime%20/data/repositories/gettime_repo.dart';

abstract class GetTimeRepo {
  Future<DateTime> getTime();
}

class GetTimeRepoImpl implements GetTimeRepo {
  final GetTimeDatasource getTimeDatasource;

  GetTimeRepoImpl(this.getTimeDatasource);

  @override
  Future<DateTime> getTime() async {
    DateTime date = DateTime.now();
    try {
      date = await getTimeDatasource.getTime();
    } catch (e) {
      log(e.toString());
    }
    return date;
  }
}
