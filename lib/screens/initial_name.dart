import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paket_tracker_app/databases/db_helper.dart';
import 'package:paket_tracker_app/screens/homepage.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/outline_button.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/primary_button.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';
import 'package:paket_tracker_app/screens/widgets/inputs/textfields_icon.dart';
import 'package:paket_tracker_app/screens/widgets/spacer.dart';

class InitialName extends StatefulWidget {
  const InitialName({super.key});

  @override
  State<InitialName> createState() => _InitialNameState();
}

class _InitialNameState extends State<InitialName> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  File? _selectedImage; // Variable untuk menyimpan foto yang dipilih
  final ImagePicker _picker = ImagePicker(); // Instance ImagePicker

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

// Fungsi untuk menyimpan data ke SQLite
Future<void> _saveData() async {
  String name = _nameController.text;
  String address = _addressController.text;
  String imagePath = _selectedImage?.path ?? 'assets/images/placeholder_avatar2.png';

  if (name.isNotEmpty && address.isNotEmpty) {
    // Simpan data ke database SQLite
    await DBHelper().insertUserData(name, address, imagePath); // Perbaiki di sini

    // Setelah data disimpan, pindah ke halaman utama
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Homepage()),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.BiruPrimary,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Halo!',
                    style: AppFonts.poppinsLight(
                        color: AppColors.Putih, fontSize: 14)),
                Text('Selamat Datang',
                    style: AppFonts.poppinsExtraBold(
                        color: AppColors.Putih, fontSize: 32)),
                Text('Di Paket Tracker App',
                    style: AppFonts.poppinsLight(
                        color: AppColors.Putih, fontSize: 14)),
                AppSpacer.VerticalSpacerExtraLarge,
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
                        border: Border.all(color: AppColors.Putih, width: 2),
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
                        color: AppColors.Putih, fontSize: 14)),
                AppSpacer.VerticalSpacerSmall,
                CustomTextfieldsIcon(
                    icons: AppIcons.IcProfilGrey,
                    hintText: 'Masukkan Nama Anda',
                    controller: _nameController),
                AppSpacer.VerticalSpacerSmall,
                Text('Darimana Asalmu?',
                    style: AppFonts.poppinsMedium(
                        color: AppColors.Putih, fontSize: 14)),
                AppSpacer.VerticalSpacerSmall,
                CustomTextfieldsIcon(
                    icons: AppIcons.IcMapsGrey,
                    hintText: 'Masukkan Alamat Anda',
                    controller: _addressController),
                AppSpacer.VerticalSpacerExtraLarge,
                PrimaryButton(
                    bgColor: AppColors.Putih,
                    Icons: AppIcons.IcSaveNameBlue,
                    HintText: 'Simpan Data',
                    hintColor: AppColors.BiruPrimary,
                    handler: _saveData) // Panggil _saveData saat tombol diklik
              ],
            ),
          ),
        ),
      ),
    );
  }
}
