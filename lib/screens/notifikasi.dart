import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/icon_button.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/errors/error_nodata_screen.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';
import 'package:paket_tracker_app/screens/widgets/images/logo_kurir.dart';
import 'package:paket_tracker_app/screens/widgets/spacer.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notifikasi extends StatefulWidget {
  const Notifikasi({super.key});

  @override
  State<Notifikasi> createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
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
      savedDataList = loadedData; // Perbarui state dengan data yang diambil
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BgPutih,
      appBar: AppBar(
        backgroundColor: AppColors.Putih,
        leading: Row(
          children: [
            SizedBox(width: 20),
            CustomIconButton(
                icons: AppIcons.IcBackBlue,
                bgColor: AppColors.Putih,
                handler: () {
                  Navigator.pop(context);
                })
          ],
        ),
        title: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Paket Tracker', style: AppFonts.poppinsLight()),
              Text('Notifikasi', style: AppFonts.poppinsBold(fontSize: 16)),
            ],
          ),
        ),
        actions: [
          CustomIconButton(icons: AppIcons.IcShareBlue, handler: () {}),
          SizedBox(width: 20)
        ],
      ),
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
                                
                              },
                              child: Card(
                                color: Colors.white,
                                child: Center(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomIconButton(
                                            icons: AppIcons.IcPackageBlue, 
                                            handler: () {}),
                                          AppSpacer.HorizontalSpacerLarge,
                                          Flexible(
                                            child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                  'Anda Berhasil Menyimpan No. Resi: ${data['awb'] ?? 'Unknown Awb'} Dengan Nama: ${data['name'] ?? 'Unknown Name'}',
                                                  style:
                                                      AppFonts.poppinsSemiBold()),
                                              Text(
                                                'Kurir: ${data['courier'] ?? 'Unknown Courier'}',
                                                style: AppFonts.poppinsMedium(
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),),
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
              )
    );
  }
}