import 'dart:convert'; // Import untuk konversi JSON
import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/errors/comming_soon.dart';
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
    Set<String> keys = prefs.getKeys(); // Dapatkan semua kunci data yang tersimpan

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
      body: savedDataList.isEmpty
          ? Center(
              child: CommingSoonState(), // Jika tidak ada data, tampilkan widget CommingSoonState
            )
          : ListView.builder(
              itemCount: savedDataList.length,
              itemBuilder: (context, index) {
                final data = savedDataList[index];
                return ListTile(
                  title: Text(data['awb'] ?? 'Unknown AWB'),
                  subtitle: Text('${data['courier'] ?? 'Unknown Courier'} - ${data['status'] ?? 'Unknown Status'}'),
                  onTap: () {
                    // Tambahkan tindakan saat item diklik, jika diperlukan
                  },
                );
              },
            ),
    );
  }
}
