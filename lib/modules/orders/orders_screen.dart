import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/shared/components/components.dart';

import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../shared/styles/icon_broken.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HallaqCubit, HallaqStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HallaqCubit cubit = HallaqCubit.get(context);
        return Scaffold(
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
                    'حجوزاتي',
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
          body: Column(
            children: [
              CardItemHajzi(),
              CardItemHajzi(),
            ],
          ),
        );
      },
    );
  }
}
