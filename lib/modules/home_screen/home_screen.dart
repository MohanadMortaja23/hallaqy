import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shop_app/modules/notification_screen/notification.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

import '../../layout/home_layout.dart';
import '../../shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime.now(),
  ];

  @override
  Widget build(BuildContext context) {
    print('11111111111111111111');
    return BlocProvider(
      create: (context) => HallaqCubit()
        ..getDashboardData()
        ..getBookingTody(HallaqCubit.get(context).Day_id),
      child: BlocConsumer<HallaqCubit, HallaqStates>(
        listener: (context, state) {
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
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  navigatorPush(context, NotificationScreen());
                },
                child: Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.notifications,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
              actions: [
                Container(
                    width: 120.w,
                    child: Center(
                        child: Text(
                      'الحلاقين',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ))),
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Image.asset(
                      'assets/images/img2.png',
                      width: 30,
                      height: 80,
                    )),
              ],
            ),
            body: Stack(
              children: [
                Container(),
                SingleChildScrollView(
                  child: HallaqCubit.get(context).dashboardModel != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(right: 20.w),
                                child: Text('لوحة التحكم',
                                    style: GoogleFonts.notoKufiArabic(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)

                                    // TextStyle(
                                    //     color: Colors.black,
                                    //     fontSize: 33,
                                    //     fontWeight: FontWeight.bold),
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: ContainerItme(
                                        '${HallaqCubit.get(context).dashboardModel!.totalOrders}',
                                        'مجموع الحجوزات',
                                        Colors.amber)),
                                Expanded(
                                    flex: 1,
                                    child: ContainerItme(
                                        '${HallaqCubit.get(context).dashboardModel!.totalClient}',
                                        'مجموع العملاء',
                                        Colors.red)),
                              ],
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(right: 20.w, top: 20.h),
                                child: Text('الحجوزات لهذا اليوم ',
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
                              margin: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 20.w),
                              child: Text(
                                'أختر يوم الحجز ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            _buildDefaultSingleDatePickerWithValue(context),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 20.w),
                              child: Text(
                                'الحجوزات حسب التاريخ المختار',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            HallaqCubit.get(context).bookingModel != null
                                ? HallaqCubit.get(context)
                                            .bookingModel!
                                            .data!
                                            .length !=
                                        0
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: HallaqCubit.get(context)
                                            .bookingModel!
                                            .data!
                                            .length,
                                        itemBuilder: (context, index) {
                                          return CardItemOrder(
                                            ctx: context,
                                            id: HallaqCubit.get(context)
                                                .bookingModel!
                                                .data![index]
                                                .id,
                                            cubit: HallaqCubit.get(context),
                                            image: HallaqCubit.get(context)
                                                .bookingModel!
                                                .data![index]
                                                .userImage,
                                            text: HallaqCubit.get(context)
                                                .bookingModel!
                                                .data![index]
                                                .userName,
                                            date: HallaqCubit.get(context)
                                                .bookingModel!
                                                .data![index]
                                                .date,
                                            time: HallaqCubit.get(context)
                                                .bookingModel!
                                                .data![index]
                                                .time,
                                            number: HallaqCubit.get(context)
                                                .bookingModel!
                                                .data![index]
                                                .number,
                                            status: HallaqCubit.get(context)
                                                .bookingModel!
                                                .data![index]
                                                .status,
                                            mobilenumber:
                                                HallaqCubit.get(context)
                                                    .bookingModel!
                                                    .data![index]
                                                    .userMobile,
                                            employee_name:
                                                HallaqCubit.get(context)
                                                    .bookingModel!
                                                    .data![index]
                                                    .employeeName,
                                          );
                                        },
                                      )
                                    : Center(
                                        child: Lottie.asset(
                                          'assets/lottiefiles/empty.json',
                                          width: 200,
                                          height: 200,
                                        ),
                                      )
                                : CircularProgressIndicator()
                          ],
                        )
                      : Center(
                          child: Lottie.asset(
                            'assets/lottiefiles/loader2.json',
                            width: 200,
                            height: 200,
                          ),
                        ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget ContainerItme(text1, text2, color) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 15.w),
      height: 80.h,
      width: 120.w,
      decoration: BoxDecoration(color: color),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$text1',
            style: TextStyle(fontSize: 25.sp, color: Colors.white),
          ),
          Text(
            '$text2',
            style: TextStyle(fontSize: 18.sp, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _buildDefaultSingleDatePickerWithValue(context) {
    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: Color(0xffC9574D),
      weekdayLabels: ['احد', 'اثنين', 'ثلاث', 'اربع', 'خميس', 'جمعة', 'سبت'],
      weekdayLabelTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(),
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 1)))
          .isNegative,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CalendarDatePicker2(
          config: config,
          initialValue: _singleDatePickerValueWithDefaultValue,
          onValueChanged: (values) async {
            await HallaqCubit.get(context).changeTimeWork(values.first);
            HallaqCubit.get(context)
                .getBookingTody(HallaqCubit.get(context).Day_id);
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
