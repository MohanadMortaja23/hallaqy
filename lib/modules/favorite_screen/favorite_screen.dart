import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../shared/styles/icon_broken.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Icon(
                  IconBroken.Arrow___Right_2,
                  color: Colors.black,
                  size: 35,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Center(
                      child: Text(
                    'المفضلة',
                    style: GoogleFonts.notoKufiArabic(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ))),
            ],
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.notifications,
                color: Colors.black,
                size: 30,
              ),
            ),
          ],
        ),
        body: Column(
          children: [CardItem(context)],
        ),
      ),
    );
  }
}
