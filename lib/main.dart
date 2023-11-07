import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:foodie/core/service/locator.dart';
import 'package:foodie/features/Firstcheck/presentation/pages/nonetwork.dart';
import 'package:foodie/features/Firstcheck/presentation/pages/onboarding.dart';
import 'package:foodie/features/Firstcheck/presentation/provider/firstcheckprovider.dart';
import 'package:foodie/features/SelectExtrafood/presentation/pages/review.dart';
import 'package:foodie/features/auth/presentation/pages/login.dart';
import 'package:foodie/features/auth/presentation/pages/register.dart';
import 'package:foodie/features/auth/presentation/provider/auth_provider.dart';
import 'package:foodie/features/changeaddress/presentation/provider/changeAddress.dart';
import 'package:foodie/features/collecttime%20/presentation/Provider/getTimeProvider.dart';
import 'package:foodie/features/getfoodfeed/presentation/pages/index.dart';
import 'package:foodie/features/getfoodfeed/presentation/provider/getfoodfeed_state.dart';
import 'package:foodie/features/getslide/presentation/provider/getslideprovider.dart';
import 'package:foodie/features/notification/presentation/provider/NotificationPro.dart';
import 'package:foodie/features/orderfood/presentation/pages/cart.dart';
import 'package:foodie/features/orderfood/presentation/pages/confirmpayment.dart';
import 'package:foodie/features/orderfood/presentation/provider/getCart.dart';
import 'package:foodie/features/orders/presentation/provider/GetOrder.dart';
import 'package:foodie/features/userdetails/presentation/pages/theme.dart';
import 'package:foodie/features/userdetails/presentation/provider/getidprovider.dart';
import 'package:foodie/features/userdetails/presentation/provider/getregisteredId.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/theme/themeprovider.dart';
import 'features/SelectExtrafood/presentation/provider/calculate.dart';
import 'features/SelectExtrafood/presentation/provider/getExtraprovider.dart';
import 'features/addTocart/presentation/provider/AddTocart.dart';
import 'features/getfoodfeed/presentation/provider/specialfood.dart';
import 'features/notification/presentation/pages/notification.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  final value = pref.getString('token');
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setup();
  runApp(MyApp(logged: value));
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp({super.key, required this.logged});
  String? logged;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initialization());
  }

  bool hasInternet = false;
  void initialization() async {
    final hasInternet1 = await InternetConnectionChecker().hasConnection;
    setState(() {
      hasInternet = hasInternet1;
    });

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => firstcheckprovider(locator())),
        ChangeNotifierProvider(create: (context) => AuthProvider(locator())),
        ChangeNotifierProvider(create: (context) => GetIdprovider(locator())),
        ChangeNotifierProvider(
            create: (context) => GetregisteredIdprovider(locator())),
        ChangeNotifierProvider(create: (context) => GetTimePro(locator())),
        ChangeNotifierProvider(create: (context) => NotificationPro(locator())),
        ChangeNotifierProvider(
            create: (context) => getspecialfoodprovider(locator())),
        ChangeNotifierProvider(create: (context) => calculatemeal()),
        ChangeNotifierProvider(
            create: (context) => Getslideprovider(locator())),
        ChangeNotifierProvider(create: (context) => getfoodprovider(locator())),
        ChangeNotifierProvider(
            create: (context) => GetExtraprovider(locator())),
        ChangeNotifierProvider(
            create: (context) => ChangeAddressPro(locator())),
        ChangeNotifierProvider(create: (context) => GetOrderPro(locator())),
        ChangeNotifierProxyProvider<calculatemeal, addTocart>(
            create: (context) => addTocart(locator()),
            update: (BuildContext context, calculatemeal calculatmeal,
                addTocart? addocart) {
              addocart!.update(calculatmeal);
              return addocart;
            }),
        ChangeNotifierProxyProvider2<GetregisteredIdprovider, GetIdprovider,
                GetCartPro>(
            create: (context) => GetCartPro(locator()),
            update: (BuildContext context,
                GetregisteredIdprovider getregisteredIdprovider,
                GetIdprovider getIdprovider,
                GetCartPro? getCartPro) {
              getCartPro!.update(getIdprovider, getregisteredIdprovider);
              return getCartPro;
            }),
        ChangeNotifierProvider(
            create: (context) => Themeprovider(),
            builder: (context, _) {
              return MaterialApp(
                  title: 'Foodie',
                  navigatorObservers: [FlutterSmartDialog.observer],
                  builder: FlutterSmartDialog.init(),
                  initialRoute: '/',
                  themeMode: context.watch<Themeprovider>().getTheme(),
                  theme: myTheme.lighttheme,
                  darkTheme: myTheme.darktheme,
                  routes: {
                    '/': (context) => hasInternet
                        ? widget.logged != null
                            ? const homelanding()
                            : const onBoarding()
                        : const nonetwork(),
                    '/landingpage': (context) => const homelanding(),
                    '/review': (context) => const Review(),
                    '/theme': (context) => const themepage(),
                    '/login': (context) => const login(),
                    '/register': (context) => const register(),
                    '/cart': (context) => const cart(),
                    '/notifications': (context) => const notification(),
                    '/confirmorder': (context) => const confirmorder(),
                  });
            }),
      ],
    );
  }
}
