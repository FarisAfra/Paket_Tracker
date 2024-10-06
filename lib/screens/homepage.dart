import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:paket_tracker_app/databases/db_helper.dart';
import 'package:paket_tracker_app/screens/bookmark_paket.dart';
import 'package:paket_tracker_app/screens/cek_ongkir.dart';
import 'package:paket_tracker_app/screens/detail_bookmark.dart';
import 'package:paket_tracker_app/screens/lacak_paket.dart';
import 'package:paket_tracker_app/screens/notifikasi.dart';
import 'package:paket_tracker_app/screens/riwayat_pencarian.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/icon_button.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/icon_text_button.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/nav_button.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/errors/card_button_error_widget.dart';
import 'package:paket_tracker_app/screens/widgets/errors/error_nodata_screen.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';
import 'package:paket_tracker_app/screens/widgets/images/logo_kurir.dart';
import 'package:paket_tracker_app/screens/widgets/inputs/textfields_icon.dart';
import 'package:paket_tracker_app/screens/widgets/spacer.dart';
import 'package:paket_tracker_app/screens/widgets/texts/title_detail.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  String _currentResi = '';
  Future<Map<String, String>>? _userData;

  Widget _getCurrentWidget() {
    switch (_currentIndex) {
      case 0:
        return KontenHomepage(onSectionSelected: _onSectionSelected);
      case 1:
        return CekOngkir();
      case 2:
        return LacakPaket(
          resi: _currentResi,
        );
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
  void initState() {
    super.initState();
    _userData = getUserData(); // Panggil fungsi untuk mengambil data pengguna
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BgPutih,
      appBar: _currentIndex == 0
          ? AppBar(
              backgroundColor: AppColors.Putih,
              leading: FutureBuilder<Map<String, String>>(
                future: _userData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          CircularProgressIndicator(), // Tampilkan loading indicator sementara
                    );
                  } else if (snapshot.hasError) {
                    return Icon(
                        Icons.error); // Tampilkan error icon jika ada kesalahan
                  } else {
                    String imagePath = snapshot.data?['imagePath'] ??
                        'assets/images/placeholder_avatar.png';

                    return GestureDetector(
                        onTap: () {
                          // Aksi ketika gambar diklik
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(imagePath, height: 36),
                          ),
                        ));
                  }
                },
              ),
              title: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Halo, Selamat Datang',
                        style: AppFonts.poppinsLight()),
                    FutureBuilder<Map<String, String>>(
                      future: _userData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text('Loading...',
                              style: AppFonts.poppinsExtraBold(fontSize: 16));
                        } else if (snapshot.hasError) {
                          return Text('Error',
                              style: AppFonts.poppinsExtraBold(fontSize: 16));
                        } else {
                          return Text(
                            snapshot.data?['name'] ?? 'Nama Tidak Ditemukan',
                            style: AppFonts.poppinsExtraBold(fontSize: 16),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                CustomIconButton(
                  icons: AppIcons.IcNotificationBlue,
                  handler: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Notifikasi(),
                      ),
                    );
                  },
                ),
                SizedBox(width: 20),
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
                    icons: AppIcons.IcNotificationBlue,
                    handler: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Notifikasi(),
                        ),
                      );
                    }),
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
                    widget.onSectionSelected(2, '');
                  },
                  handler2: () {
                    widget.onSectionSelected(1, '');
                  },
                  handler3: () {
                    widget.onSectionSelected(3, '');
                  },
                  handler4: () {
                    widget.onSectionSelected(4, '');
                  },
                ),
                TitleDetail(
                    textTitle: 'Pencarian Terakhir',
                    textDetail: 'Lihat Semua',
                    handler: () {
                      widget.onSectionSelected(4, '');
                    }),
                Container(
                  height: 180,
                  child: Expanded(child: HistoryHomepage()),
                ),
                TitleDetail(
                    textTitle: 'Bookmark Anda',
                    textDetail: 'Lihat Semua',
                    handler: () {
                      widget.onSectionSelected(3, '');
                    }),
                Container(
                  height: 240,
                  child: Expanded(child: BookmarkHomepage()),
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

  LacakPaketWidget({required this.onTrackPackage, super.key});

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
                            hintText: 'Masukkan No. Resi',
                          ),
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

