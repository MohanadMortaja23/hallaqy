import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/staff_update.dart';
import 'package:shop_app/modules/profile/edit_time_work_screen.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

import '../../modules/home_screen/details_screen.dart';
import '../cubit/cubit.dart';
import 'constants.dart';

Widget textFormField({
  TextEditingController? controller,
  Widget? suffixIcon,
  Widget? prefixIcon,
  OutlineInputBorder? enabledBorder,
  OutlineInputBorder? focusedBorder,
  Color? fillColor,
  Color? cursorColor,
  String? hintText,
  String? labelText,
  TextStyle? hintStyle,
  TextStyle? labelStyle,
  TextStyle? style,
  bool? filled,
  int? maxLines,
//  TextInputAction textInputAction,
  TextInputType? keyboardType,
  dynamic validator,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      fillColor: fillColor,
      hintText: hintText,
      hintStyle: hintStyle,
      labelText: labelText,
      labelStyle: labelStyle,
      filled: filled,
    ),
    style: style,
    // textInputAction: textInputAction,
    validator: validator,
    cursorColor: cursorColor,
    maxLines: maxLines,
    keyboardType: keyboardType,
  );
}

OutlineInputBorder focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(20.0),
  borderSide: BorderSide(
    color: Color.fromARGB(255, 219, 211, 211),
  ),
);

OutlineInputBorder enabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(20.0),
  borderSide: BorderSide(
    color: Color.fromARGB(255, 194, 184, 184),
  ),
);

navigatorPush(context, screen) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) {
    return screen;
  }));
}

navigatorPushRemove(context, screen) {
  return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => screen),
      ModalRoute.withName('/'));
}

navigatorReplacement(context, screen) {
  return Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) {
    return screen;
  }));
}

Widget profileItem2({
  required BuildContext context,
  String? title,
  dynamic onTap,
  required Icon icon,
}) {
  return Container(
    margin: EdgeInsets.only(top: 25.h),
    child: Row(
      children: [
        icon,
        Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: Text(
            title!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Spacer(),
        InkWell(onTap: onTap, child: Icon(IconBroken.Arrow___Left_Circle))
      ],
    ),
  );
}

Widget profileItem({
  required BuildContext context,
  String? title,
  String? content,
  dynamic onTap,
}) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 15.0,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color.fromARGB(255, 214, 210, 210),
          ),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    content!,
                    style: TextStyle(
                      color: Colors.grey,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                InkWell(
                  onTap: onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Colors.white,
                    ),
                    width: 35,
                    height: 35,
                    child: Icon(
                      IconBroken.Edit,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget NotitcatonItem(ctx, text, subText) {
  return Card(
    elevation: 3,
    margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.r),
    ),
    child: Column(
      children: [
        ClipRRect(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: 120.h,
            ),
            padding: EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(ctx).cardColor,
                borderRadius: BorderRadius.circular(25.r)),
            child: Container(
              width: 180.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            '$text',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: 15.w, left: 15.w, top: 15.h),
                              child: Row(
                                children: [
                                  Text(
                                    '$subText',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 10.0, // shadow blur
                                          color: Colors.black26, // shadow color
                                          offset: Offset(2.0,
                                              2.0), // how much shadow will be shown
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget gradientButton(
    {required BuildContext context, dynamic onPressed, Widget? title}) {
  return Container(
    clipBehavior: Clip.antiAlias,
    width: MediaQuery.of(context).size.width,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: Color(0xffC9574D),
    ),
    child: MaterialButton(
      onPressed: onPressed,
      child: title,
    ),
  );
}

Widget gradientButtonAdd(
    {required BuildContext context, dynamic onPressed, Widget? title}) {
  return Container(
    clipBehavior: Clip.antiAlias,
    height: 60.h,
    width: 60.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xffC9574D),
    ),
    child: MaterialButton(
      onPressed: onPressed,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    ),
  );
}

Widget SpecialistItem(
    {@required context,
    @required id,
    @required Image,
    @required name,
    @required cubit}) {
  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Column(
      children: [
        Container(
          width: 150.w,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.r),
                      child: CachedNetworkImage(
                        imageUrl: '$Image',
                        placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 1.5.w,
                        )),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: Color(0xffC9574D),
                        ),
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          backgroundImage: imageProvider,
                          radius: 40.r,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white10),
                padding: EdgeInsets.only(top: 10.h),
                child: Text(
                  '$name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {
                      await showPopup(context, () {
                        cubit!.DeleteEmployee(id: id);
                        Navigator.of(context).pop();
                      });
                    },
                    child: Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Color(0xffC9574D),
                        ),
                        child: Icon(Icons.delete)),
                  ),
                  InkWell(
                    onTap: () {
                      showPopupUpdatstaff(
                        id,
                        name,
                        context,
                        cubit!,
                      );
                    },
                    child: Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Color(0xffC9574D),
                        ),
                        child: Icon(Icons.edit)),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 5,
    margin: EdgeInsets.all(10),
  );
}

