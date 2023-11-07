import 'package:flutter/material.dart';
import 'package:foodie/features/collecttime%20/domain/repositories/getTimerepo.dart';

class GetTimePro extends ChangeNotifier {
  final GetTimeRepo getTimeRepo;

  GetTimePro(this.getTimeRepo);
  DateTime date = DateTime.now();
  Future<void> getTime() async {
    date = await getTimeRepo.getTime();
    notifyListeners();
  }
}
