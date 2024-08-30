import 'dart:convert'; // Import untuk konversi JSON
import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';
import 'package:quickalert/quickalert.dart';
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

  QuickAlert.show(
    context: context,
    type: QuickAlertType.custom,
    barrierDismissible: true,
    title: 'Simpan Data',
    text: 'Masukkan Nama Simpanan',
    widget: TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        hintText: 'Masukkan Nama Simpanan',
        prefixIcon: Icon(Icons.save),
      ),
      textInputAction: TextInputAction.done,
    ),
    confirmBtnText: 'Simpan',
    cancelBtnText: 'Batal',
    showCancelBtn: true,
    onConfirmBtnTap: () async {
      String saveName = nameController.text.trim();
      if (saveName.isNotEmpty) {
        await _saveData(saveName, widget.dataToSave); // Simpan data
        setState(() {
          savedName = saveName; // Simpan nama data yang disimpan
        });
        Navigator.pop(context); // Menutup dialog setelah menyimpan
        await Future.delayed(const Duration(milliseconds: 500)); // Jeda sebelum menampilkan notifikasi sukses
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: "Data berhasil disimpan!",
        );
      } else {
        // Tampilkan pesan error jika input kosong
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Nama simpanan tidak boleh kosong',
        );
      }
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

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Data berhasil disimpan dengan nama $name')),
    // );
  }

  Future<void> _removeData(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Hapus data dari SharedPreferences
    if (prefs.containsKey(name)) {
      await prefs.remove(name);
      setState(() {
        savedName = null; // Reset nama data yang disimpan
      });

      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Data Telah Dihapus',
        text: 'Data dengan nama $name berhasil dihapus',
      );

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Data dengan nama $name berhasil dihapus')),
      // );
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
