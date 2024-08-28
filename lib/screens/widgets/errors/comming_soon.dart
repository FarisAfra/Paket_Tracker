import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/cek_ongkir.dart';
import 'package:paket_tracker_app/screens/homepage.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/primary_button.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';
import 'package:paket_tracker_app/screens/widgets/spacer.dart';

class CommingSoonState extends StatelessWidget {
  const CommingSoonState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Comming Soon',
              style:
                  AppFonts.poppinsBold(fontSize: 24, color: AppColors.AbuTua)),
          AppSpacer.VerticalSpacerMedium,
          Text(
              'Mohon Maaf, Fitur Ini Masih Dalam Tahap Pengembangan, Mohon Doa dan Supportnya, Agar Dapat Selesai Dengan Cepat, Terima Kasih',
              textAlign: TextAlign.center,
              style: AppFonts.poppinsRegular(
                  fontSize: 12, color: AppColors.AbuMuda)),
          AppSpacer.VerticalSpacerMedium,
          PrimaryButton(
            Icons: AppIcons.IcHomeWhite,
            HintText: 'Kembali Ke Homepage',
            bgColor: AppColors.AbuTua, 
            handler: () { 
              Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CekOngkir()),
                        );
             },
          )
        ],
      ),
    ));
  }
}
