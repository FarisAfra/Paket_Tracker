import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/bookmark_paket.dart';
import 'package:paket_tracker_app/screens/cek_ongkir.dart';
import 'package:paket_tracker_app/screens/lacak_paket.dart';
import 'package:paket_tracker_app/screens/riwayat_pencarian.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/icon_button.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/icon_text_button.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/nav_button.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/errors/card_button_error_widget.dart';
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
  String _currentResi = '';

  Widget _getCurrentWidget() {
    switch (_currentIndex) {
      case 0:
        return KontenHomepage(onSectionSelected: _onSectionSelected);
      case 1:
        return CekOngkir();
      case 2:
        return LacakPaket(resi: _currentResi,);
      case 3:
        return BookmarkPaket();
      case 4:
        return RiwayatPencarian();
      default:
        return KontenHomepage(onSectionSelected: _onSectionSelected);
    }
  }

  void _onSectionSelected(int index, [String resi = '']) {
    setState(() {
      _currentIndex = index;
      if (resi.isNotEmpty) {
        _currentResi = resi;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BgPutih,
      appBar: _currentIndex == 0
          ? AppBar(
              backgroundColor: AppColors.Putih,
              leading: Row(
                children: [
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: Image.asset('assets/images/placeholder_avatar.png',
                      height: 36),
                  ),
                ],
              ),
              title: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Halo, Selamat Datang',
                        style: AppFonts.poppinsLight()),
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
            )
          : AppBar(
              backgroundColor: AppColors.Putih,
              leading: Row(
                children: [
                  SizedBox(width: 20),
                  CustomIconButton(
                      icons: AppIcons.IcBackBlue,
                      bgColor: AppColors.Putih,
                      handler: () {
                        setState(() {
                          _currentIndex = 0;
                        });
                      })
                ],
              ),
              title: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Paket Tracker', style: AppFonts.poppinsLight()),
                    Text(
                        _currentIndex == 1
                            ? 'Cek Ongkir'
                            : _currentIndex == 2
                                ? 'Lacak Paket'
                                : _currentIndex == 3
                                    ? 'Bookmark Paket'
                                    : _currentIndex == 4
                                        ? 'Riwayat Pencarian'
                                        : 'Nama Halaman',
                        style: AppFonts.poppinsBold(fontSize: 16)),
                  ],
                ),
              ),
              actions: [
                CustomIconButton(
                    icons: AppIcons.IcNotificationBlue, handler: () {}),
                SizedBox(width: 20)
              ],
            ),
      body: Stack(
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
                        handler: () {
                          setState(() {
                            _currentIndex = 0;
                          });
                        }),
                    CustomNavButton(
                        icons: _currentIndex == 1
                            ? AppIcons.IcNavOngkirBlue
                            : AppIcons.IcNavOngkirBlack,
                        handler: () {
                          setState(() {
                            _currentIndex = 1;
                          });
                        }),
                    Container(width: 75),
                    CustomNavButton(
                        icons: _currentIndex == 3
                            ? AppIcons.IcNavBookmarkBlue
                            : AppIcons.IcNavBookmarkBlack,
                        handler: () {
                          setState(() {
                            _currentIndex = 3;
                          });
                        }),
                    CustomNavButton(
                        icons: _currentIndex == 4
                            ? AppIcons.IcNavHistoryBlue
                            : AppIcons.IcNavHistoryBlack,
                        handler: () {
                          setState(() {
                            _currentIndex = 4;
                          });
                        }),
                  ],
                ),
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: CustomNavButton(
                    icons: AppIcons.IcNavTrackBtn,
                    height: 90,
                    handler: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    }),
              ))
        ],
      ),
    );
  }
}

class KontenHomepage extends StatefulWidget {
  final Function(int, String) onSectionSelected;

  const KontenHomepage({required this.onSectionSelected});

  @override
  State<KontenHomepage> createState() => _KontenHomepageState();
}

class _KontenHomepageState extends State<KontenHomepage> {
  void _navigateToLacakPaket(String resi) {
    widget.onSectionSelected(2, resi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.BgPutih,
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              children: [
                LacakPaketWidget(
                   onTrackPackage: _navigateToLacakPaket,
                   ),
                AppSpacer.VerticalSpacerLarge,
                FeatureApp(
                  handler1: () { 
                    widget.onSectionSelected(2,'');
                   }, 
                  handler2: () { 
                    widget.onSectionSelected(1,'');
                   }, 
                  handler3: () { 
                    widget.onSectionSelected(3,'');
                   }, 
                  handler4: () { 
                    widget.onSectionSelected(4,'');
                   },),
                TitleDetail(
                    textTitle: 'Pencarian Terakhir',
                    textDetail: 'Lihat Semua',
                    handler: () {
                      widget.onSectionSelected(4,'');
                    }),
                CardButtonErrorWidget(
                  TextTitle: 'Riwayat Tidak Ditemukan', 
                  TextDesc: 'Silahkan Lakukan Pencarian Dahulu untuk Menambahkan Riwayat Anda.', 
                  Icons: AppIcons.IcTrackWhite, 
                  HintText: 'Lacak Paket Saya'),
                DataRiwayatTerakhir(),
                TitleDetail(
                    textTitle: 'Bookmark Anda',
                    textDetail: 'Lihat Semua',
                    handler: () {
                      widget.onSectionSelected(3,'');
                    }),
                CardButtonErrorWidget(
                  TextTitle: 'Tidak Ada Data Tersimpan', 
                  TextDesc: 'Silahkan Lakukan Pencarian dan Simpan Data Paket Anda.', 
                  Icons: AppIcons.IcTrackWhite, 
                  HintText: 'Lacak Paket Saya'),
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

class LacakPaketWidget extends StatelessWidget {
  final Function(String) onTrackPackage;
  final TextEditingController _resiController = TextEditingController();

   LacakPaketWidget({
    required this.onTrackPackage,
    super.key
    });

  @override
  Widget build(BuildContext context) {
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
                        CustomTextfieldsIcon(
                          controller: _resiController,
                          icons: AppIcons.IcPackageSearchGrey, 
                          hintText: 'Masukkan No. Resi',),
                        AppSpacer.HorizontalSpacerSmall,
                        CustomIconButton(
                          icons: AppIcons.IcTrackWhite,
                          bgColor: AppColors.BiruPrimary,
                          handler: () {
                              onTrackPackage(_resiController.text);
                            },
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
}

class FeatureApp extends StatelessWidget {
  final VoidCallback handler1;
  final VoidCallback handler2;
  final VoidCallback handler3;
  final VoidCallback handler4;

  const FeatureApp({
    required this.handler1,
    required this.handler2,
    required this.handler3,
    required this.handler4,
    super.key
    });

  @override
  Widget build(BuildContext context) {
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
                  handler: handler1),
              Spacer(),
              CustomIconTextButton(
                  icons: AppIcons.IcOngkirBlue,
                  text: 'Cek\nOngkir',
                  handler: handler2),
              Spacer(),
              CustomIconTextButton(
                  icons: AppIcons.IcBookmarkBlue,
                  text: 'Bookmark\nSaya',
                  handler: handler3),
              Spacer(),
              CustomIconTextButton(
                  icons: AppIcons.IcHistoryBlue,
                  text: 'Riwayat\nPencarian',
                  handler: handler4),
            ]),
          ),
        )),
  );
  }
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
