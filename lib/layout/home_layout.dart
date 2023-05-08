// ignore: file_names
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';
import '../shared/local_notification_service.dart';
import '../shared/styles/icon_broken.dart';

class HallaqLayoutScreen extends StatefulWidget {
  const HallaqLayoutScreen({super.key});

  @override
  State<HallaqLayoutScreen> createState() => _HallaqLayoutScreenState();
}

class _HallaqLayoutScreenState extends State<HallaqLayoutScreen> {
  var currentIndex = 0;
  late final LocalNotificationService service;
  @override
  void initState() {
    // TODO: implement initState

    BlocProvider.of<HallaqCubit>(context).Fcm();

    service = LocalNotificationService();
    service.intialize();
    listenToNotification();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(message.notification!.title.toString());
      await service
          .showNotification(
              id: 0,
              title: message.notification!.title.toString(),
              body: message.notification!.body.toString())
          .then((value) {
        Future.delayed(const Duration(seconds: 5), () {
// Here you can write your code
          MotionToast.success(
            title: message.notification!.title.toString(),
            titleStyle: TextStyle(fontWeight: FontWeight.bold),
            description: message.notification!.body.toString(),
            descriptionStyle: TextStyle(
                //overflow: TextOverflow.ellipsis,
                ),
            animationType: ANIMATION.FROM_LEFT,
            position: MOTION_TOAST_POSITION.TOP,
            borderRadius: 10.0,
            width: 300,
            height: 65,
            toastDuration: Duration(seconds: 5),
          ).show(context);
        });
      });

      // NotificationService().showNotification(1, "title", "body", 10);
      print('إشعااااااااااااااار جديد');
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print(' ${message.notification!.title}');
        print(' ${message.notification!.body}');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HallaqCubit()
        ..getProfile()
        ..Fcm(),
      child: BlocConsumer<HallaqCubit, HallaqStates>(
          listener: (BuildContext context, Object? state) {},
          builder: (BuildContext context, Object? state) {
            double displayWidth = MediaQuery.of(context).size.width;

            var cubit = HallaqCubit.get(context);

            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                // appBar: PreferredSize(
                //   preferredSize:
                //       const Size.fromHeight(55.0), // here the desired height
                //
                //   child: AppBar(
                //     title: Column(
                //       children: const [
                //         Center(
                //           child: Text(
                //             'متجر بيع المواشي',
                //           ),
                //         )
                //       ],
                //     ),
                //     actions: [
                //       const Icon(
                //         IconBroken.Search,
                //         size: 25,
                //       ),
                //       Container(
                //           margin: const EdgeInsets.only(left: 10, right: 30),
                //           child: const Icon(
                //             IconBroken.Notification,
                //             size: 25,
                //           )),
                //     ],
                //   ),
                // ),

                body:
                    cubit.chooseBotNavBarScreen(cubit.bottomNavBarCurrentIndex),
                bottomNavigationBar: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[100]!,
                  color: Colors.black,
                  selectedIndex: cubit.bottomNavBarCurrentIndex,
                  onTabChange: (int i) {
                    cubit.changeBottomNavBarCurrentIndex(i);
                  },
                  tabs: const [
                    // ignore: prefer_const_constructors
                    GButton(
                      icon: IconBroken.Home,
                      text: 'الصفحة الرئيسية',
                    ),
                    // ignore: prefer_const_constructors
                    GButton(
                      icon: IconBroken.Paper,
                      text: 'الحجوزات',
                    ),

                    GButton(
                      icon: IconBroken.Profile,
                      text: 'حسابي',
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  List<IconData> listOfIcons = [
    IconBroken.Home,
    IconBroken.Location,
    IconBroken.Profile,
  ];

  List<String> listOfStrings = [
    'الرئيسية',
    'الحجوزات',
    'حسابي',
  ];

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');
    }
  }
}
