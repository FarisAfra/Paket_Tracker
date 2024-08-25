import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/icon_button.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/icon_text_button.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';
import 'package:paket_tracker_app/screens/widgets/images/logo_kurir.dart';
import 'package:paket_tracker_app/screens/widgets/inputs/textfields_icon.dart';
import 'package:paket_tracker_app/screens/widgets/spacer.dart';
import 'package:paket_tracker_app/screens/widgets/texts/title_detail.dart';
import 'package:timeline_tile/timeline_tile.dart';

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
        leading: Row(
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
          CustomIconButton(icons: AppIcons.IcNotificationBlue, handler: () {}),
          SizedBox(width: 20)
        ],
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          children: [
            LacakPaket(),
            AppSpacer.VerticalSpacerLarge,
            FeatureApp(),
            AppSpacer.VerticalSpacerSmall,
            TitleDetail(
                textTitle: 'Pencarian Terakhir',
                textDetail: 'Lihat Semua',
                handler: () {}),
            AppSpacer.VerticalSpacerSmall,
            Expanded(child: DataRiwayatBuilder())
          ],
        ),
      )),
    );
  }
}

Widget LacakPaket() {
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    child: Container(
      color: AppColors.BiruSecondary,
      height: 132,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(AppIcons.IcLocationTransparent),
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
                        CustomTextfieldsIcon(),
                        AppSpacer.HorizontalSpacerExtraSmall,
                        CustomIconButton(
                          icons: AppIcons.IcTrackWhite,
                          bgColor: AppColors.BiruPrimary,
                          handler: () {},
                        )
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    ),
  );
}

Widget FeatureApp() {
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    child: Container(
        color: AppColors.Putih,
        height: 132,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                'assets/images/logo_app_2_blue.png',
                width: 45,
              ),
              AppSpacer.HorizontalSpacerLarge,
              CustomIconTextButton(
                  icons: AppIcons.IcTrackBlue,
                  text: 'Lacak\nPaket',
                  handler: () {}),
              AppSpacer.HorizontalSpacerLarge,
              CustomIconTextButton(
                  icons: AppIcons.IcOngkirBlue,
                  text: 'Cek\nOngkir',
                  handler: () {}),
              AppSpacer.HorizontalSpacerLarge,
              CustomIconTextButton(
                  icons: AppIcons.IcBookmarkBlue,
                  text: 'Bookmark\nSaya',
                  handler: () {}),
              AppSpacer.HorizontalSpacerLarge,
              CustomIconTextButton(
                  icons: AppIcons.IcHistoryBlue,
                  text: 'Riwayat\nPencarian',
                  handler: () {}),
            ]),
          ),
        )),
  );
}

Widget DataRiwayatBuilder() {
  List<Map<String, String>> items = [
    {
      "awb": "JT1000927741",
      "courier": "J&T Express",
      "origin": "Jakarta, Indonesia",
      "destination": "Bogor, Jawa Barat",
      "shiper": "Apple Store",
      "reciever": "Faris Afra M",
      "desc": "Processed At Sorting Center [Depok]"
    },
  ];

  return Center(
    child: ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, index) {
        var item = items[index];
        return Card(
          color: Colors.white,
          child: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LogoJNT(),
                    AppSpacer.HorizontalSpacerLarge,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('JT100092322', style: AppFonts.poppinsBold()),
                        Text(
                          'Kurir: J&T',
                          style: AppFonts.poppinsLight(fontSize: 10),
                        )
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Image.asset(
                        AppIcons.IcMoreBlack,
                        height: 20,
                      ),
                    )
                  ],
                ),
                Divider(color: AppColors.BgPutih),

                TimelineTile(
                    alignment: TimelineAlign.start,
                    isFirst: true,
                    indicatorStyle:
                        IndicatorStyle(color: AppColors.Hitam, width: 10),
                    beforeLineStyle:
                        LineStyle(color: AppColors.AbuMuda, thickness: 2),
                    endChild: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSpacer.VerticalSpacerLarge,
                          Text(
                            'Pengirim:',
                            style: AppFonts.poppinsLight(fontSize: 12),
                          ),
                          Row(
                            children: [
                              Text('Apple Store, ',
                                  style: AppFonts.poppinsBold(fontSize: 14)),
                              Text('Jakarta',
                                  style: AppFonts.poppinsBold(fontSize: 14)),
                            ],
                          ),
                          AppSpacer.VerticalSpacerLarge
                        ],
                      ),
                    )),
                
                TimelineTile(
                    alignment: TimelineAlign.start,
                    isLast: true,
                    indicatorStyle:
                        IndicatorStyle(color: AppColors.AbuMuda, width: 10),
                    beforeLineStyle:
                        LineStyle(color: AppColors.AbuMuda, thickness: 2),
                    endChild: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSpacer.VerticalSpacerLarge,
                          Text(
                            'Penerima:',
                            style: AppFonts.poppinsLight(fontSize: 12),
                          ),
                          Row(
                            children: [
                              Text('Faris Afra, ',
                                  style: AppFonts.poppinsBold(fontSize: 14)),
                              Text('Bogor',
                                  style: AppFonts.poppinsBold(fontSize: 14)),
                            ],
                          ),
                          AppSpacer.VerticalSpacerLarge
                        ],
                      ),
                    )),
                
                Divider(color: AppColors.BgPutih),

                Row(
                  children: [
                    Text('Status: ',
                        style: AppFonts.poppinsLight(fontSize: 12)),
                    Text('Processed At Sorting Center [Depok]', style: AppFonts.poppinsBold(fontSize: 12)),
                  ],
                )
              ],
            ),
          )),
        );
      },
    ),
  );
}
