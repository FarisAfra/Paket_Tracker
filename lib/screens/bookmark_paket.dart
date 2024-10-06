import 'dart:convert'; // Import untuk konversi JSON
import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/detail_bookmark.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/errors/comming_soon.dart';
import 'package:paket_tracker_app/screens/widgets/errors/error_nodata_screen.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';
import 'package:paket_tracker_app/screens/widgets/images/logo_kurir.dart';
import 'package:paket_tracker_app/screens/widgets/spacer.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkPaket extends StatefulWidget {
  const BookmarkPaket({super.key});

  @override
  State<BookmarkPaket> createState() => _BookmarkPaketState();
}

class _BookmarkPaketState extends State<BookmarkPaket> {
  List<Map<String, dynamic>> savedDataList = []; // List untuk menyimpan data

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
      savedDataList = loadedData.reversed.toList(); // Perbarui state dengan data yang diambil
    });
  }

  void _showOptionsDialog(int index) {
    showModalBottomSheet(
      backgroundColor: AppColors.Putih,
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          alignment: WrapAlignment.center,
          children: [
            Container(height: 16,),
            Text('Pilih Aksi Yang Ingin Dilakukan', style: AppFonts.poppinsSemiBold(fontSize: 16),),
            Divider(color: AppColors.BgPutih),
            ListTile(
              leading: Image.asset(AppIcons.IcEditBlue, height: 24,),
              title: Text('Edit Data', style: AppFonts.poppinsRegular(fontSize: 14),),
              onTap: () {
                Navigator.of(context).pop();
                _showEditDialog(index);
              },
            ),
            ListTile(
              leading: Image.asset(AppIcons.IcDeleteRed, height: 24,),
              title: Text('Hapus Data', style: AppFonts.poppinsRegular(fontSize: 14)),
              onTap: () {
                Navigator.of(context).pop();
                _deleteData(index);
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(int index) {
    TextEditingController nameController =
        TextEditingController(text: savedDataList[index]['name']);

    QuickAlert.show(
    context: context,
    type: QuickAlertType.custom,
    barrierDismissible: true,
    title: 'Edit Nama',
    text: 'Masukkan Nama Baru',
    widget: TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        hintText: 'Masukkan Nama Baru',
        prefixIcon: Icon(Icons.save),
      ),
      textInputAction: TextInputAction.done,
    ),
    confirmBtnText: 'Simpan',
    cancelBtnText: 'Batal',
    showCancelBtn: true,
    onConfirmBtnTap: () async {
      String newName = nameController.text.trim();
      if (newName.isNotEmpty) {
        _updateDataName(index, newName); // Memperbarui nama data
        Navigator.pop(context);
        await Future.delayed(const Duration(milliseconds: 500)); // Tunggu sebentar sebelum menampilkan notifikasi sukses
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: "Nama berhasil diperbarui!",
        );
      } else {
        // Tampilkan pesan error jika nama kosong
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Nama tidak boleh kosong',
        );
      }
    },
  );
  }

  Future<void> _updateDataName(int index, String newName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? key = prefs
        .getKeys()
        .elementAt(index); // Mendapatkan kunci berdasarkan urutan

    if (key != null) {
      savedDataList[index]['name'] = newName; // Memperbarui nama di list
      String jsonData =
          jsonEncode(savedDataList[index]); // Encode kembali ke JSON
      await prefs.setString(
          key, jsonData); // Simpan perubahan ke SharedPreferences
      setState(() {}); // Perbarui tampilan
    }
  }

  Future<void> _deleteData(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? key = prefs
        .getKeys()
        .elementAt(index); // Mendapatkan kunci berdasarkan urutan

    if (key != null) {
      await prefs.remove(key); // Hapus data dari SharedPreferences
      setState(() {
        savedDataList.removeAt(index); // Hapus data dari list
      });

      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Data Dihapus',
        text: 'Data telah berhasil dihapus',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.BgPutih,
        body: savedDataList.isEmpty
            ? Center(
                child: ErrorNodataScreen(
                    title: 'Anda Belum Memiliki Bookmark',
                    desc:
                        'Silahkan Lakukan Pencarian Dahulu dan\nSimpan Data Paket Anda',
                    IconButton: AppIcons.IcTrackWhite,
                    TextButton: 'Lacak Paket Saya',
                    handler:
                        () {
                          
                        }),
              )
            : Column(
                children: [
                  AppSpacer.VerticalSpacerMedium,
                  Text(
                    'Kelola Data Paket Yang Anda Simpan',
                    style: AppFonts.poppinsRegular(),
                  ),
                  AppSpacer.VerticalSpacerSmall,
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _loadSavedData,
                      child: ListView.builder(
                      itemCount: savedDataList.length,
                      itemBuilder: (context, index) {
                        final data = savedDataList[index];
                        return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailBookmarkPage(data: data, index: index,),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          getCourierLogo(data['courier']),
                                          AppSpacer.HorizontalSpacerLarge,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  data['name'] ??
                                                      'Unknown Name',
                                                  style:
                                                      AppFonts.poppinsBold()),
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
                                            onTap: () {
                                              _showOptionsDialog(index);
                                            },
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
                    )
                  )
                ],
              ));
  }
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