import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:foodie/features/userdetails/presentation/provider/getidprovider.dart';
import 'package:foodie/features/userdetails/presentation/provider/getregisteredId.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:grouped_list/grouped_list.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as Svg;

import '../../../collecttime /presentation/Provider/getTimeProvider.dart';

import '../../data/models/notification.dart';
import '../provider/NotificationPro.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  String? token;

  checkregistered() async {
    context.read<NotificationPro>().getNotification();
    final prefs = await SharedPreferences.getInstance();
    context.read<GetIdprovider>().getaddress();
    setState(() {
      token = prefs.getString("tokenregistered");
    });
  }

  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  late ScrollController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkregistered();
    controller = ScrollController()
      ..addListener(() {
        if (controller.position.maxScrollExtent == controller.position.pixels) {
          context.read<NotificationPro>().loadmorenotify();
        }
      });
  }

  bool toggle = false;
  bool network = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Notification',
          style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 27,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<NotificationPro>(builder: (context, value, child) {
        if (value.loading == true) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                )),
          );
        } else {
          if (value.notify.isEmpty) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'You have no notifications yet',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(children: [
                Expanded(
                  child: GroupedListView<Pagnitednotify, DateTime>(
                      controller: controller,
                      shrinkWrap: true,
                      groupBy: (Pagnitednotify element) => DateTime(
                            element.date.year,
                            element.date.month,
                            element.date.day,
                          ),
                      itemComparator:
                          (Pagnitednotify element1, Pagnitednotify element2) =>
                              element2.date.compareTo(element1.date),
                      groupComparator: (DateTime value1, DateTime value2) =>
                          value2.compareTo(value1),
                      groupSeparatorBuilder: (DateTime date) {
                        DateTime? currentdate =
                            context.watch<GetTimePro>().date;

                        final day = date.day;
                        final currentday = currentdate.day;
                        Duration diff = currentdate.difference(date);
                        String date1 = '';
                        print(diff.inHours);
                        if (diff.inHours > 0 && diff.inHours < 23) {
                          date1 = 'Today';
                        } else if (diff.inHours > 24 && diff.inHours < 47) {
                          date1 = 'Yesterday';
                        } else if ((currentday - day) > 1) {
                          date1 =
                              '${date.day}, ${months[date.month - 1]} ${date.year}';
                        } else {
                          date1 =
                              '${date.day}, ${months[date.month - 1]} ${date.year}';
                        }

                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              date1,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                      order: GroupedListOrder.ASC,
                      floatingHeader: true,
                      elements: value.notify,
                      itemBuilder: (context, element) {
                        if (element.notificationType == 1) {
                          return Notificationtype1(context, element.discount,
                              element.coupon, element.date);
                        } else if (element.notificationType == 2) {
                          return Notificationtype2(context, element.date,
                              element.discount, element.coupon);
                        } else if (element.notificationType == 3) {
                          return Notificationtype3(context, element.date);
                        } else if (element.notificationType == 4) {
                          return Notificationtype4(
                              context, element.date, element.amountDaily);
                        } else if (element.notificationType == 5) {
                          return Notificationtype5(
                              context, element.date, element.amountweekly);
                        } else if (element.notificationType == 6) {
                          return Notificationtype6(context, element.date);
                        } else if (element.notificationType == 7) {
                          return Notificationtype7(context, element.date);
                        } else if (element.notificationType == 8) {
                          return Notificationtype8(context, element.date);
                        } else if (element.notificationType == 9) {
                          return Notificationtype9(context, element.date);
                        } else if (element.notificationType == 10) {
                          return Notificationtype10(context, element.date,
                              element.paymentAmount, element.ordernum);
                        } else if (element.notificationType == 11) {
                          return Notificationtype11(
                              context, element.date, element.paymentAmount);
                        } else if (element.notificationType == 12) {
                          return Notificationtype12(context, element.date);
                        } else if (element.notificationType == 13) {
                          return Notificationtype13(context, element.date,
                              element.discount, element.coupon);
                        } else {
                          return Container();
                        }
                      }),
                ),
                context.watch<NotificationPro>().isloadmore == true
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 30),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        ))
                    : Container(),
                context.watch<NotificationPro>().hasnextpage == false
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 0),
                        child: Container(
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.amber),
                          child: Center(
                              child: Text(
                            'You have fetched all content',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                          )),
                        ),
                      )
                    : Container()
              ]),
            );
          }
        }
      }),
    );
  }

  Container Notificationtype1(
      BuildContext context, discount, coupon, DateTime date1) {
    final currentdate = context.watch<GetTimePro>().date;
    String formattedTime = DateFormat.jm().format(date1);
    Duration diff = currentdate.difference(date1);
    String date = '';
    if (diff.inSeconds < 59) {
      date = 'Just now';
    } else if (diff.inMinutes >= 1 && diff.inMinutes < 59) {
      date = '${diff.inMinutes} minute ago';
    } else if (diff.inHours >= 1 && diff.inHours < 23) {
      date = '${diff.inHours} hour ago';
    } else if (diff.inHours > 24) {
      date = formattedTime;
    }
    return Container(
      margin: EdgeInsets.only(
          bottom: 10,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Svg.Svg('images/svg/Pattern-7.svg', size: Size(400, 200)),
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColorLight,
            BlendMode.difference,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'images/logo.png',
              height: 30,
              width: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: token == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hello ${context.watch<GetIdprovider>().notloggedname}, Thank you for your recent order, we hope to see you back again soon. As a courtesy for your trust we have a special offer waiting for you - Take ₦1000 of your next order with the coupon code below.',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Clipboard.setData(
                                ClipboardData(text: coupon));
                            _showToast();
                            HapticFeedback.mediumImpact();
                          },
                          child: Text(
                            '$coupon',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              toggle = !toggle;
                            });
                          },
                          child: toggle
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    formattedTime,
                                  ),
                                )
                              : Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    date,
                                  ),
                                ),
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hello ${context.watch<GetregisteredIdprovider>().firstname}, Thank you for your recent order, we hope to see you back again soon. As a courtesy for your trust we have a special offer waiting for you - Take $discount of your next order with the coupon code below.',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Clipboard.setData(
                                ClipboardData(text: coupon));
                            _showToast();
                            HapticFeedback.mediumImpact();
                          },
                          child: Text(
                            '$coupon',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              toggle = !toggle;
                            });
                          },
                          child: toggle
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    formattedTime,
                                  ),
                                )
                              : Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    date,
                                  ),
                                ),
                        )
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }

  Container Notificationtype2(
      BuildContext context, DateTime date1, discount, coupon) {
    final currentdate = context.watch<GetTimePro>().date;
    String formattedTime = DateFormat.jm().format(date1);
    Duration diff = currentdate.difference(date1);
    String date = '';
    if (diff.inSeconds < 59) {
      date = 'Just now';
    } else if (diff.inMinutes >= 1 && diff.inMinutes < 59) {
      date = '${diff.inMinutes} minute ago';
    } else if (diff.inHours >= 1 && diff.inHours < 23) {
      date = '${diff.inHours} hour ago';
    } else if (diff.inHours > 24) {
      date = formattedTime;
    }
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(
          bottom: 10,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      //height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Svg.Svg('images/svg/Pattern-7.svg', size: Size(400, 200)),
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColorLight,
            BlendMode.difference,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'images/logo.png',
            height: 30,
            width: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                token == null
                    ? Text(
                        'Hello ${context.watch<GetIdprovider>().notloggedname}, Thank you for your recent order, we hope to see you back again soon. As a courtesy for your trust we have a special offer waiting for you - Take $discount% of your next order with the coupon code below',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                        softWrap: true,
                      )
                    : Text(
                        'Hello ${context.watch<GetregisteredIdprovider>().firstname}, Thank you for your recent order, we hope to see you back again soon. As a courtesy for your trust we have a special offer waiting for you - Take $discount% of your next order with the coupon code below',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                        softWrap: true,
                      ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: coupon));
                    _showToast();
                    HapticFeedback.mediumImpact();
                  },
                  child: Text(
                    '$coupon',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      toggle = !toggle;
                    });
                  },
                  child: toggle
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            formattedTime,
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            date,
                          ),
                        ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container Notificationtype3(BuildContext context, DateTime date1) {
    final currentdate = context.watch<GetTimePro>().date;
    String formattedTime = DateFormat.jm().format(date1);
    Duration diff = currentdate.difference(date1);
    String date = '';
    if (diff.inSeconds < 59) {
      date = 'Just now';
    } else if (diff.inMinutes >= 1 && diff.inMinutes < 59) {
      date = '${diff.inMinutes} minute ago';
    } else if (diff.inHours >= 1 && diff.inHours < 23) {
      date = '${diff.inHours} hour ago';
    } else if (diff.inHours > 24) {
      date = formattedTime;
    }
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(
          bottom: 10,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      //height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Svg.Svg('images/svg/Pattern-7.svg', size: Size(400, 200)),
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColorLight,
            BlendMode.difference,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'images/logo.png',
            height: 30,
            width: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                Text(
                  'Order  #082892 status has been changed to Order completed , thanks for your order',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  softWrap: true,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      toggle = !toggle;
                    });
                  },
                  child: toggle
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            formattedTime,
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            date,
                          ),
                        ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container Notificationtype4(BuildContext context, DateTime date1, amount) {
    final currentdate = context.watch<GetTimePro>().date;
    String formattedTime = DateFormat.jm().format(date1);
    Duration diff = currentdate.difference(date1);
    String date = '';
    if (diff.inSeconds < 59) {
      date = 'Just now';
    } else if (diff.inMinutes >= 1 && diff.inMinutes < 59) {
      date = '${diff.inMinutes} minute ago';
    } else if (diff.inHours >= 1 && diff.inHours < 23) {
      date = '${diff.inHours} hour ago';
    } else if (diff.inHours > 24) {
      date = formattedTime;
    }
    return Container(
      margin: EdgeInsets.only(
          bottom: 10,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Svg.Svg('images/svg/Pattern-7.svg', size: Size(400, 200)),
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColorLight,
            BlendMode.difference,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'images/logo.png',
              height: 30,
              width: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                children: [
                  token == null
                      ? Text(
                          'Hello ${context.watch<GetIdprovider>().notloggedname}, we have a deal for you! Make an order of ₦$amount extra today and get a Coupon of ₦1000 off your next order',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                          softWrap: true,
                        )
                      : Text(
                          'Hello ${context.watch<GetregisteredIdprovider>().firstname}, we have a deal for you! Make an order of ₦$amount extra today and get a Coupon of ₦1000 off your next order',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        toggle = !toggle;
                      });
                    },
                    child: toggle
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              formattedTime,
                            ),
                          )
                        : Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              date,
                            ),
                          ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container Notificationtype5(BuildContext context, DateTime date1, amount) {
    final currentdate = context.watch<GetTimePro>().date;
    String formattedTime = DateFormat.jm().format(date1);
    Duration diff = currentdate.difference(date1);
    String date = '';
    if (diff.inSeconds < 59) {
      date = 'Just now';
    } else if (diff.inMinutes >= 1 && diff.inMinutes < 59) {
      date = '${diff.inMinutes} minute ago';
    } else if (diff.inHours >= 1 && diff.inHours < 23) {
      date = '${diff.inHours} hour ago';
    } else if (diff.inHours > 24) {
      date = formattedTime;
    }
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(
          bottom: 10,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      //height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Svg.Svg('images/svg/Pattern-7.svg', size: Size(400, 200)),
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColorLight,
            BlendMode.difference,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'images/logo.png',
            height: 30,
            width: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                token == null
                    ? Text(
                        'Hello ${context.watch<GetIdprovider>().notloggedname}, we have a deal for you! Make an order of $amount this week and get a Coupon of 10% off your next order',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                        softWrap: true,
                      )
                    : Text(
                        'Hello ${context.watch<GetregisteredIdprovider>().firstname}, we have a deal for you! Make an order of $amount this week and get a Coupon of 10% off your next order',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                        softWrap: true,
                      ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      toggle = !toggle;
                    });
                  },
                  child: toggle
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            formattedTime,
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            date,
                          ),
                        ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container Notificationtype6(BuildContext context, DateTime date1) {
    final currentdate = context.watch<GetTimePro>().date;
    String formattedTime = DateFormat.jm().format(date1);
    Duration diff = currentdate.difference(date1);
    String date = '';
    if (diff.inSeconds < 59) {
      date = 'Just now';
    } else if (diff.inMinutes >= 1 && diff.inMinutes < 59) {
      date = '${diff.inMinutes} minute ago';
    } else if (diff.inHours >= 1 && diff.inHours < 23) {
      date = '${diff.inHours} hour ago';
    } else if (diff.inHours > 24) {
      date = formattedTime;
    }
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(
          bottom: 10,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      //height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Svg.Svg('images/svg/Pattern-7.svg', size: Size(400, 200)),
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColorLight,
            BlendMode.difference,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'images/logo.png',
            height: 30,
            width: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                Text(
                  'Hello ${context.watch<GetregisteredIdprovider>().firstname}, You have successfully created a subscription plan for the next 30 days.',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  softWrap: true,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      toggle = !toggle;
                    });
                  },
                  child: toggle
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            formattedTime,
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            date,
                          ),
                        ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container Notificationtype7(BuildContext context, DateTime date1) {
    final currentdate = context.watch<GetTimePro>().date;
    String formattedTime = DateFormat.jm().format(date1);
    Duration diff = currentdate.difference(date1);
    String date = '';
    if (diff.inSeconds < 59) {
      date = 'Just now';
    } else if (diff.inMinutes >= 1 && diff.inMinutes < 59) {
      date = '${diff.inMinutes} minute ago';
    } else if (diff.inHours >= 1 && diff.inHours < 23) {
      date = '${diff.inHours} hour ago';
    } else if (diff.inHours > 24) {
      date = formattedTime;
    }
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(
          bottom: 10,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      //height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Svg.Svg('images/svg/Pattern-7.svg', size: Size(400, 200)),
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColorLight,
            BlendMode.difference,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'images/logo.png',
            height: 30,
            width: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                Text(
                  'Hello ${context.watch<GetregisteredIdprovider>().firstname}, You have successfully Upgraded your subscription plan.',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  softWrap: true,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      toggle = !toggle;
                    });
                  },
                  child: toggle
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            formattedTime,
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            date,
                          ),
                        ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container Notificationtype8(BuildContext context, DateTime date1) {
    final currentdate = context.watch<GetTimePro>().date;
    String formattedTime = DateFormat.jm().format(date1);
    Duration diff = currentdate.difference(date1);
    String date = '';
    if (diff.inSeconds < 59) {
      date = 'Just now';
    } else if (diff.inMinutes >= 1 && diff.inMinutes < 59) {
      date = '${diff.inMinutes} minute ago';
    } else if (diff.inHours >= 1 && diff.inHours < 23) {
      date = '${diff.inHours} hour ago';
    } else if (diff.inHours > 24) {
      date = formattedTime;
    }
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(
          bottom: 10,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      //height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Svg.Svg('images/svg/Pattern-7.svg', size: Size(400, 200)),
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColorLight,
            BlendMode.difference,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'images/logo.png',
            height: 30,
            width: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                Text(
                  'Your subscription plan has been renewed.Thanks for your trust',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  softWrap: true,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      toggle = !toggle;
                    });
                  },
                  child: toggle
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            formattedTime,
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            date,
                          ),
                        ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container Notificationtype9(BuildContext context, DateTime date1) {
    final currentdate = context.watch<GetTimePro>().date;
    String formattedTime = DateFormat.jm().format(date1);
    Duration diff = currentdate.difference(date1);
    String date = '';
    if (diff.inSeconds < 59) {
      date = 'Just now';
    } else if (diff.inMinutes >= 1 && diff.inMinutes < 59) {
      date = '${diff.inMinutes} minute ago';
    } else if (diff.inHours >= 1 && diff.inHours < 23) {
      date = '${diff.inHours} hour ago';
    } else if (diff.inHours > 24) {
      date = formattedTime;
    }
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(
          bottom: 10,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      //height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Svg.Svg('images/svg/Pattern-7.svg', size: Size(400, 200)),
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColorLight,
            BlendMode.difference,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'images/logo.png',
            height: 30,
            width: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                Text(
                  'Your subscription plan has expired. You can create a new plan by going to the subscription page.',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  softWrap: true,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      toggle = !toggle;
                    });
                  },
                  child: toggle
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            formattedTime,
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            date,
                          ),
                        ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container Notificationtype10(
      BuildContext context, DateTime date1, amount, group) {
    final currentdate = context.watch<GetTimePro>().date;
    String formattedTime = DateFormat.jm().format(date1);
    Duration diff = currentdate.difference(date1);
    String date = '';

    if (diff.inSeconds < 59) {
      date = 'Just now';
    } else if (diff.inMinutes >= 1 && diff.inMinutes < 59) {
      date = '${diff.inMinutes} minute ago';
    } else if (diff.inHours >= 1 && diff.inHours < 23) {
      date = '${diff.inHours} hour ago';
    } else if (diff.inHours > 24) {
      date = formattedTime;
    }
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(
          bottom: 10,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      //height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Svg.Svg('images/svg/Pattern-7.svg', size: Size(400, 200)),
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColorLight,
            BlendMode.difference,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'images/logo.png',
            height: 30,
            width: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                Text(
                  'You have  successfully made a payment of ₦$amount for an Order with group ID #$group. Thanks for your patronage',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  softWrap: true,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      toggle = !toggle;
                    });
                  },
                  child: toggle
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            formattedTime,
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            date,
                          ),
                        ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container Notificationtype11(BuildContext context, DateTime date1, amount) {
    final currentdate = context.watch<GetTimePro>().date;
    String formattedTime = DateFormat.jm().format(date1);
    Duration diff = currentdate.difference(date1);
    String date = '';
    if (diff.inSeconds < 59) {
      date = 'Just now';
    } else if (diff.inMinutes >= 1 && diff.inMinutes < 59) {
      date = '${diff.inMinutes} minute ago';
    } else if (diff.inHours >= 1 && diff.inHours < 23) {
      date = '${diff.inHours} hour ago';
    } else if (diff.inHours > 24) {
      date = formattedTime;
    }
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(
          bottom: 10,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      //height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Svg.Svg('images/svg/Pattern-7.svg', size: Size(400, 200)),
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColorLight,
            BlendMode.difference,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'images/logo.png',
            height: 30,
            width: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                Text(
                  'Hello ${context.watch<GetregisteredIdprovider>().firstname}, Your  subscription  payment of #$amount has been received and your subscription is being processed.',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  softWrap: true,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      toggle = !toggle;
                    });
                  },
                  child: toggle
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            formattedTime,
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            date,
                          ),
                        ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container Notificationtype12(BuildContext context, DateTime date1) {
    final currentdate = context.watch<GetTimePro>().date;
    String formattedTime = DateFormat.jm().format(date1);
    Duration diff = currentdate.difference(date1);
    String date = '';
    if (diff.inSeconds < 59) {
      date = 'Just now';
    } else if (diff.inMinutes >= 1 && diff.inMinutes < 59) {
      date = '${diff.inMinutes} minute ago';
    } else if (diff.inHours >= 1 && diff.inHours < 23) {
      date = '${diff.inHours} hour ago';
    } else if (diff.inHours > 24) {
      date = formattedTime;
    }
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(
          bottom: 10,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      //height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Svg.Svg('images/svg/Pattern-7.svg', size: Size(400, 200)),
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColorLight,
            BlendMode.difference,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'images/logo.png',
            height: 30,
            width: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                token == null
                    ? Text(
                        'Hello ${context.watch<GetIdprovider>().notloggedname}, Stand a chance to win a coupon of 10% discount on any order after registering with us',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                        softWrap: true,
                      )
                    : Text(
                        'Hello ${context.watch<GetregisteredIdprovider>().firstname}, Stand a chance to win a coupon of 10% discount of any order after registering with us',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                        softWrap: true,
                      ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      toggle = !toggle;
                    });
                  },
                  child: toggle
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            formattedTime,
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            date,
                          ),
                        ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container Notificationtype13(
      BuildContext context, DateTime date1, discount, coupon) {
    final currentdate = context.watch<GetTimePro>().date;
    String formattedTime = DateFormat.jm().format(date1);
    Duration diff = currentdate.difference(date1);
    String date = '';
    if (diff.inSeconds < 59) {
      date = 'Just now';
    } else if (diff.inMinutes >= 1 && diff.inMinutes < 59) {
      date = '${diff.inMinutes} minute ago';
    } else if (diff.inHours >= 1 && diff.inHours < 23) {
      date = '${diff.inHours} hour ago';
    } else if (diff.inHours > 24) {
      date = formattedTime;
    }
    return Container(
      padding: const EdgeInsets.all(20),
      margin: EdgeInsets.only(
          bottom: 10,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      //height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Svg.Svg(
            'images/svg/Pattern-7.svg',
          ),
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColorLight,
            BlendMode.difference,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'images/logo.png',
            height: 30,
            width: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                token == null
                    ? Text(
                        'Hello ${context.watch<GetIdprovider>().notloggedname}, Thank you for registering with us, we would like to welcome you to our platform with a gift. Use the following coupon code during your next purchase #56289nbgd',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                        softWrap: true,
                      )
                    : Text(
                        'Hello ${context.watch<GetregisteredIdprovider>().firstname}, Thank you for registering with us, we would like to welcome you to our platform with a gift. Take $discount% of your next order with the coupon code below. ',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                        softWrap: true,
                      ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: coupon));
                    _showToast();
                    HapticFeedback.mediumImpact();
                  },
                  child: Text(
                    '$coupon',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      toggle = !toggle;
                    });
                  },
                  child: toggle
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            formattedTime,
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            date,
                          ),
                        ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showToast() async {
    SmartDialog.showToast('Coppied to Clipboard',
        displayType: SmartToastType.onlyRefresh);
    await Future.delayed(Duration(milliseconds: 500));
  }
}
