import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/errors/comming_soon.dart';
import 'package:paket_tracker_app/screens/widgets/errors/error_nodata_screen.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';

class RiwayatPencarian extends StatefulWidget {
  const RiwayatPencarian({super.key});

  @override
  State<RiwayatPencarian> createState() => _RiwayatPencarianState();
}

class _RiwayatPencarianState extends State<RiwayatPencarian> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BgPutih,
      body: CommingSoonState()
    );
  }
}