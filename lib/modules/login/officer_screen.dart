import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shop_app/layout/home_layout.dart';

import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/login/staff_info_screen.dart';
// import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';

// ignore: must_be_immutable
class OfficerScreen extends StatelessWidget {
  var formState = GlobalKey<FormState>();
  TextEditingController mobilController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit()..getEmployees(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is UpdateEmployessSuccessState) {
            navigatorReplacement(context, OfficerScreen());
            MotionToast.success(
              title: "تمت العملية",
              titleStyle: TextStyle(fontWeight: FontWeight.bold),
              description: 'تم تحديث البيانات',
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
          if (state is HallaqSuccessCancelEmployeeState) {
            MotionToast.success(
              title: "تمت العملية",
              titleStyle: TextStyle(fontWeight: FontWeight.bold),
              description: 'تم حذف الموظف',
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
          LoginCubit cubit = LoginCubit.get(context);
          return ModalProgressHUD(
            inAsyncCall: state is LoginLoadingState,
            color: Colors.white,
            opacity: 0.5,
            progressIndicator: CircularProgressIndicator(),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    'معلومات الموظفين',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ),
                ),
                resizeToAvoidBottomInset: false,
                body: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle(
                      statusBarColor: Colors.red,
                      statusBarIconBrightness: Brightness.light),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'الموظفين',
                                style: TextStyle(
                                    color: Color(0xffC9574D),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                '(ملاحظة يجب اضافة موظف على الاقل)',
                                style: TextStyle(
                                    color: Color(0xffC9574D),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                            constraints: new BoxConstraints(
                              minHeight: 40.h,
                              maxHeight: 370.h,
                            ),
                            child:
                            LoginCubit.get(context).employeesModel != null
                                ? LoginCubit.get(context)
                                .employeesModel!
                                .data!
                                .length !=
                                0
                                ? GridView.count(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,

                              // Create a grid with 2 columns. If you change the scrollDirection to
                              // horizontal, this produces 2 rows.
                              crossAxisCount: 2,
                              // Generate 100 widgets that display their index in the List.
                              children: List.generate(
                                  LoginCubit.get(context)
                                      .employeesModel!
                                      .data!
                                      .length, (index) {
                                return SpecialistItem(
                                    id: LoginCubit.get(context)
                                        .employeesModel!
                                        .data![index]
                                        .id,
                                    cubit: cubit,
                                    context: context,
                                    Image: LoginCubit.get(context)
                                        .employeesModel!
                                        .data![index]
                                        .image,
                                    name: LoginCubit.get(context)
                                        .employeesModel!
                                        .data![index]
                                        .name);
                              }),
                            )
                                : Lottie.asset(
                              'assets/lottiefiles/empty.json',
                              width: 200.w,
                              height: 200.h,
                            )
                                : CircularProgressIndicator(),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            child: gradientButtonAdd(
                                context: context,
                                title: Text(
                                  'إضافة موظف ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.sp),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  navigatorPush(context, StaffInfoScreen());
                                  // if (formState.currentState!.validate()) {
                                  //   navigatorPush(context, MyVerify());
                                  // }
                                }),
                          ),
                          SizedBox(
                            height: 50.0.h,
                          ),
                          gradientButton(
                              context: context,
                              title: Text(
                                'التالي ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.sp),
                              ),
                              onPressed: () {
                                navigatorReplacement(
                                    context, HallaqLayoutScreen());
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
