import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/errors/comming_soon.dart';

class CekOngkir extends StatefulWidget {
  const CekOngkir({super.key});

  @override
  State<CekOngkir> createState() => _CekOngkirState();
}

class _CekOngkirState extends State<CekOngkir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BgPutih,
      body: CommingSoonState()
    );
  }
}
