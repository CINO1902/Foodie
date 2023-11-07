import 'dart:async';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutter_svg/svg.dart';
import 'package:badges/badges.dart' as badges;
import 'package:foodie/features/getfoodfeed/presentation/provider/getfoodfeed_state.dart';
import 'package:foodie/features/getslide/presentation/provider/getslideprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/usecases/customesnackbar.dart';
import '../../../../core/usecases/refreshwidget.dart';
import '../../../SelectExtrafood/presentation/provider/calculate.dart';
import '../../../SelectExtrafood/presentation/provider/getExtraprovider.dart';
import '../../../orderfood/presentation/provider/getCart.dart';
import '../../../orders/presentation/provider/GetOrder.dart';
import '../../../userdetails/presentation/pages/addnewperaddress.dart';
import '../../../userdetails/presentation/provider/getidprovider.dart';
import '../../../userdetails/presentation/provider/getregisteredId.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as Svg;
import '../../data/models/getfoodmodel.dart';
import '../../data/models/specialfood.dart';
import '../provider/specialfood.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with SingleTickerProviderStateMixin {
  List<String> cartmain = [];
  bool hasInternet = false;

  late StreamSubscription subscription;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    await context.read<Getslideprovider>().actionbtn();
    await context.read<GetIdprovider>().getID();
    await context.read<getfoodprovider>().getfood();
    await context.read<getspecialfoodprovider>().getfood();
    await context.read<GetIdprovider>().getaddress();
    context.read<GetOrderPro>().getorder();
    context.read<GetCartPro>().getCart();
    checkregistered();
  }

  String? mtoken = "";

  String? token;

  bool network = false;
  checkregistered() async {
    final prefs = await SharedPreferences.getInstance();
    // context.read<checkcart>().checkcarts();
    // context.read<checkcart>().checkcartforcart();

    setState(() {
      token = prefs.getString("tokenregistered");
    });

    if (token != null) {
      context.read<GetregisteredIdprovider>().getregisteredID();
    }
  }

  late final TabController controller = TabController(length: 3, vsync: this)
    ..addListener(() {
      setState(() {});
    });
  final ScrollController control = ScrollController();

  bool loading = true;
  String sucess = '';

  List<Widget> generateimage() {
    return context
        .watch<Getslideprovider>()
        .itemsslide
        .map((e) => ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: e ?? '',
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ))
        .toList();
  }

  int index1 = 0;
  double containtop = 50.0;
  double secondcontaintop = 20;
  changemargin() {
    setState(() {
      containtop = 0;
      secondcontaintop = 0;
    });
  }

  Timer? t;
  runcode() {
    t = Timer(Duration(milliseconds: 100), () {
      changemargin();
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  List<Item> items = [];
  List<Msg> data = [];
  @override
  Widget build(BuildContext context) {
    final getinforegistered = context.read<GetregisteredIdprovider>();
    final getinfounregistered = context.read<GetIdprovider>();
    final getfood = context.read<getfoodprovider>();
   
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.18,
            width: double.infinity,
            child: SafeArea(
              top: true,
              bottom: false,
              maintainBottomViewPadding: false,
              child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          token != null
                              ? SizedBox(
                                  height: 30,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      getinforegistered.firstname != ''
                                          ? 'Hello ${getinforegistered.firstname.split(' ')[0].capitalize()}'
                                          : 'Hello',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              : getinfounregistered.notloggedname == ''
                                  ? const Text(
                                      'Hello User',
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : SizedBox(
                                      height: 30,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: FittedBox(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Hello ${getinfounregistered.notloggedname.split(' ')[0].capitalize()}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.43,
                              child: const Text(
                                'Satisfy your cravings with a few taps - Order now on our food delivery app',
                                softWrap: true,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => addAddressper()));
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 35,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Center(
                                      child: SvgPicture.asset(
                                    'images/svg/Group18.svg',
                                    color: Colors.white,
                                    width: 23,
                                    height: 23,
                                  )),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      minWidth: 50,
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.35),
                                  child: token != null
                                      ? getinforegistered.checkaddress()
                                          ? SizedBox(
                                              child: Text(
                                                getinforegistered.address,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(),
                                              ),
                                            )
                                          : Text(
                                              'Set Location',
                                            )
                                      : getinfounregistered.notloggedaddress !=
                                              ''
                                          ? SizedBox(
                                              child: Text(
                                                getinfounregistered
                                                    .notloggedaddress,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(),
                                              ),
                                            )
                                          : Text(
                                              'Set Location',
                                            ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/cart');
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: badges.Badge(
                                      badgeContent: Text(
                                        context
                                            .watch<GetCartPro>()
                                            .cartresult
                                            .length
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: Center(
                                          child: SvgPicture.asset(
                                        'images/svg/Vector.svg',
                                        color: Colors.white,
                                        width: 23,
                                        height: 23,
                                      )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Cart',
                                    // style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ))
                        ],
                      )
                    ],
                  )),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: InkWell(
              onTap: () {
                if (loading == false) {
                  if (Platform.isIOS) {
                    if (context.watch<Getslideprovider>().linkios[index1] !=
                        '') {
                      whatsapp(
                          context.watch<Getslideprovider>().linkios[index1]);
                    }
                  } else if (Platform.isAndroid) {
                    if (context.watch<Getslideprovider>().linkandroid[index1] !=
                        '') {
                      whatsapp(context
                          .watch<Getslideprovider>()
                          .linkandroid[index1]);
                    }
                  }
                }
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.86,
                height: 190,
                child: Card(
                  elevation: 2.7,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: context.watch<Getslideprovider>().loading == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : CarouselSlider(
                          items: generateimage(),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            disableCenter: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                index1 = index;
                              });
                            },
                            scrollDirection: Axis.horizontal,
                          )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                ActionChip(
                  backgroundColor: controller.index == 0
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorDark.withOpacity(.1),
                  shape: const StadiumBorder(),
                  onPressed: () {
                    controller.animateTo(0);
                  },
                  label: Text(
                    "Quick buy",
                    style: controller.index == 0
                        ? TextStyle(color: Theme.of(context).primaryColorLight)
                        : TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(.7)),
                  ),
                ),
                const SizedBox(width: 15),
                ActionChip(
                  backgroundColor: controller.index == 1
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorDark.withOpacity(.1),
                  shape: const StadiumBorder(),
                  onPressed: () {
                    controller.animateTo(1);
                  },
                  label: Text(
                    "Special offer",
                    style: controller.index == 1
                        ? TextStyle(
                            color: Theme.of(context).primaryColorLight,
                          )
                        : TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(.7)),
                  ),
                ),
                const SizedBox(width: 15),
                ActionChip(
                  backgroundColor: controller.index == 2
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColorDark.withOpacity(.1),
                  shape: const StadiumBorder(),
                  onPressed: () {
                    controller.animateTo(2);
                    runcode();
                  },
                  label: Text(
                    "Recommended",
                    style: controller.index == 2
                        ? TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          )
                        : TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(.7)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.06),
              child: TabBarView(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Consumer<getfoodprovider>(builder: (context, value, child) {
                    if (value.loading == true) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    } else if (value.error == true) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Something Went wrong',
                              style: TextStyle(fontSize: 17),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                await getfood.getfood();
                              },
                              child: Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Retry",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 63, 63, 63),
                                          fontSize: 18),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      items = value.foodItem
                          .where((element) => element.extraable == false)
                          .toList();

                      return RefreshWidget(
                        control: control,
                        onRefresh: () async {
                          // await checkregistered();
                        },
                        child: GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          primary: Platform.isAndroid ? true : false,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 4 / 5,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 20),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/review');

                                context.read<calculatemeal>().itemclick(
                                    items[index].item,
                                    items[index].imageUrl,
                                    int.parse(items[index].mincost),
                                    int.parse(items[index].mincost),
                                    items[index].itemId,
                                    items[index].maxspoon);
                                context
                                    .read<GetExtraprovider>()
                                    .getExtra(items[index].itemId);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Theme.of(context).primaryColor,
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Svg.Svg('images/svg/Pattern-7.svg',
                                        size: Size(400, 200)),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: items[index].imageUrl,
                                          fit: BoxFit.fill,
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          width: 150,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Text(
                                        items[index].item,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Text(
                                        'Min: ${items[index].mincost}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'See Details',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Center(
                                              child: SvgPicture.asset(
                                            'images/svg/Group19.svg',
                                            width: 23,
                                            height: 23,
                                          )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }),
                  //second Tab
                  Consumer<getspecialfoodprovider>(
                      builder: (context, value, child) {
                    if (value.loading == true) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    } else if (value.error == true) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Something Went wrong',
                              style: TextStyle(fontSize: 17),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                await context
                                    .read<getspecialfoodprovider>()
                                    .getfood();
                              },
                              child: Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Retry",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 63, 63, 63),
                                          fontSize: 18),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      data = value.foodItem
                          .where((element) =>
                              element.availability == true ||
                              element.remaining == true)
                          .toList();

                      return RefreshWidget(
                        control: control,
                        onRefresh: () async {
                          await context
                              .read<getspecialfoodprovider>()
                              .getfood();
                        },
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          primary: Platform.isAndroid ? true : false,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const Reviewspecial()));

                                // context.read<meal_calculate>().itemclick(
                                //     data[index].offerName,
                                //     data[index].image,
                                //     data[index].description,
                                //     data[index].time,
                                //     data[index].value,
                                //     data[index].side,
                                //     data[index].food,
                                //     data[index].drink,
                                //     data[index].extras,
                                //     data[index].foodTras,
                                //     data[index].drinksTras,
                                //     data[index].offerId,
                                //     data[index].availability,
                                //     data[index].remainingvalue,
                                //     data[index].drinktype);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20),
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Theme.of(context).primaryColor,
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Svg.Svg('images/svg/Pattern-7.svg',
                                        size: Size(400, 200)),
                                  ),
                                ),
                                child: Row(children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: data[index].image,
                                      fit: BoxFit.fill,
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      width: 100,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.2,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 20,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .5,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: FittedBox(
                                            child: Text(
                                              data[index].offerName,
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Text(
                                          data[index].description,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '₦ ${data[index].value.toString()}',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Container(
                                              height: 25,
                                              width: 50,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  color: Colors.white),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: FittedBox(
                                                  child: Text(
                                                    'Buy now',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ]),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }),
                  //third tab
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 800),
                            margin: EdgeInsets.only(top: containtop),
                            child: Text(
                              'Recomendation is not yet Available',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 900),
                            margin: EdgeInsets.only(top: secondcontaintop),
                            child: Text(
                              "We would let you know \n when it's ready",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Platform.isAndroid
              ? SizedBox(
                  height: 0,
                )
              : SizedBox(
                  height: 100,
                )
        ],
      ),
    );
  }

  whatsapp(link) async {
    try {
      if (await canLaunchUrl(Uri.parse(link))) {
        await launchUrl(Uri.parse(link));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomeSnackbar(
            topic: 'Oh Snap!',
            msg: 'Something went wrong',
            color1: const Color.fromARGB(255, 171, 51, 42),
            color2: const Color.fromARGB(255, 127, 39, 33),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ));
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: CustomeSnackbar(
          topic: 'Oh Snap!',
          msg: 'Whatsapp is not installed',
          color1: const Color.fromARGB(255, 171, 51, 42),
          color2: const Color.fromARGB(255, 127, 39, 33),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ));
    }
  }
}
