import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/home_screen/hajz.dart';
import 'package:shop_app/modules/profile/time_work_screen.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/states.dart';

class DetailsScreen extends StatelessWidget {
  int id;
  final text;
  final image;
  final date;
  final time;
  final number;
  final status;
  final mobilenumber;
  final employee_name;
  DetailsScreen(this.id, this.text, this.image, this.date, this.time,
      this.number, this.status, this.mobilenumber, this.employee_name);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HallaqCubit(),
      child: BlocConsumer<HallaqCubit, HallaqStates>(
        listener: (context, state) {
          if (state is AceptOrRejectSuccessState) {
            MotionToast.success(
              title: state.acceptedOrRejectedModel.message.toString(),
              titleStyle: TextStyle(fontWeight: FontWeight.bold),
              description:
                  state.acceptedOrRejectedModel.data!.status.toString(),
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
        },
        builder: (context, state) {
          HallaqCubit cubit = HallaqCubit.get(context);

          return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  leading: InkWell(
                      onTap: () {
                        navigatorPush(context, HallaqLayoutScreen());
                      },
                      child: Icon(Icons.arrow_back)),
                  title: Text(text),
                ),
                body: SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                        constraints: BoxConstraints(
                            maxHeight: 200.h, maxWidth: double.infinity),
                        child: Image.network(image)),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: 20.w, top: 20.h, bottom: 20.h),
                              child: Text('تعديل حالة الحجز',
                                  style: GoogleFonts.notoKufiArabic(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold)

                                  // TextStyle(
                                  //     color: Colors.black,
                                  //     fontSize: 33,
                                  //     fontWeight: FontWeight.bold),
                                  ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    cubit.AceptOrReject(
                                        order_id: id, status: 'accepted');
                                  },
                                  child: Container(
                                    height: 80.h,
                                    width: 150.w,
                                    decoration:
                                        BoxDecoration(color: Colors.green),
                                    child: Center(
                                        child: Text(
                                      'موافقة',
                                      style: TextStyle(fontSize: 25.sp),
                                    )),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    cubit.AceptOrReject(
                                        order_id: id, status: 'rejected');
                                  },
                                  child: Container(
                                    height: 80.h,
                                    width: 150.w,
                                    decoration:
                                        BoxDecoration(color: Colors.red),
                                    child: Center(
                                        child: Text(
                                      'رفض',
                                      style: TextStyle(fontSize: 22.sp),
                                    )),
                                  ),
                                )
                              ],
                            ),
                          ),
                   

                          // Row(
                          //   children: [
                          //     Text(
                          //       'التقييم',
                          //       style: TextStyle(
                          //           color: Colors.black,
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 15),
                          //     ),
                          //     Spacer(),
                          //     RatingBar.builder(
                          //       initialRating: 3,
                          //       minRating: 1,
                          //       direction: Axis.horizontal,
                          //       allowHalfRating: true,
                          //       itemCount: 5,
                          //       itemPadding:
                          //           EdgeInsets.symmetric(horizontal: 4.0),
                          //       itemBuilder: (context, _) => Icon(
                          //         Icons.star,
                          //         color: Colors.amber,
                          //       ),
                          //       onRatingUpdate: (rating) {
                          //         print(rating);
                          //       },
                          //     )
                          //   ],
                          // ),
                          
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 50.w),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      launch("tel://${mobilenumber}");
                                    },
                                    child:
                                        Icon(Icons.call, color: Colors.black),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(20),
                                      backgroundColor:
                                          Colors.white, // <-- Button color
                                      foregroundColor:
                                          Colors.red, // <-- Splash color
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      String url() {
                                        if (Platform.isAndroid) {
                                          // add the [https]
                                          return "https://wa.me/${mobilenumber}/?text=${Uri.parse('')}"; // new line
                                        } else {
                                          // add the [https]
                                          return "https://api.whatsapp.com/send?phone=${mobilenumber}=${Uri.parse('')}"; // new line
                                        }
                                      }

                                      launch(url());
                                    },
                                    child: Icon(
                                      Icons.whatsapp,
                                      color: Colors.green,
                                      size: 25.r,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(20),
                                      backgroundColor:
                                          Colors.white, // <-- Button color
                                      foregroundColor:
                                          Colors.red, // <-- Splash color
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    DetailsCard('رقم الحجز', '$number'),
                    DetailsCard(
                        'حالة الحجز',
                        '${cubit.acceptedorrejectedmodel != null ? cubit.acceptedorrejectedmodel!.data!.status == 'accepted' ? 'مقبول' : cubit.acceptedorrejectedmodel!.data!.status == 'rejected' ? 'مرفوض' : 'معلق' : status == 'accepted' ? 'مقبول' : status == 'rejected' ? 'مرفوض' : 'معلق'}'),
                    DetailsCard('وقت الحجز', '$time'),
                    DetailsCard('يوم الحجز', '$date'),
                    DetailsCard('اسم الموظف', '$employee_name')
                  ],
                )),
              ));
        },
      ),
    );
  }
}
