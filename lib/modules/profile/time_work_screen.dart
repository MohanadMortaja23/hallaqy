import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

import '../../models/countery_model.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/states.dart';

class TimeWork extends StatelessWidget {
  final id;
  final limit_time;
  final holiday_id;

  TimeWork(this.id, this.limit_time, this.holiday_id);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HallaqCubit()
        ..getWorkTime()
        ..getCountries(id)
        ..AddDayToList(),
      child: BlocConsumer<HallaqCubit, HallaqStates>(
        listener: (context, state) {
          if (state is InfoSuccess2State) {
            navigatorReplacement(context, HallaqLayoutScreen());
            MotionToast.success(
              title: "نجاح",
              titleStyle: TextStyle(fontWeight: FontWeight.bold),
              description: 'تم تغيير الفترة بين الحجوزات بنجاح',
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
          if (state is InfoSuccess3State) {
            navigatorReplacement(context, HallaqLayoutScreen());
            MotionToast.success(
              title: "نجاح",
              titleStyle: TextStyle(fontWeight: FontWeight.bold),
              description: 'تم تغيير المدينة',
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

          if (state is InfoSuccess8State) {
            navigatorReplacement(context, HallaqLayoutScreen());
            MotionToast.success(
              title: "نجاح",
              titleStyle: TextStyle(fontWeight: FontWeight.bold),
              description: 'تم إضافة يوم الراحة',
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
          if (state is InfoSuccess7State) {
            navigatorReplacement(context, HallaqLayoutScreen());
            MotionToast.success(
              title: "نجاح",
              titleStyle: TextStyle(fontWeight: FontWeight.bold),
              description: 'تم تعديل فترة الحجز بنجاح',
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
                  title: Center(
                    child: Text(
                      'ساعات العمل',
                      style: TextStyle(
                          fontSize: 22.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: cubit.workTime != null
                      ? Container(
                    margin: EdgeInsets.only(top: 30.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          itemCount: cubit.workTime!.data!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return MyTimeWork(
                              id: cubit.workTime!.data![index].id,
                              ctx: context,
                              day: cubit.workTime!.data![index].day,
                              from: cubit.workTime!.data![index].from,
                              to: cubit.workTime!.data![index].to,
                              countery_id: id,
                            );
                          },
                        ),
                        Container(
                          margin: EdgeInsets.all(30),
                          child: Center(
                            child: Text(
                              'تعديل  فترة الحجز',
                              style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(left: 20.w, right: 20.w),
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                  Border.all(color: Colors.black26),
                                  borderRadius:
                                  BorderRadius.circular(15.r),
                                  boxShadow: <BoxShadow>[
                                    //blur radius of shadow
                                  ]),
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: DropdownButton(
                                    value: HallaqCubit.get(context).Limit,
                                    hint: Text('$limit_time'),
                                    icon: Icon(
                                      Icons.arrow_circle_down_rounded,
                                      color: Colors.black,
                                    ),
                                    items: [15, 30, 45, 60].map((e) {
                                      return DropdownMenuItem<int>(
                                        alignment: AlignmentDirectional
                                            .topCenter,
                                        value: e,
                                        child: Text(e.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      HallaqCubit.get(context)
                                          .changeLimitValue(value);
                                      print(value);
                                    },
                                    isExpanded:
                                    true, //make true to take width of parent widget
                                    underline: Container(), //empty line
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black),
                                    iconEnabledColor:
                                    Colors.white, //Icon color
                                  ))),
                        ),
                        SizedBox(
                          height: 20.0.h,
                        ),
                        Container(
                          margin:
                          EdgeInsets.only(left: 20.w, right: 20.w),
                          child: ConditionalBuilder(
                            condition: state is! InfoLoadingState,
                            fallback: (context) => Center(
                                child: CircularProgressIndicator()),
                            builder: (context) => gradientButton(
                                context: context,
                                title: Text(
                                  'تأكيد تعديل فترة الحجز ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp),
                                ),
                                onPressed: () {
                                  HallaqCubit.get(context).InfoData8(
                                    limitTime:
                                    HallaqCubit.get(context).Limit,
                                  );
                                }),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(30),
                          child: Center(
                            child: Text(
                              'تعديل المدينة الحالية',
                              style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        HallaqCubit.get(context).countryModel != null
                            ? Container(
                          margin: EdgeInsets.only(
                              left: 20.w, right: 20.w),
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black26),
                                  borderRadius:
                                  BorderRadius.circular(15.r),
                                  boxShadow: <BoxShadow>[
                                    //blur radius of shadow
                                  ]),
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: DropdownButton<dynamic>(
                                    value: HallaqCubit.get(context)
                                        .CounteryVal,
                                    hint: Text(
                                        HallaqCubit.get(context)
                                            .initialCountery!
                                            .name
                                            .toString()),
                                    icon: Icon(
                                      Icons
                                          .arrow_circle_down_rounded,
                                      color: Colors.black,
                                    ),
                                    items: HallaqCubit.get(context)
                                        .countryModel!
                                        .data!
                                        .map((e) {
                                      return DropdownMenuItem(
                                        alignment:
                                        AlignmentDirectional
                                            .topCenter,
                                        value: e.id,
                                        child:
                                        Text(e.name.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      HallaqCubit.get(context)
                                          .changeCounteryValue(
                                          value);
                                      print(value);
                                    },
                                    isExpanded:
                                    true, //make true to take width of parent widget
                                    underline:
                                    Container(), //empty line
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black),
                                    iconEnabledColor:
                                    Colors.white, //Icon color
                                  ))),
                        )
                            : CircularProgressIndicator(),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 20.w, right: 20.w, bottom: 20.h),
                          child: ConditionalBuilder(
                            condition: state is! InfoLoadingState,
                            fallback: (context) => Center(
                                child: CircularProgressIndicator()),
                            builder: (context) => gradientButton(
                                context: context,
                                title: Text(
                                  'تأكيد تعديل المنطقة ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp),
                                ),
                                onPressed: () {
                                  HallaqCubit.get(context).InfoData3(
                                      country: HallaqCubit.get(context)
                                          .CounteryVal);
                                }),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(30),
                          child: Center(
                            child: Text(
                              'تعديل يوم الراحة',
                              style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        HallaqCubit.get(context).data!.isNotEmpty
                            ? Container(
                          margin: EdgeInsets.only(
                              left: 20.w, right: 20.w),
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black26),
                                  borderRadius:
                                  BorderRadius.circular(15.r),
                                  boxShadow: <BoxShadow>[
                                    //blur radius of shadow
                                  ]),
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: DropdownButton<dynamic>(
                                    value: HallaqCubit.get(context)
                                        .DayVal,
                                    icon: Icon(
                                      Icons
                                          .arrow_circle_down_rounded,
                                      color: Colors.black,
                                    ),
                                    items: HallaqCubit.get(context)
                                        .data!
                                        .map((e) {
                                      return DropdownMenuItem(
                                        alignment:
                                        AlignmentDirectional
                                            .topCenter,
                                        value: e.id,
                                        child:
                                        Text(e.name.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      HallaqCubit.get(context)
                                          .changeDayValue(value);
                                      print(value);
                                    },
                                    isExpanded:
                                    true, //make true to take width of parent widget
                                    underline:
                                    Container(), //empty line
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black),
                                    iconEnabledColor:
                                    Colors.white, //Icon color
                                  ))),
                        )
                            : CircularProgressIndicator(),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 20.w, right: 20.w, bottom: 20.h),
                          child: ConditionalBuilder(
                            condition: state is! InfoLoadingState,
                            fallback: (context) => Center(
                                child: CircularProgressIndicator()),
                            builder: (context) => gradientButton(
                                context: context,
                                title: Text(
                                  'تأكيد الإضافة ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp),
                                ),
                                onPressed: () {
                                  HallaqCubit.get(context).InfoData5(
                                      holiday_id: HallaqCubit.get(context)
                                          .DayVal);
                                }),
                          ),
                        ),
                      ],
                    ),
                  )
                      : Center(child: CircularProgressIndicator()),
                )),
          );
        },
      ),
    );
  }
}
