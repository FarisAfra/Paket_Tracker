import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/icon_button.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';
import 'package:paket_tracker_app/screens/widgets/inputs/textfields_icon.dart';
import 'package:paket_tracker_app/screens/widgets/spacer.dart';

class LacakPaket extends StatefulWidget {
  const LacakPaket({super.key});

  @override
  State<LacakPaket> createState() => _LacakPaketState();
}

class _LacakPaketState extends State<LacakPaket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.BgPutih,
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              children: [LacakPaketWidget()],
            ),
          )),
        ));
  }
}

Widget LacakPaketWidget() {
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    child: Container(
      color: AppColors.BiruSecondary,
      child: Stack(
        children: [
          Align(
            alignment: Alignment(1, 0),
            child: Image.asset(AppIcons.IcLocationBigTransparent),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lacak Paket Anda',
                        style: AppFonts.poppinsRegular(fontSize: 18)),
                    Text('Silahkan Masukkan No. Resi Paket Anda',
                        style: AppFonts.poppinsExtraLight(fontSize: 12)),
                    AppSpacer.VerticalSpacerSmall,
                    Row(
                      children: [
                        CustomTextfieldsIcon(
                          icons: AppIcons.IcPackageSearchGrey,
                          hintText: 'Masukkan No. Resi',
                        ),
                        AppSpacer.HorizontalSpacerSmall,
                        CustomIconButton(
                          icons: AppIcons.IcTrackWhite,
                          bgColor: AppColors.BiruPrimary,
                          handler: () {},
                        ),
                      ],
                    ),
                    AppSpacer.VerticalSpacerSmall,
                    CustomTextfieldsIcon(
                      width: 310,
                      icons: AppIcons.IcTruckGrey,
                      hintText: 'Pilih Kurir',
                    ),
                    AppSpacer.VerticalSpacerExtraSmall,
                    MaterialButton(
                      onPressed: () {},
                      child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.BiruPrimary,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppIcons.IcTrackWhite,
                                  height: 20,
                                ),
                                AppSpacer.HorizontalSpacerSmall,
                                Text('Lacak Paket Saya', style: AppFonts.poppinsRegular(color: AppColors.Putih),)
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              ))
        ],
      ),
    ),
  );
}
