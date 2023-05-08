import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shop_app/layout/home_layout.dart';
import 'package:shop_app/modules/profile/time_work_screen.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/icon_broken.dart';
import '../login/cubit/states.dart';

class EditTimeWorkScreen extends StatelessWidget {
  final day;
  final form;
  final to;
  final id;
  final countery_id;
  EditTimeWorkScreen(
      {@required this.day,
      @required this.form,
      @required this.to,
      @required this.id,
      @required this.countery_id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HallaqCubit()..changeVauleUpdateTime(form, to),
      child: BlocConsumer<HallaqCubit, HallaqStates>(
        listener: (context, state) {
          if (state is HallaqSuccessWorkTimeUpdateState) {
            navigatorPushRemove(context, HallaqLayoutScreen());

            MotionToast.success(
              title: "",
              titleStyle: TextStyle(fontWeight: FontWeight.bold),
              description: 'تم تعديل وقت العمل  ',
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
                    'تعديل وقت يوم $day  ',
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              body: Container(
                margin: EdgeInsets.only(
                    top: 20.h, bottom: 20.h, left: 20.w, right: 20.w),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 20.h, bottom: 20.h, left: 20.w, right: 20.w),
                      child: Text(
                        'من ',
                        style: TextStyle(
                            fontSize: 22.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      controller: TextEditingController(text: cubit.FromTime),
                      readOnly: true,
                      cursorColor: indigo,
                      keyboardType: TextInputType.text,
                      onTap: () async {
                        await showTimePicker(
                          context: context,
                          cancelText: 'الغاء',
                          helpText: 'اختار الساعة اولا ثم الدقائق ',
                          initialTime: TimeOfDay.now(),
                          onEntryModeChanged: (p0) {
                            print(p0);
                          },
                          builder: (context, child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child as Widget,
                            );
                          },
                        ).then((value) {
                          var timeofDayDate = TimeOfDay(
                              hour: value!.hour, minute: value.minute);
                          var time =
                              '${timeofDayDate.hour}:${timeofDayDate.minute}';
                          cubit.changeVauleUpdateTime(time, cubit.ToTime);
                          print(time);
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: '${cubit.FromTime}',
                        prefixIcon: Icon(IconBroken.Time_Circle),
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: enabledBorder,
                        focusedErrorBorder: focusedBorder,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                      child: Text(
                        'إلى',
                        style: TextStyle(
                            fontSize: 22.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      controller: TextEditingController(text: cubit.ToTime),
                      readOnly: true,
                      cursorColor: indigo,
                      keyboardType: TextInputType.text,
                      onTap: () async {
                        await showTimePicker(
                          context: context,
                          cancelText: 'الغاء',
                          helpText: 'اختار الساعة اولا ثم الدقائق ',
                          initialTime: TimeOfDay.now(),
                          onEntryModeChanged: (p0) {
                            print(p0);
                          },
                          builder: (context, child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child as Widget,
                            );
                          },
                        ).then((value) {
                          var timeofDayDate = TimeOfDay(
                              hour: value!.hour, minute: value.minute);
                          var time =
                              '${timeofDayDate.hour}:${timeofDayDate.minute}';
                          cubit.changeVauleUpdateTime(cubit.FromTime, time);
                          print(time);
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: '${cubit.ToTime}',
                        prefixIcon: Icon(IconBroken.Time_Circle),
                        enabledBorder: enabledBorder,
                        focusedBorder: focusedBorder,
                        errorBorder: enabledBorder,
                        focusedErrorBorder: focusedBorder,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    ConditionalBuilder(
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                        condition: state is! HallaqLoadingWorkTimeUpdaeState,
                        builder: (context) {
                          return gradientButton(
                              context: context,
                              title: Text(
                                'تأكيد ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.sp),
                              ),
                              onPressed: () {
                                cubit.UpdateWorkTime(
                                    id: id,
                                    from: cubit.FromTime,
                                    to: cubit.ToTime);
                              });
                        }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
