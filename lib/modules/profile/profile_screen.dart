import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shop_app/modules/login/officer_screen.dart';
import 'package:shop_app/modules/profile/edit_holiday_screen.dart';
import 'package:shop_app/modules/profile/edit_time_work_screen.dart';
import 'package:shop_app/modules/profile/policy_screen.dart';
import 'package:shop_app/modules/profile/time_work_screen.dart';
import 'package:shop_app/modules/update_user_data/update_user_data_bottom_sheet.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

import '../login/cubit/cubit.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HallaqCubit, HallaqStates>(
      listener: (context, state) {
        if (state is InfoSuccess2State) {
          if (state.profileModel.status!) {
            MotionToast.success(
              title: "Success",
              titleStyle: TextStyle(fontWeight: FontWeight.bold),
              description: state.profileModel.message!,
              descriptionStyle: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
              animationType: ANIMATION.FROM_LEFT,
              position: MOTION_TOAST_POSITION.TOP,
              borderRadius: 10.0,
              width: 300,
              height: 65,
            ).show(context);
          } else {
            print(state.profileModel.message!);
            MotionToast.error(
              title: "Error",
              titleStyle: TextStyle(fontWeight: FontWeight.bold),
              description: state.profileModel.message!,
              descriptionStyle: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
              animationType: ANIMATION.FROM_LEFT,
              position: MOTION_TOAST_POSITION.TOP,
              borderRadius: 10.0,
              width: 300,
              height: 65,
            ).show(context);
          }
        }
      },
      builder: (context, state) {
        HallaqCubit cubit = HallaqCubit.get(context);

        return ModalProgressHUD(
          inAsyncCall: state is ShopLoadingUpdateUserState,
          color: Colors.white,
          opacity: 0.5,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: Center(
                  child: Text(
                    'الملف الشخصي',
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                leading: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.notifications,
                        size: 30.r,
                      ),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.getImageFromGallery().then((value) {
                                cubit.InfoData(file: cubit.file);
                              });
                            },
                            child: CircleAvatar(
                              radius: 60.r,
                              backgroundColor: Color(0xffC9574D),
                              child: CircleAvatar(
                                radius: 55.r,
                                backgroundColor: Colors.white,
                                child: cubit.file != null
                                    ? Container(
                                        width: 100.w,
                                        height: 100.h,
                                        child: Image.file(
                                          File(cubit.file!.path),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 80.r,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '${cubit.profilemodel!.data!.image}',
                                          placeholder: (context, url) => Center(
                                              child: CircularProgressIndicator(
                                            strokeWidth: 1.5.w,
                                          )),
                                          errorWidget: (context, url, error) =>
                                              Icon(
                                            Icons.error,
                                            color: Color(0xffC9574D),
                                          ),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  CircleAvatar(
                                            backgroundImage: imageProvider,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          '${cubit.profilemodel!.data!.name}',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '  ${cubit.profilemodel!.data!.phone}',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      Divider(thickness: 2, indent: 1.5),
                      profileItem2(
                          context: context,
                          title: 'تعديل الملف الشخصي',
                          onTap: () {
                            bottomSheetUpdateUserData(
                                context: context, cubit: cubit);
                          },
                          icon: Icon(IconBroken.User)),

                      profileItem2(
                          context: context,
                          title: 'تعديل الموظفين',
                          onTap: () {
                            navigatorPush(context, OfficerScreen());
                          },
                          icon: Icon(IconBroken.Edit)),
                      Container(
                        margin: EdgeInsets.only(top: 25.h),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Text(
                                LoginCubit.get(context).isDark!
                                    ? 'تغيير إلى الوضع الفاتح'
                                    : 'تغيير إلى الوضع المظلم',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            Spacer(),
                            CupertinoSwitch(
                              value: LoginCubit.get(context).isDark!,
                              onChanged: (value) {
                                LoginCubit.get(context)
                                    .changeAppMode(fromShared: value);
                              },
                              trackColor: Colors.grey.shade200.withOpacity(0.2),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 25.h),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Text(
                                HallaqCubit.get(context).AutoAccept!
                                    ? 'القبول التلقائي'
                                    : 'عدم القبول التلقائي',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            Spacer(),
                            CupertinoSwitch(
                              value: HallaqCubit.get(context).AutoAccept!,
                              onChanged: (value) {
                                HallaqCubit.get(context)
                                    .changeAutoAcceptMode(fromShared: value);
                                if (value == true) {
                                  HallaqCubit.get(context)
                                      .InfoData4(auto_accept: 1);
                                }
                                if (value == false) {
                                  HallaqCubit.get(context)
                                      .InfoData4(auto_accept: 0);
                                }

                                print(value);
                              },
                              trackColor: Colors.grey.shade200.withOpacity(0.2),
                            ),
                          ],
                        ),
                      ),
                      profileItem2(
                          context: context,
                          title: 'تعديل أوقات العمل ',
                          onTap: () {
                            navigatorPush(
                                context,
                                TimeWork(
                                    cubit.profilemodel!.data!.countryId,
                                    cubit.profilemodel!.data!.limitTime,
                                    cubit.profilemodel!.data!.holidayId));
                          },
                          icon: Icon(Icons.access_time_rounded)),
                      profileItem2(
                          context: context,
                          title: 'سياسة الخصوصية',
                          onTap: () async {
                            navigatorPush(context, PolicyScreen());
                          },
                          icon: Icon(Icons.local_police)),
                      profileItem2(
                          context: context,
                          title: 'وقت الإستراحة',
                          onTap: () async {
                            navigatorPush(
                                context,
                                HolidayScreen(
                                    form:
                                        cubit.profilemodel!.data!.breakTimeFrom,
                                    to: cubit.profilemodel!.data!.breakTimeTo));
                          },
                          icon: Icon(Icons.punch_clock_outlined)),

                      // Container(
                      //   margin: EdgeInsets.only(top: 15.h),
                      //   child: Row(
                      //     children: [
                      //       Icon(IconBroken.User),
                      //       Padding(
                      //         padding: EdgeInsets.only(right: 10.w),
                      //         child: Text(
                      //           'تعديل الملف الشخصي',
                      //           style: TextStyle(
                      //               color: Colors.black,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //       ),
                      //       Spacer(),
                      //       Icon(IconBroken.Arrow___Left_Circle)
                      //     ],
                      //   ),
                      // ),

                      SizedBox(
                        height: 40,
                      ),

                      InkWell(
                        onTap: () {
                          logout(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'تسجيل الخروج',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Spacer(),
                            Icon(
                              IconBroken.Logout,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      InkWell(
                        onTap: () {
                          showPopupUpdatstaff(
                              context, HallaqCubit.get(context));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'حذف الحساب',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 13),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Spacer(),
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> showPopupUpdatstaff(context, HallaqCubit cubit) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 200.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
                  Text('تأكيد عملية حذف الحساب من التطبيق'),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            cubit.DeleteAccoount(context);
                          },
                          child: const Text("نعم",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'cairo',
                                  fontSize: 16)),
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          print('no selected');
                          Navigator.of(context).pop();
                        },
                        child: const Text("لا",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'cairo',
                                fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
