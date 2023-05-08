import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

class Hajz extends StatefulWidget {
  @override
  State<Hajz> createState() => _HajzState();
}

class _HajzState extends State<Hajz> {
  int Index = 1;
  Color color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.notifications,
              color: Colors.black,
              size: 30,
            ),
          ),
          actions: [
            Container(
                margin: EdgeInsets.only(left: 10),
                child: Center(
                    child: Text(
                  'احجز موعد',
                  style: GoogleFonts.notoKufiArabic(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ))),
            Container(
                margin: EdgeInsets.only(left: 20),
                child: Icon(IconBroken.Arrow___Left_2)),
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ساعات العمل',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {
                            setState(() {
                              Index = index;
                              color = Colors.blue;
                              print(Index);
                              print(index);
                            });
                          },
                          child: TimeItem(
                              Index == index ? Colors.blue : Colors.white));
                    }),
              ),
              Text(
                'المتخصصون',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 170.h,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) =>
                        SpecialistItem()),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15.h),
                child: gradientButton(
                    context: context,
                    title: Text(
                      'إحجز الآن ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      ShowDigalog();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget TimeItem(color) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
          color: color, width: 80.w, child: Center(child: Text('09:00'))),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }

  ShowDigalog() {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        content: Container(
          height: 400.h,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.h),
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blueAccent)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 80.r,
                    )),
              ),
              Text(
                'تم الحجز بنجاح',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.h),
                child: Center(
                  child: Text(
                    'في حال حدوث جديد سيتم إرسال إشعار لك أو رسالة ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30.h),
                child: gradientButton(
                    context: context,
                    title: Text(
                      'الرجوع للصفحةالرئيسية',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