Widget SpecialistItem2({@required Image, @required name}) {
  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Container(
      width: 120.w,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: Colors.blueAccent)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              child: Image.network(
                Image,
                fit: BoxFit.fill,
                height: 100.h,
                width: 100.w,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.h),
            width: 80.w,
            child: Text(
              '$name',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 5,
    margin: EdgeInsets.all(10),
  );
}

Widget CardItemHajzi(
    {@required img, @required date, @required time, @required name}) {
  return Card(
    elevation: 3,
    margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.r),
    ),
    child: ClipRRect(
      child: Container(
        padding: EdgeInsets.all(12),
        height: 175.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25.r)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$date',
                  style: GoogleFonts.notoKufiArabic(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  '    -    ',
                  style: GoogleFonts.notoKufiArabic(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  '$time',
                  style: GoogleFonts.notoKufiArabic(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.w),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.r)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.r),
                    child: Image.network(
                      '$img',
                      height: 80.h,
                      width: 80.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: Text(
                        '$name',
                        style: GoogleFonts.notoKufiArabic(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.delete)
              ],
            ),
            Divider()
          ],
        ),
      ),
    ),
  );
}

Widget CardItem(ctx) {
  return InkWell(
    onTap: () {},
    child: Card(
      elevation: 3,
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: ClipRRect(
        child: Container(
          padding: EdgeInsets.all(12),
          height: 120.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25.r)),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.w),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(25.r)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: Image.network(
                    'https://media.gemini.media/img/large/2018/4/4/2018_4_4_16_0_54_209.jpg',
                    width: 100.w,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'صالون الأكابر',
                        style: GoogleFonts.notoKufiArabic(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 40.w,
                      ),
                      Icon(Icons.favorite)
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Text(
                      'غزة',
                      style: GoogleFonts.notoKufiArabic(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      Text(
                        '1.7 km',
                        style: GoogleFonts.notoKufiArabic(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.red,
                      ),
                      Text(
                        '4.5',
                        style: GoogleFonts.notoKufiArabic(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget CardItemOrder({
  HallaqCubit? cubit,
  id,
  ctx,
  text,
  image,
  date,
  time,
  number,
  status,
  mobilenumber,
  employee_name,
}) {
  return InkWell(
    onTap: () {
      navigatorPush(
          ctx,
          DetailsScreen(id, text, image, date, time, number, status,
              mobilenumber, employee_name));
    },
    child: Card(
      elevation: 3,
      margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Column(
        children: [
          ClipRRect(
            child: Container(
              constraints: BoxConstraints(maxHeight: 250.h, minHeight: 180.h),
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(ctx).cardColor,
                  borderRadius: BorderRadius.circular(25.r)),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.w),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(25.r)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.r),
                        child: Image.network(
                          '$image',
                          width: 100.w,
                          height: 120.h,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      width: 180.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 5.h),
                                constraints: BoxConstraints(maxWidth: 180.w),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        text,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.notoKufiArabic(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      if (status == 'pending')
                                        Container(
                                          width: 70.w,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  showPopupAcceptedAndRejected(
                                                      id, 'قبول', ctx, cubit!,
                                                      () {
                                                    cubit.AceptOrReject(
                                                        order_id: id,
                                                        status: 'accepted');
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showPopupAcceptedAndRejected(
                                                      id, 'رفض', ctx, cubit!,
                                                      () {
                                                    cubit.AceptOrReject(
                                                        order_id: id,
                                                        status: 'rejected');
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'رقم الحجز : ',
                                style: GoogleFonts.notoKufiArabic(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                '$number',
                                style: GoogleFonts.notoKufiArabic(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'تاريخ الحجز: ',
                                style: GoogleFonts.notoKufiArabic(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                '$date',
                                style: GoogleFonts.notoKufiArabic(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'وقت الحجز: ',
                                style: GoogleFonts.notoKufiArabic(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                '$time',
                                style: GoogleFonts.notoKufiArabic(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'رقم جوال : ',
                                style: GoogleFonts.notoKufiArabic(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Container(
                                width: 100.w,
                                child: Text(
                                  '$mobilenumber',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.notoKufiArabic(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'حالة الحجز: ',
                                style: GoogleFonts.notoKufiArabic(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                cubit!.acceptedorrejectedmodel != null
                                    ? cubit.acceptedorrejectedmodel!.data!
                                                .status ==
                                            'c'
                                        ? 'مقبول'
                                        : cubit.acceptedorrejectedmodel!.data!
                                                    .status ==
                                                'rejected'
                                            ? 'مرفوض'
                                            : 'معلق'
                                    : status == 'accepted'
                                        ? 'مقبول'
                                        : status == 'rejected'
                                            ? 'مرفوض'
                                            : 'معلق',
                                style: GoogleFonts.notoKufiArabic(
                                    color: status == 'pending'
                                        ? Colors.blue
                                        : status == 'rejected'
                                            ? Colors.red
                                            : Colors.green,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Future<bool> showPopup(
  context,
  func1,
) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 120.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Text(' هل متأكد من الحذف ؟'),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: func1,
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

Future<bool> showPopupUpdatstaff(
  id,
  name,
  context,
  LoginCubit cubit,
) async {
  TextEditingController nameController = TextEditingController(text: name);

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
                Text('تعديل إسم الموظف'),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: nameController,
                  cursorColor: indigo,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'تعديل الاسم',
                    prefixIcon: Icon(IconBroken.Profile),
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    errorBorder: enabledBorder,
                    focusedErrorBorder: focusedBorder,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          cubit.UpdateEmployess(
                              name: nameController.text, id: id);
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

Widget MyTimeWork({ctx, day, from, to, id, countery_id}) {
  return Card(
    elevation: 4,
    child: Container(
      height: 45.h,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
      margin: EdgeInsets.only(bottom: 0.h, top: 0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
            width: 50.w,
            child: Center(
                child: InkWell(
                    onTap: () {
                      navigatorPush(
                          ctx,
                          EditTimeWorkScreen(
                            day: day,
                            form: from,
                            to: to,
                            id: id,
                            countery_id: id,
                          ));
                    },
                    child: Icon(Icons.edit))),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffC9574D),
                  borderRadius: BorderRadius.circular(0.r)),
              width: 120.w,
              child: Center(
                child: Text(
                  ' $day',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            width: 50.w,
            child: Center(
              child: Text(
                '$from',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
            width: 30.w,
            child: Center(
              child: Text(
                'إلى',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
            width: 50.w,
            child: Center(
              child: Text(
                '$to',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget DetailsCard(title, value) {
  return Card(
    elevation: 4,
    child: Container(
      height: 45.h,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
      margin: EdgeInsets.only(bottom: 0.h, top: 0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffC9574D),
                  borderRadius: BorderRadius.circular(0.r)),
              width: 120.w,
              child: Center(
                child: Text(
                  ' $title',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            width: 200.w,
            child: Center(
              child: Text(
                '$value',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
        ],
      ),
    ),
  );
}

Future<bool> showPopupAcceptedAndRejected(
    id, name, context, HallaqCubit cubit, fun) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 150.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Text('هل أنت متأكد من $name الطلب'),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: fun,
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
