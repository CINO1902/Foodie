import 'dart:developer';
import 'package:foodie/features/notification/data/repositories/notification_repo.dart';

abstract class NotificationRepo {
  Future<List<Map<String, dynamic>>> notification(page);
}

class NotificationRepoImpl implements NotificationRepo {
  final NotificationDatasource notificationDatasource;

  NotificationRepoImpl(this.notificationDatasource);
  @override
  Future<List<Map<String, dynamic>>> notification(page) async {
    List<Map<String, dynamic>> returnresponse = [];
    try {
      returnresponse = await notificationDatasource.notification(page);
      
    } catch (e) {
      log(e.toString());
    }
    return returnresponse;
  }
}
