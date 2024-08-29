import 'dart:convert'; // Import untuk konversi JSON
import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IconToggleSaveButton extends StatefulWidget {
  final VoidCallback? handler;
  final Map<String, dynamic> dataToSave; // Tambahkan data yang ingin disimpan

  const IconToggleSaveButton({Key? key, this.handler, required this.dataToSave})
      : super(key: key);

  @override
  _IconToggleSaveButtonState createState() => _IconToggleSaveButtonState();
}

class _IconToggleSaveButtonState extends State<IconToggleSaveButton> {
  bool isClicked = false;
  String? savedName; // Simpan nama data yang disimpan

  void _toggleIcon() async {
    setState(() {
      isClicked = !isClicked;
    });

    if (isClicked) {
      // Jika ikon di-klik, tampilkan dialog untuk menyimpan data
      _showSaveDialog();
    } else if (savedName != null) {
      // Jika ikon diklik lagi dan data sudah tersimpan, hapus data
      await _removeData(savedName!);
    }

    if (widget.handler != null) {
      widget.handler!();
    }
  }

  void _showSaveDialog() {
    TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Simpan Data'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: "Masukkan Nama Simpanan"),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                String saveName = nameController.text.trim();
                if (saveName.isNotEmpty) {
                  await _saveData(saveName, widget.dataToSave); // Simpan data
                  setState(() {
                    savedName = saveName; // Simpan nama data yang disimpan
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveData(String name, Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Tambahkan nama yang dimasukkan ke dalam data yang akan disimpan
    data['name'] = name;

    // Konversi data ke format JSON String
    String jsonData = jsonEncode(data);

    // Simpan JSON String ke SharedPreferences
    await prefs.setString(name, jsonData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data berhasil disimpan dengan nama $name')),
    );
  }

  Future<void> _removeData(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Hapus data dari SharedPreferences
    if (prefs.containsKey(name)) {
      await prefs.remove(name);
      setState(() {
        savedName = null; // Reset nama data yang disimpan
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data dengan nama $name berhasil dihapus')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleIcon,
      child: Image.asset(
        isClicked ? AppIcons.IcSaveBlue : AppIcons.IcSaveOutlineBlue,
        height: 20,
      ),
    );
  }
}
