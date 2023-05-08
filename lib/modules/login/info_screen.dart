import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/icon_broken.dart';
import 'cubit/states.dart';
import 'officer_screen.dart';

class OfficerInfoScreen extends StatelessWidget {
  OfficerInfoScreen({super.key});
  TextEditingController mobilController = TextEditingController();
  TextEditingController FirstNameController = TextEditingController();
  var formState = GlobalKey<FormState>();
  dynamic from_time = '02:00';
  dynamic to_time = '01:00';

  TimeOfDay selectedTime = TimeOfDay.now();
  List Limit = [15, 30, 45, 60];

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);

    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? picked_s = await showTimePicker(
          context: context,
          initialTime: selectedTime,
          builder: (context, child) {
            return MediaQuery(
              data:
              MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child as Widget,
            );
          });

      if (picked_s != null && picked_s != selectedTime) selectedTime = picked_s;
      final formattedTimeOfDay = localizations.formatTimeOfDay(selectedTime);

      print(formattedTimeOfDay);
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaa');
    }

    return BlocProvider(
      create: (BuildContext context) => LoginCubit()..getCountries(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is InfoSuccessState) {
            print('==============================');
            print('==============================');
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
                  return OfficerScreen();
                }));
            MotionToast.success(
              title: "Success",
              titleStyle: TextStyle(fontWeight: FontWeight.bold),
              description: 'تمت بنجاح',
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
        builder: (context, state) => Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text('معلومات الصالون',
                  style:
                  TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold)),
            ),
            body: LoginCubit.get(context).countryModel != null
                ? Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            InkWell(
                              onTap: () {
                                LoginCubit.get(context)
                                    .getImageFromGallery();
                              },
                              child: CircleAvatar(
                                radius: 60.r,
                                backgroundColor: Color(0xffC9574D),
                                child: CircleAvatar(
                                  radius: 55.r,
                                  backgroundColor: Colors.white,
                                  child: LoginCubit.get(context).file !=
                                      null
                                      ? Container(
                                    width: 100.w,
                                    height: 100.h,
                                    child: Image.file(
                                      File(LoginCubit.get(context)
                                          .file!
                                          .path),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )
                                      : CircleAvatar(
                                    radius: 80.r,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      'https://icon-library.com/images/no-profile-picture-icon/no-profile-picture-icon-6.jpg',
                                      placeholder: (context, url) =>
                                          Center(
                                              child:
                                              CircularProgressIndicator(
                                                strokeWidth: 1.5.w,
                                              )),
                                      errorWidget:
                                          (context, url, error) =>
                                          Icon(
                                            Icons.error,
                                            color: Color(0xffC9574D),
                                          ),
                                      imageBuilder: (context,
                                          imageProvider) =>
                                          CircleAvatar(
                                            backgroundImage:
                                            imageProvider,
                                            radius: 65.r,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 25.r,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                child: IconButton(
                                  splashRadius: 22.r,
                                  onPressed: () {},
                                  icon: Icon(
                                    IconBroken.Camera,
                                    color: Color(0xffC9574D),
                                  ),
                                ),
                                radius: 22.r,
                                backgroundColor: Colors.grey[50],
                              ),
                            ),
                          ],
                        ),
                        AnnotatedRegion<SystemUiOverlayStyle>(
                            value: SystemUiOverlayStyle(
                                statusBarColor: Colors.transparent,
                                statusBarIconBrightness: Brightness.dark),
                            child: Center(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Form(
                                        key: formState,
                                        child: Column(
                                            mainAxisSize:
                                            MainAxisSize.min,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              TextFormField(
                                                controller:
                                                FirstNameController,
                                                cursorColor: indigo,
                                                keyboardType:
                                                TextInputType.text,
                                                validator:
                                                    (dynamic value) {
                                                  if (value.isEmpty) {
                                                    return 'أدخل اسم الصالون  ';
                                                  }
                                                  return null;
                                                },
                                                decoration:
                                                InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  labelText:
                                                  'اسم الصالون',
                                                  prefixIcon: Icon(
                                                      IconBroken.Profile),
                                                  enabledBorder:
                                                  enabledBorder,
                                                  focusedBorder:
                                                  focusedBorder,
                                                  errorBorder:
                                                  enabledBorder,
                                                  focusedErrorBorder:
                                                  focusedBorder,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              TextFormField(
                                                cursorColor: indigo,
                                                keyboardType:
                                                TextInputType.name,
                                                validator:
                                                    (dynamic value) {
                                                  if (value.isEmpty) {
                                                    return 'أدخل عنوان الموظف';
                                                  }
                                                  return null;
                                                },
                                                decoration:
                                                InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  labelText:
                                                  'عنوان الصالون',
                                                  prefixIcon: Icon(
                                                      IconBroken.Home),
                                                  enabledBorder:
                                                  enabledBorder,
                                                  focusedBorder:
                                                  focusedBorder,
                                                  errorBorder:
                                                  enabledBorder,
                                                  focusedErrorBorder:
                                                  focusedBorder,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors
                                                              .black26),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          15.r),
                                                      boxShadow: <
                                                          BoxShadow>[
                                                        //blur radius of shadow
                                                      ]),
                                                  child: Padding(
                                                      padding:
                                                      EdgeInsets.only(
                                                          left: 30,
                                                          right: 30),
                                                      child:
                                                      DropdownButton<
                                                          dynamic>(
                                                        value: LoginCubit
                                                            .get(
                                                            context)
                                                            .CounteryVal,
                                                        hint: Text(
                                                            'اختر المدينة '),
                                                        icon: Icon(
                                                          Icons
                                                              .arrow_circle_down_rounded,
                                                          color: Colors
                                                              .black,
                                                        ),
                                                        items: LoginCubit
                                                            .get(
                                                            context)
                                                            .countryModel!
                                                            .data!
                                                            .map((e) {
                                                          return DropdownMenuItem(
                                                            alignment:
                                                            AlignmentDirectional
                                                                .topCenter,
                                                            value: e.id,
                                                            child: Text(e
                                                                .name
                                                                .toString()),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (value) {
                                                          LoginCubit.get(
                                                              context)
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
                                                            color: Colors
                                                                .black),
                                                        iconEnabledColor:
                                                        Colors
                                                            .white, //Icon color
                                                      ))),
                                              SizedBox(
                                                height: 20.0.h,
                                              ),
                                              DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors
                                                              .black26),
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          15.r),
                                                      boxShadow: <
                                                          BoxShadow>[
                                                        //blur radius of shadow
                                                      ]),
                                                  child: Padding(
                                                      padding:
                                                      EdgeInsets.only(
                                                          left: 30,
                                                          right: 30),
                                                      child:
                                                      DropdownButton(
                                                        value: LoginCubit
                                                            .get(
                                                            context)
                                                            .Limit,
                                                        hint: Text(
                                                            'اختر الفترة بين كل حجز '),
                                                        icon: Icon(
                                                          Icons
                                                              .arrow_circle_down_rounded,
                                                          color: Colors
                                                              .black,
                                                        ),
                                                        items: [
                                                          15,
                                                          30,
                                                          45,
                                                          60
                                                        ].map((e) {
                                                          return DropdownMenuItem<
                                                              int>(
                                                            alignment:
                                                            AlignmentDirectional
                                                                .topCenter,
                                                            value: e,
                                                            child: Text(e
                                                                .toString()),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (value) {
                                                          LoginCubit.get(
                                                              context)
                                                              .changeLimitValue(
                                                              value);
                                                          print(value);
                                                        },
                                                        isExpanded:
                                                        true, //make true to take width of parent widget
                                                        underline:
                                                        Container(), //empty line
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors
                                                                .black),
                                                        iconEnabledColor:
                                                        Colors
                                                            .white, //Icon color
                                                      ))),
                                              SizedBox(
                                                height: 20.0.h,
                                              ),
                                              Text(
                                                'اختار اوقات العمل ',
                                                style: TextStyle(
                                                    fontSize: 23),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 20.h,
                                                    bottom: 20.h,
                                                    left: 20.w,
                                                    right: 20.w),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                      EdgeInsets.only(
                                                          top: 20.h,
                                                          bottom:
                                                          20.h,
                                                          left: 20.w,
                                                          right:
                                                          20.w),
                                                      child: Text(
                                                        'من ',
                                                        style: TextStyle(
                                                            fontSize:
                                                            22.sp,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      controller: TextEditingController(
                                                          text: LoginCubit
                                                              .get(
                                                              context)
                                                              .FromTime),
                                                      readOnly: true,
                                                      cursorColor: indigo,
                                                      keyboardType:
                                                      TextInputType
                                                          .text,
                                                      onTap: () async {
                                                        await showTimePicker(
                                                          context:
                                                          context,
                                                          cancelText:
                                                          'الغاء',
                                                          helpText:
                                                          'اختار الساعة اولا ثم الدقائق ',
                                                          initialTime:
                                                          TimeOfDay
                                                              .now(),
                                                          onEntryModeChanged:
                                                              (p0) {
                                                            print(p0);
                                                          },
                                                          builder:
                                                              (context,
                                                              child) {
                                                            return MediaQuery(
                                                              data: MediaQuery.of(
                                                                  context)
                                                                  .copyWith(
                                                                  alwaysUse24HourFormat:
                                                                  true),
                                                              child: child
                                                              as Widget,
                                                            );
                                                          },
                                                        ).then((value) {
                                                          var timeofDayDate = TimeOfDay(
                                                              hour: value!
                                                                  .hour,
                                                              minute: value
                                                                  .minute);
                                                          var time =
                                                              '${timeofDayDate.hour}:${timeofDayDate.minute}';
                                                          LoginCubit.get(
                                                              context)
                                                              .changeVauleUpdateTime(
                                                              time,
                                                              LoginCubit.get(context)
                                                                  .ToTime);
                                                          print(time);
                                                        });
                                                      },
                                                      decoration:
                                                      InputDecoration(
                                                        filled: true,
                                                        fillColor:
                                                        Colors.white,
                                                        labelText:
                                                        '${LoginCubit.get(context).FromTime}',
                                                        prefixIcon: Icon(
                                                            IconBroken
                                                                .Time_Circle),
                                                        enabledBorder:
                                                        enabledBorder,
                                                        focusedBorder:
                                                        focusedBorder,
                                                        errorBorder:
                                                        enabledBorder,
                                                        focusedErrorBorder:
                                                        focusedBorder,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                      EdgeInsets.only(
                                                          top: 20.h,
                                                          bottom:
                                                          20.h),
                                                      child: Text(
                                                        'إلى',
                                                        style: TextStyle(
                                                            fontSize:
                                                            22.sp,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      controller: TextEditingController(
                                                          text: LoginCubit
                                                              .get(
                                                              context)
                                                              .ToTime),
                                                      readOnly: true,
                                                      cursorColor: indigo,
                                                      keyboardType:
                                                      TextInputType
                                                          .text,
                                                      onTap: () async {
                                                        await showTimePicker(
                                                          context:
                                                          context,
                                                          cancelText:
                                                          'الغاء',
                                                          helpText:
                                                          'اختار الساعة اولا ثم الدقائق ',
                                                          initialTime:
                                                          TimeOfDay
                                                              .now(),
                                                          onEntryModeChanged:
                                                              (p0) {
                                                            print(p0);
                                                          },
                                                          builder:
                                                              (context,
                                                              child) {
                                                            return MediaQuery(
                                                              data: MediaQuery.of(
                                                                  context)
                                                                  .copyWith(
                                                                  alwaysUse24HourFormat:
                                                                  true),
                                                              child: child
                                                              as Widget,
                                                            );
                                                          },
                                                        ).then((value) {
                                                          var timeofDayDate = TimeOfDay(
                                                              hour: value!
                                                                  .hour,
                                                              minute: value
                                                                  .minute);
                                                          var time =
                                                              '${timeofDayDate.hour}:${timeofDayDate.minute}';
                                                          LoginCubit.get(
                                                              context)
                                                              .changeVauleUpdateTime(
                                                              LoginCubit.get(context)
                                                                  .FromTime,
                                                              time);
                                                          print(time);
                                                        });
                                                      },
                                                      decoration:
                                                      InputDecoration(
                                                        filled: true,
                                                        fillColor:
                                                        Colors.white,
                                                        labelText:
                                                        '${LoginCubit.get(context).ToTime}',
                                                        prefixIcon: Icon(
                                                            IconBroken
                                                                .Time_Circle),
                                                        enabledBorder:
                                                        enabledBorder,
                                                        focusedBorder:
                                                        focusedBorder,
                                                        errorBorder:
                                                        enabledBorder,
                                                        focusedErrorBorder:
                                                        focusedBorder,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 30.h,
                                                    ),
                                                    //       ConditionalBuilder(
                                                    //           fallback: (context) =>
                                                    //               Center(child: CircularProgressIndicator()),
                                                    //           condition: state is! HallaqLoadingWorkTimeUpdaeState,
                                                    //           builder: (context) {
                                                    //             return gradientButton(
                                                    //                 context: context,
                                                    //                 title: Text(
                                                    //                   'تأكيد ',
                                                    //                   style: TextStyle(
                                                    //                       color: Colors.white, fontSize: 16.sp),
                                                    //                 ),
                                                    //                 onPressed: () {
                                                    //                   cubit.UpdateWorkTime(
                                                    //                       id: id,
                                                    //                       from: cubit.FromTime,
                                                    //                       to: cubit.ToTime);
                                                    //                 });
                                                    //           }),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    gradientButton(
                                                        context: context,
                                                        title: Text(
                                                          'التالي ',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                              16.sp),
                                                        ),
                                                        onPressed: () {
                                                          if (formState
                                                              .currentState!
                                                              .validate()) {
                                                            LoginCubit.get(context).InfoData(
                                                                limitTime:
                                                                LoginCubit.get(context)
                                                                    .Limit,
                                                                from: LoginCubit.get(context)
                                                                    .FromTime,
                                                                to: LoginCubit.get(
                                                                    context)
                                                                    .ToTime,
                                                                name: FirstNameController
                                                                    .text,
                                                                file: LoginCubit.get(
                                                                    context)
                                                                    .file);
                                                          }
                                                        })

                                                    // print(formattedTime);
                                                  ],
                                                ),
                                              ),
                                            ]))))),
                      ],
                    ),
                  ),
                ),
              ],
            )
                : Center(
              child: Lottie.asset(
                'assets/lottiefiles/loader2.json',
                width: 200.w,
                height: 200.h,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
