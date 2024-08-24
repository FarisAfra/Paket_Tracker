import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/icon_button.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BgPutih,
      appBar: AppBar(
        leading: 
        Row(
          children: [
            SizedBox(width: 20),
            Image.asset('assets/images/placeholder_avatar.png', height: 36),
          ],
        ),
        title: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Halo, Selamat Datang', style: AppFonts.poppinsLight()),
              Text('Lorem Ipsum',
                  style: AppFonts.poppinsExtraBold(fontSize: 16)),
            ],
          ),
        ),
        actions: [
          CustomIconButton(),
          SizedBox(width: 20)
        ],
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                color: AppColors.BiruSecondary,
                height: 132,
                child: Stack(
                  children: [],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
