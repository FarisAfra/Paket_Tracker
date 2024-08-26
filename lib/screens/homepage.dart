import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/icon_button.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/icon_text_button.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/nav_button.dart';
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
  int _currentIndex = 0;

  Widget _getCurrentWidget() {
    switch (_currentIndex) {
      case 0:
        return KontenHomepage();
      case 1:
        return LacakPaket();
      default:
        return KontenHomepage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //konten
        _getCurrentWidget(),

        //navbar
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 90,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomNavButton(
                      icons: _currentIndex == 0
                      ? AppIcons.IcNavHomeBlue
                      : AppIcons.IcNavHomeBlack, 
                      handler: () {}),
                  CustomNavButton(
                      icons: _currentIndex == 1
                      ? AppIcons.IcNavOngkirBlue
                      : AppIcons.IcNavOngkirBlack, 
                      handler: () {}),
                  Container(width: 75),
                  CustomNavButton(
                      icons: _currentIndex == 4
                      ? AppIcons.IcNavBookmarkBlue
                      : AppIcons.IcNavBookmarkBlack, 
                      handler: () {}),
                  CustomNavButton(
                      icons: _currentIndex == 5
                      ? AppIcons.IcNavHistoryBlue
                      : AppIcons.IcNavHistoryBlack, 
                      handler: () {}),
                ],
              ),
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(padding: EdgeInsets.only(bottom: 12),
              child: CustomNavButton(
                      icons: AppIcons.IcNavTrackBtn, 
                      height: 90, 
                      handler: () {}),)
            )
      ],
    );
  }
}

class KontenHomepage extends StatefulWidget {
  const KontenHomepage({super.key});

  @override
  State<KontenHomepage> createState() => _KontenHomepageState();
}

class _KontenHomepageState extends State<KontenHomepage> {
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
            CustomIconButton(
                icons: AppIcons.IcNotificationBlue, handler: () {}),
            SizedBox(width: 20)
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              children: [
                LacakPaket(),
                AppSpacer.VerticalSpacerLarge,
                FeatureApp(),
                TitleDetail(
                    textTitle: 'Pencarian Terakhir',
                    textDetail: 'Lihat Semua',
                    handler: () {}),
                DataRiwayatTerakhir(),
                TitleDetail(
                    textTitle: 'Bookmark Anda',
                    textDetail: 'Lihat Semua',
                    handler: () {}),
                Container(
                  height: 170,
                  child: Expanded(child: DataBookmark()),
                ),
                SizedBox(height: 64)
              ],
            ),
          )),
        ));
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
                        AppSpacer.HorizontalSpacerSmall,
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
              Spacer(),
              CustomIconTextButton(
                  icons: AppIcons.IcTrackBlue,
                  text: 'Lacak\nPaket',
                  handler: () {}),
              Spacer(),
              CustomIconTextButton(
                  icons: AppIcons.IcOngkirBlue,
                  text: 'Cek\nOngkir',
                  handler: () {}),
              Spacer(),
              CustomIconTextButton(
                  icons: AppIcons.IcBookmarkBlue,
                  text: 'Bookmark\nSaya',
                  handler: () {}),
              Spacer(),
              CustomIconTextButton(
                  icons: AppIcons.IcHistoryBlue,
                  text: 'Riwayat\nPencarian',
                  handler: () {}),
            ]),
          ),
        )),
  );
}

Widget DataRiwayatTerakhir() {
  List<Map<String, String>> items = [
    {
      "awb": "JT1000927741",
      "courier": "J&T Express",
      "origin": "Jakarta, Indonesia, Dunia, Bima Sakti",
      "destination": "Bogor, Jawa Barat, Indonesia, Dunia, Bima Sakti",
      "shiper": "Apple Store",
      "reciever": "Faris Afra M",
      "desc": "Processed At Sorting Center [Depok, Jawa barat]"
    },
  ];

  return Center(
    child: Container(
      width: double.infinity,
      child: Column(
        children: [
          Card(
            color: Colors.white,
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
                          Text(items[0]["awb"]!, style: AppFonts.poppinsBold()),
                          Text(
                            '${items[0]["courier"]}',
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
                            Container(
                              child: Text(
                                  '${items[0]["shiper"]}, ${items[0]["origin"]}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFonts.poppinsBold(fontSize: 14)),
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
                            Container(
                              child: Text(
                                  '${items[0]["reciever"]}, ${items[0]["destination"]}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFonts.poppinsBold(fontSize: 14)),
                            ),
                            AppSpacer.VerticalSpacerLarge
                          ],
                        ),
                      )),
                  Divider(color: AppColors.BgPutih),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status: ',
                          style: AppFonts.poppinsLight(fontSize: 12)),
                      Flexible(
                        child: Text(items[0]["desc"]!,
                            style: AppFonts.poppinsBold(fontSize: 12)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget DataBookmark() {
  List<Map<String, String>> items = [
    {
      "name": "Macbook Pro 14 Inch (Grey)",
      "awb": "JT1000927741",
      "courier": "J&T Express",
      "origin": "Jakarta, Indonesia, Dunia, Bima Sakti",
      "destination": "Bogor, Jawa Barat, Indonesia, Dunia, Bima Sakti",
      "shiper": "Apple Store",
      "reciever": "Faris Afra M",
      "desc": "Processed At Sorting Center [Depok, Jawa barat]"
    },
    {
      "name": "Macbook Pro 14 Inch (Grey)",
      "awb": "JT1000927741",
      "courier": "J&T Express",
      "origin": "Jakarta, Indonesia, Dunia, Bima Sakti",
      "destination": "Bogor, Jawa Barat, Indonesia, Dunia, Bima Sakti",
      "shiper": "Apple Store",
      "reciever": "Faris Afra M",
      "desc": "Processed At Sorting Center [Depok, Jawa barat]"
    },
    {
      "name": "Macbook Pro 14 Inch (Grey)",
      "awb": "JT1000927741",
      "courier": "J&T Express",
      "origin": "Jakarta, Indonesia, Dunia, Bima Sakti",
      "destination": "Bogor, Jawa Barat, Indonesia, Dunia, Bima Sakti",
      "shiper": "Apple Store",
      "reciever": "Faris Afra M",
      "desc": "Processed At Sorting Center [Depok, Jawa barat]"
    },
  ];

  return Center(
    child: ListView.builder(
      itemCount: 2,
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
                        Text(item["name"]!, style: AppFonts.poppinsBold()),
                        Text(
                          '${item["courier"]}',
                          style: AppFonts.poppinsMedium(fontSize: 10),
                        ),
                        Text(
                          'Tracking ID: ${item["awb"]}',
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
              ],
            ),
          )),
        );
      },
    ),
  );
}
