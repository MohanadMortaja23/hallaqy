import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../layout/home_layout.dart';
import '../../models/order_model.dart';

class OrdersScreen2 extends StatelessWidget {
  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<HallaqCubit>(context).Get_Myorder();
          print(1);
        }
      }
    });
  }

  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];

  @override
  Widget build(BuildContext context) {
    print('1231231231231232222222222222');
    return BlocProvider(
        create: (context) => HallaqCubit()..Get_Myorder(),
        child:
            BlocConsumer<HallaqCubit, HallaqStates>(listener: (context, state) {
          if (state is AceptOrRejectSuccessState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return HallaqLayoutScreen();
            }));
            MotionToast.success(
              title: "نجاح",
              titleStyle: TextStyle(fontWeight: FontWeight.bold),
              description: 'تم تأكيد العملية وسوف يصل الزبون إشعار بذلك',
              descriptionStyle: TextStyle(
                  //overflow: TextOverflow.ellipsis,
                  ),
              animationType: ANIMATION.FROM_LEFT,
              position: MOTION_TOAST_POSITION.TOP,
              borderRadius: 10.0,
              width: 300,
              height: 65,
            ).show(context);
          }
        }, builder: (context, state) {
          setupScrollController(context);
          return _OrderList();
        }));
  }

  Widget _loadingIndicator() {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Lottie.asset('assets/lottiefiles/loader2.json',
              height: 200, width: 200),
        ));
  }

  Widget _OrderList() {
    return BlocBuilder<HallaqCubit, HallaqStates>(builder: (context, state) {
      if (state is MyOrderLoadingState && state.isFirstFetch) {
        return _loadingIndicator();
      }

      List<DataOrder> posts = [];
      bool isLoading = false;

      if (state is MyOrderLoadingState) {
        posts = state.oldPosts;
        isLoading = true;
      } else if (state is MyOrderSuccessState) {
        posts = state.Posts;
      }
      return Scaffold(
        appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.notifications,
              color: Colors.black,
              size: 30,
            ),
          ),
          title: Center(
            child: Text(
              'جميع الحجوزات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          controller: scrollController,
          child: posts.length != 0
              ? Column(
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        if (index < posts.length)
                          return CardItemOrder(
                              cubit: HallaqCubit.get(context),
                              id: posts[index].id,
                              image: posts[index].partnerImage,
                              text: posts[index].userName,
                              number: posts[index].number,
                              date: posts[index].date,
                              time: posts[index].time,
                              status: posts[index].status,
                              ctx: context);
                        else {
                          Timer(Duration(milliseconds: 30), () {
                            scrollController.jumpTo(
                                scrollController.position.maxScrollExtent);
                          });

                          return Container();
                        }
                      },
                    ),
                    state is MyOrderLoadingState
                        ? _loadingIndicator()
                        : Text('')
                  ],
                )
              : Center(
                  child: Lottie.asset(
                    'assets/lottiefiles/empty.json',
                    width: 200,
                    height: 200,
                  ),
                ),
        ),
      );
    });
  }
}
