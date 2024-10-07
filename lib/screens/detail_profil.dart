import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paket_tracker_app/databases/db_helper.dart';
import 'package:paket_tracker_app/screens/initial_name.dart';
import 'package:paket_tracker_app/screens/notifikasi.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/icon_button.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/outline_button.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/primary_button.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';
import 'package:paket_tracker_app/screens/widgets/inputs/textfields_icon.dart';
import 'package:paket_tracker_app/screens/widgets/spacer.dart';
import 'package:quickalert/quickalert.dart';

class DetailProfil extends StatefulWidget {
  const DetailProfil({super.key});

  @override
  State<DetailProfil> createState() => _DetailProfilState();
}

class _DetailProfilState extends State<DetailProfil> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  File? _selectedImage; // Variable untuk menyimpan foto yang dipilih
  int? _userId;

  // Fungsi untuk memilih foto dari galeri
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _loadUserData() async {
  final userData = await DBHelper().getUserData();
  
  setState(() {
    _nameController.text = userData['name'] ?? '';
    _addressController.text = userData['address'] ?? '';
    _selectedImage = File(userData['imagePath'] ?? 'assets/images/placeholder_avatar2.png');
    
    // Get user ID from the userData map if exists
    _userId = userData['id']; // Assuming you have an 'id' field in your user data
  });
}

// Fungsi untuk menyimpan data ke SQLite
Future<void> _saveData() async {
  String name = _nameController.text.trim();
  String address = _addressController.text.trim();
  String imagePath = _selectedImage?.path ?? 'assets/images/placeholder_avatar2.png';

  print('Saving data: Name: $name, Address: $address, ImagePath: $imagePath');

  if (name.isNotEmpty && address.isNotEmpty) {
    try {
      await DBHelper().insertUserData(name, address, imagePath, id: _userId);
      print('Data updated successfully');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data updated successfully!')),
      );

      Navigator.pop(context, {'name': name, 'address': address, 'imagePath': imagePath});
    } catch (e) {
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update data: $e')),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please fill in all fields')),
    );
  }
}


Future<void> _deleteAllData() async {
  await DBHelper().deleteAllUserData();
  setState(() {
    _nameController.text = '';
    _addressController.text = '';
    _selectedImage = null;
  });
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => InitialName(),
      ),
    );
}

@override
void initState() {
  super.initState();
  _loadUserData();
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
              Text('Detail Profil', style: AppFonts.poppinsBold(fontSize: 16)),
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
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 48),
                Stack(
                  children: [
                    Container(
                      height: 125,
                      width: 125,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: _selectedImage != null
                            ? Image.file(_selectedImage!, fit: BoxFit.cover)
                            : Image.asset(
                                'assets/images/placeholder_avatar2.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Container(
                      height: 125,
                      width: 125,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.BiruPrimary, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
                AppSpacer.VerticalSpacerLarge,
                CustomOutlineButton(
                    bgColor: AppColors.BiruPrimary,
                    OutlineColor: AppColors.Putih,
                    width: 200,
                    Icons: AppIcons.IcEditWhite,
                    HintText: 'Ganti Foto Profil',
                    handler: _pickImage),
                AppSpacer.VerticalSpacerLarge,
                Text('Siapa Namamu?',
                    style: AppFonts.poppinsMedium(
                        color: AppColors.Hitam, fontSize: 14)),
                AppSpacer.VerticalSpacerSmall,
                CustomTextfieldsIcon(
                    icons: AppIcons.IcProfilGrey,
                    hintText: 'Masukkan Nama Anda',
                    controller: _nameController),
                AppSpacer.VerticalSpacerSmall,
                Text('Darimana Asalmu?',
                    style: AppFonts.poppinsMedium(
                        color: AppColors.Hitam, fontSize: 14)),
                AppSpacer.VerticalSpacerSmall,
                CustomTextfieldsIcon(
                    icons: AppIcons.IcMapsGrey,
                    hintText: 'Masukkan Alamat Anda',
                    controller: _addressController),
                AppSpacer.VerticalSpacerExtraLarge,
                PrimaryButton(
                    Icons: AppIcons.IcEditWhite,
                    HintText: 'Update Data',
                    hintColor: AppColors.Putih,
                    handler: _saveData),
                AppSpacer.VerticalSpacerExtraLarge,
                CustomOutlineButton(
                    bgColor: AppColors.BgPutih,
                    Icons: AppIcons.IcDeleteRed,
                    HintText: 'Hapus Data Dan Logout',
                    handler: (){
                      QuickAlert.show(
                    context: context,
                    type: QuickAlertType.confirm,
                    title: 'Hapus Data Akun Dan Logout',
                    text: 'Apakah kamu Yakin Ingin Menghapus Data Dan Logout',
                    confirmBtnText: 'Logout',
                    cancelBtnText: 'Kembali',
                    confirmBtnColor: AppColors.Merah,
                    onConfirmBtnTap: () {
                      _deleteAllData();
                    },
                    onCancelBtnTap: () {
                      Navigator.pop(context);
                    },
                  );
                    }, 
                    OutlineColor: AppColors.Merah,)
              ],
            ),
          ),
      ),
    );
  }
}
