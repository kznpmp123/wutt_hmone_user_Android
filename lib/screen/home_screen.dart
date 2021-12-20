import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/screen/view/cart.dart';
import 'package:kozarni_ecome/screen/view/hot.dart';
import 'package:kozarni_ecome/screen/view/home.dart';
import 'package:kozarni_ecome/widgets/bottom_nav.dart';
import 'package:url_launcher/url_launcher.dart';

import 'view/profile.dart';

List<Widget> _template = [
  HomeView(),
  HotView(),
  CartView(),
  ProfileView(),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin? fltNotification;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notitficationPermission();
    initMessaging();
  }

  void notitficationPermission() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void initMessaging() async {

    var androiInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    var iosInit = IOSInitializationSettings(requestAlertPermission: true,requestBadgePermission: true,requestSoundPermission: true,);

    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);

    fltNotification = FlutterLocalNotificationsPlugin();

    fltNotification!.initialize(initSetting);


    if (messaging != null) {
      print('vvvvvvv');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);

    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
    });
  }


  void showNotification(RemoteMessage message) async {
    var androidDetails = AndroidNotificationDetails('1', message.notification!.title ?? '',icon: '@mipmap/ic_launcher',color:  Color(0xFF0f90f3),);
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);
    await fltNotification!.show(0, message.notification!.title ?? '',
        message.notification!.body ?? '',generalNotificationDetails,
        payload: 'Notification');
  }


  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        title: Text(
          "Wutt Hmone",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: appBarTitleColor,
          ),
        ),
        // centerTitle: true,
        actions: [
          // InkWell(
          //   onTap: () {
          //     ///TODO
          //   },
          //   child: Container(
          //     margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
          //     padding: EdgeInsets.only(left: 10, right: 10),
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(7),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.grey[200]!,
          //             spreadRadius: 1,
          //             offset: Offset(0, 1),
          //           )
          //         ]),
          //     child: Icon(
          //       Icons.search,
          //       color: Colors.black,
          //     ),
          //   ),
          // )
          Obx(
            () => controller.isSearch.value
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 50,
                    child: TextField(
                      onChanged: controller.onSearch,
                      onSubmitted: controller.searchItem,
                      decoration: InputDecoration(
                        hintText: "Search...",
                        // border: OutlineInputBorder(),
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(
                      top: 7,
                      bottom: 10,
                      right: 7,
                    ),
                    width: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        alignment: Alignment.center,
                        padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                        )),
                        overlayColor: MaterialStateProperty.all(Colors.black12),
                      ),
                      onPressed: controller.search,
                      child: FaIcon(
                        FontAwesomeIcons.search,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
          ),

          Container(
            margin: EdgeInsets.only(
              top: 7,
              bottom: 10,
              right: 7,
            ),
            width: 40,
            child: ElevatedButton(
              style: ButtonStyle(
                alignment: Alignment.center,
                padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80),
                )),
                overlayColor: MaterialStateProperty.all(Colors.black12),
              ),
              onPressed: () async {
                try {
                  await launch('https://m.me/wutthmonemyanmar');
                } catch (e) {
                  print(e);
                }
              },
              child: FaIcon(
                FontAwesomeIcons.facebookMessenger,
                color: Colors.blue,
                size: 20,
              ),
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(
          //     top: 7,
          //     bottom: 10,
          //     right: 7,
          //   ),
          //   child: ElevatedButton(
          //     style: ButtonStyle(
          //       backgroundColor: MaterialStateProperty.all(Colors.white),
          //       overlayColor: MaterialStateProperty.all(Colors.black12),
          //     ),
          //     onPressed: () async {
          //       try {
          //         await launch('https://m.me/begoniazue');
          //       } catch (e) {
          //         print(e);
          //       }
          //     },
          //     child: FaIcon(
          //       FontAwesomeIcons.facebookMessenger,
          //       color: Colors.blue,
          //     ),
          //   ),
          // )
        ],
      ),
      body: Obx(
        () => _template[controller.navIndex.value],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