class HistoryHomepage extends StatefulWidget {
  const HistoryHomepage({super.key});

  @override
  State<HistoryHomepage> createState() => _HistoryHomepageState();
}

class _HistoryHomepageState extends State<HistoryHomepage> {
  List<Map<String, dynamic>> _trackingRecords = [];

  @override
  void initState() {
    super.initState();
    _loadTrackingRecords();
  }

  Future<void> _loadTrackingRecords() async {
    final dbHelper = DBHelper();
    final records = await dbHelper.getTrackingRecords();

    print(records); // Check the content and structure

    // Ensure that records are modifiable
    setState(() {
      _trackingRecords = List.from(records); // Copy to ensure modifiability
    });
  }

  Future<void> _loadSavedData() async {
    await _loadTrackingRecords(); // Reload the data
  }

  Future<void> _deleteRecord(int index) async {
    final dbHelper = DBHelper();
    final record = _trackingRecords[index];

    await dbHelper
        .deleteTrackingRecord(record['id']); // Call your delete method
    _loadTrackingRecords(); // Reload records after deletion
  }

  void _showOptionsDialog(int index) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: 'Warning!',
      text: 'Apakah Anda yakin ingin menghapus riwayat ini?',
      confirmBtnText: 'Hapus',
      cancelBtnText: 'Batal',
      confirmBtnColor: Colors.red,
      onConfirmBtnTap: () async {
        Navigator.of(context).pop(); // Close the alert
        await _deleteRecord(index); // Delete the record
      },
      onCancelBtnTap: () {
        Navigator.of(context).pop(); // Close the alert
      },
    );
  }

  String _formatTimestamp(String? timestamp) {
    if (timestamp == null) return 'Unknown Time';

    // Parsing string timestamp to DateTime object
    DateTime parsedDate = DateTime.parse(timestamp);

    // Formatting DateTime to desired format
    String formattedDate =
        DateFormat('dd MMM yyyy, HH:mm:ss').format(parsedDate);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BgPutih,
      body: _trackingRecords.isEmpty
          ? Column(
              children: [
                CardButtonErrorWidget(
                    TextTitle: 'Tidak Ada Data Riwayat',
                    TextDesc:
                        'Silakan lakukan pencarian atau pelacakan paket Anda.',
                    Icons: AppIcons.IcTrackWhite,
                    HintText: 'Lacak Paket Saya')
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _loadSavedData,
                    child: ListView.builder(
                      shrinkWrap:
                          true, // Tambahkan ini untuk memastikan ukuran mengikuti isi
                      physics:
                          NeverScrollableScrollPhysics(), // Agar tidak ada scroll dalam ListView
                      itemCount: min(_trackingRecords.length, 2),
                      itemBuilder: (context, index) {
                        final record = _trackingRecords[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Card(
                              color: Colors.white,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 24),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          getCourierLogo(record['courier']),
                                          AppSpacer.HorizontalSpacerLarge,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    record['resi'] ??
                                                        'Unknown Resi',
                                                    style:
                                                        AppFonts.poppinsBold(),
                                                  ),
                                                  AppSpacer
                                                      .HorizontalSpacerExtraSmall,
                                                  GestureDetector(
                                                    child: Icon(Icons.copy,
                                                        size: 12),
                                                    onTap: () {
                                                      Clipboard.setData(
                                                        ClipboardData(
                                                          text:
                                                              record['resi'] ??
                                                                  '',
                                                        ),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              'Resi disalin ke clipboard'),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                ],
                                              ),
                                              getCourierName(record['courier']),
                                              Text(
                                                'Pada: ${_formatTimestamp(record["timestamp"])}',
                                                style: AppFonts.poppinsLight(
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              _showOptionsDialog(index);
                                            },
                                            child: Image.asset(
                                              AppIcons.IcDeleteRed,
                                              height: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class BookmarkHomepage extends StatefulWidget {
  const BookmarkHomepage({super.key});

  @override
  State<BookmarkHomepage> createState() => _BookmarkHomepageState();
}

class _BookmarkHomepageState extends State<BookmarkHomepage> {
  List<Map<String, dynamic>> savedDataList = [];

  @override
  void initState() {
    super.initState();
    _loadSavedData(); // Muat data saat widget diinisialisasi
  }

  Future<void> _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys =
        prefs.getKeys(); // Dapatkan semua kunci data yang tersimpan

    List<Map<String, dynamic>> loadedData = [];

    for (String key in keys) {
      String? jsonString = prefs.getString(key);
      if (jsonString != null) {
        // Decode JSON String ke Map
        Map<String, dynamic> data = jsonDecode(jsonString);
        loadedData.add(data);
      }
    }

    setState(() {
      savedDataList = loadedData.reversed
          .toList(); // Perbarui state dengan data yang diambil
    });
  }

  @override
  Widget build(BuildContext context) {
    return savedDataList.isEmpty
        ? Column(
            children: [
              CardButtonErrorWidget(
                  TextTitle: 'Tidak Ada Data Tersimpan',
                  TextDesc:
                      'Silahkan Lakukan Pencarian dan Simpan Data Paket Anda.',
                  Icons: AppIcons.IcTrackWhite,
                  HintText: 'Lacak Paket Saya')
            ],
          )
        : Column(
            children: [
              Expanded(
                  child: RefreshIndicator(
                onRefresh: _loadSavedData,
                child: ListView.builder(
                  shrinkWrap:
                      true, // Tambahkan ini untuk memastikan ukuran mengikuti isi
                  physics:
                      NeverScrollableScrollPhysics(), // Agar tidak ada scroll dalam ListView
                  itemCount: min(savedDataList.length, 3),
                  itemBuilder: (context, index) {
                    final data = savedDataList[index];
                    return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailBookmarkPage(
                                  data: data,
                                  index: index,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.white,
                            child: Center(
                                child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      getCourierLogo(data['courier']),
                                      AppSpacer.HorizontalSpacerLarge,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data['name'] ?? 'Unknown Name',
                                              style: AppFonts.poppinsBold()),
                                          Text(
                                            '${data['courier2'] ?? 'Unknown Courier'}',
                                            style: AppFonts.poppinsMedium(
                                                fontSize: 10),
                                          ),
                                          Text(
                                            'No. Resi: ${data["awb"] ?? 'Unknown Resi'}',
                                            style: AppFonts.poppinsLight(
                                                fontSize: 10),
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        // onTap: () {
                                        //   _showOptionsDialog(index);
                                        // },
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
                          ),
                        ));
                  },
                ),
              ))
            ],
          );
  }
}

class FeatureApp extends StatelessWidget {
  final VoidCallback handler1;
  final VoidCallback handler2;
  final VoidCallback handler3;
  final VoidCallback handler4;

  const FeatureApp(
      {required this.handler1,
      required this.handler2,
      required this.handler3,
      required this.handler4,
      super.key});

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
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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

Widget getCourierLogo(String? courier) {
  switch (courier?.toLowerCase()) {
    case 'anteraja':
      return LogoAnteraja();
    case 'dakota':
      return LogoDakota();
    case 'id':
      return LogoID();
    case 'indah':
      return LogoIndah();
    case 'jet':
      return LogoJET();
    case 'jne':
      return LogoJNE();
    case 'jnt':
      return LogoJNT();
    case 'jnt cargo':
      return LogoJNTCargo();
    case 'kgx':
      return LogoKGX();
    case 'lazada':
      return LogoLazada();
    case 'lion parcel':
      return LogoLionParcel();
    case 'ninja':
      return LogoNinja();
    case 'pcp':
      return LogoPCP();
    case 'pos indonesia':
      return LogoPOS();
    case 'rex':
      return LogoREX();
    case 'rpx':
      return LogoRPX();
    case 'sap':
      return LogoSAP();
    case 'sicepat':
      return LogoSicepat();
    case 'spx':
      return LogoSPX();
    case 'tiki':
      return LogoTiki();
    case 'tokopedia':
      return LogoTokopedia();
    case 'wahana':
      return LogoWahana();
    default:
      return LogoPlaceholder(); // Logo default jika kurir tidak ditemukan
  }
}
