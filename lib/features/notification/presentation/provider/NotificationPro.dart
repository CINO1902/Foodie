import 'package:flutter/cupertino.dart';
import 'package:foodie/features/notification/data/models/notification.dart';
import 'package:foodie/features/notification/domain/repositories/Notificationrepo.dart';

class NotificationPro extends ChangeNotifier {
  final NotificationRepo notificationRepo;
  NotificationPro(this.notificationRepo);
  bool loading = false;
  bool loadmore = false;
  List<Pagnitednotify> notify = [];
  bool error = false;
  List<Map<String, dynamic>> returnresponse = [];
  int page = 1;
  bool isloadmore = false;
  bool hasnextpage = true;

  Future<void> getNotification() async {
    loading = true;
    returnresponse = await notificationRepo.notification(page);
    final status = returnresponse[0]['status'];
    if (status == 'success') {
      error = false;
    } else {
      error = true;
    }
    loading = false;
    final decodedresponse = Sendnotification.fromJson(returnresponse[0]);

    notify.addAll(decodedresponse.notific.pagnitednotify!.toList());
    notify.sort((a, b) => b.date.compareTo(a.date));
    final loadmore = decodedresponse.notific.next;
    if (loadmore.page == page) {
      hasnextpage = false;
    } else {
      hasnextpage = true;
    }
    notifyListeners();
  }

  Future<void> loadmorenotify() async {
    if (hasnextpage == true && isloadmore == false && loading == false) {
      isloadmore = true;
      page += 1;
      notifyListeners();
      returnresponse = await notificationRepo.notification(page);

      final decodedresponse = Sendnotification.fromJson(returnresponse[0]);
      isloadmore = false;
      notify.addAll(decodedresponse.notific.pagnitednotify!);
      notify.sort((a, b) => b.date.compareTo(a.date));
      final loadmore = decodedresponse.notific.next;
      if (loadmore.page == page) {
        hasnextpage = false;
      } else {
        hasnextpage = true;
      }
      notifyListeners();
    }
  }
}
