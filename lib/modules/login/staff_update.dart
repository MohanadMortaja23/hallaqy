import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/icon_broken.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'officer_screen.dart';

class updatestaff extends StatelessWidget {
  final name;
  final image;
  var formState = GlobalKey<FormState>();

  updatestaff(this.name, this.image);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: name);

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is AddEmployessSuccessState) {
            if (state.employeesModel.status!) {
              navigatorReplacement(context, OfficerScreen());
              MotionToast.success(
                title: "تمت إضافة موظف",
                titleStyle: TextStyle(fontWeight: FontWeight.bold),
                description: 'تمت إضافة موظف في صالونك ',
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
              print(state.employeesModel.message);
              MotionToast.error(
                title: "Error",
                titleStyle: TextStyle(fontWeight: FontWeight.bold),
                description: state.employeesModel.message!,
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
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  'تعديل موظف',
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 25.sp, fontWeight: FontWeight.bold)),
                ),
              ),
              body: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    decoration: const BoxDecoration(color: Colors.white),
                  ),
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
                                  LoginCubit.get(context).getImageFromGallery();
                                },
                                child: CircleAvatar(
                                  radius: 60.r,
                                  backgroundColor: Color(0xffC9574D),
                                  child: CircleAvatar(
                                    radius: 55.r,
                                    backgroundColor: Colors.white,
                                    child: LoginCubit.get(context).file != null
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
                                              imageUrl: '$image',
                                              placeholder: (context, url) =>
                                                  Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                strokeWidth: 1.5.w,
                                              )),
                                              errorWidget:
                                                  (context, url, error) => Icon(
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
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      TextFormField(
                                        controller: nameController,
                                        cursorColor: indigo,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: '$name',
                                          prefixIcon: Icon(IconBroken.Profile),
                                          enabledBorder: enabledBorder,
                                          focusedBorder: focusedBorder,
                                          errorBorder: enabledBorder,
                                          focusedErrorBorder: focusedBorder,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.0.h,
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: ConditionalBuilder(
                                          fallback: (context) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          condition: state
                                              is! AddEmployessLoadingState,
                                          builder: (context) => gradientButton(
                                              context: context,
                                              title: Text(
                                                'تعديل ',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.sp),
                                              ),
                                              onPressed: () {
                                                LoginCubit.get(context)
                                                    .AddEmployess(
                                                        name:
                                                            nameController.text,
                                                        img: LoginCubit.get(
                                                                context)
                                                            .file);
                                                // navigatorPush(context, MyVerify());
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
