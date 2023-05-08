import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/login/register_screen.dart';
import 'package:shop_app/modules/login/verify.dart';
// import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var formState = GlobalKey<FormState>();
  TextEditingController mobilController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          // if (state is LoginSuccessState) {
          //    navigatorPush(context, MyVerify());
          // }

          if (state is LoginSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);

              print('==============================');
              print('==============================');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return MyVerify(mobilController.text);
              }));
              MotionToast.success(
                title: "Success",
                titleStyle: TextStyle(fontWeight: FontWeight.bold),
                description: state.loginModel.message!,
                descriptionStyle: TextStyle(
                    //overflow: TextOverflow.ellipsis,
                    ),
                animationType: ANIMATION.FROM_LEFT,
                position: MOTION_TOAST_POSITION.TOP,
                borderRadius: 10.0,
                width: 300,
                height: 65,
              ).show(context);
            } else {
              print(state.loginModel.message);
              MotionToast.error(
                title: "خطأ",
                titleStyle: TextStyle(fontWeight: FontWeight.bold),
                description: 'يرجى تسجيل حساب جديد',
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
          if (state is LoginErrorState2) {
            print('==============================');
            print('==============================');

            MotionToast.success(
              title: "حدث خطأ",
              titleStyle: TextStyle(fontWeight: FontWeight.bold),
              description: state.error.message!,
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
          return ModalProgressHUD(
            inAsyncCall: state is LoginLoadingState,
            color: Colors.white,
            opacity: 0.5,
            progressIndicator: Lottie.asset(
              'assets/lottiefiles/loader2.json',
              width: 200,
              height: 200,
            ),
            child: Stack(
              children: [
                Container(),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: MediaQuery.of(context).size.height,
                //   child: SvgPicture.asset(
                //     'assets/images/bg.svg',
                //     fit: BoxFit.cover,
                //   ),
                // ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      centerTitle: true,
                      title: Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    resizeToAvoidBottomInset: false,
                    body: AnnotatedRegion<SystemUiOverlayStyle>(
                      value: SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarIconBrightness: Brightness.light),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Form(
                          key: formState,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    child: Image.asset('assets/images/myicon.png',
                                        height: 200.h, width: 150.w)),
                                Container(
                                  padding: EdgeInsets.only(top: 20.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'أدخل رقم الهاتف للتحقق برسالة',
                                        style: (TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffC9574D),
                                          fontSize: 18.sp,
                                        )),
                                      ),
                                      SizedBox(
                                        width: 0,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: mobilController,
                                  cursorColor: indigo,
                                  keyboardType: TextInputType.phone,
                                  validator: (dynamic value) {
                                    if (value.isEmpty) {
                                      return 'أدخل رقم الهاتف للتحقق ';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: 'رقم الهاتف',
                                    labelStyle: GoogleFonts.tajawal(
                                        textStyle: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18.sp,
                                    )),
                                    prefixIcon: Icon(IconBroken.Call),
                                    enabledBorder: enabledBorder,
                                    focusedBorder: focusedBorder,
                                    errorBorder: enabledBorder,
                                    focusedErrorBorder: focusedBorder,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                ConditionalBuilder(
                                    fallback: (context) => Center(
                                        child: CircularProgressIndicator()),
                                    condition: state is! LoginLoadingState,
                                    builder: (context) {
                                      return gradientButton(
                                          context: context,
                                          title: Text(
                                            'تحقق ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.sp),
                                          ),
                                          onPressed: () {
                                            if (formState.currentState!
                                                .validate()) {
                                              LoginCubit.get(context).userLogin(
                                                  phone: mobilController.text,
                                                  device_name: 'postman',
                                                  device_token:
                                                      LoginCubit.get(context)
                                                          .myToken,
                                                  type: 'partners/login');
                                              //     navigatorPush(context, MyVerify());
                                            }
                                          });
                                    }),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  children: [
                                    Spacer(),
                                    TextButton(
                                        onPressed: () {
                                          navigatorPush(
                                              context, RegisterScreen());
                                        },
                                        child: Text(
                                          "تسجيل حساب جديد",
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
