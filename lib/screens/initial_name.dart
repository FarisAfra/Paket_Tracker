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
  String? _selectedImagePath; // Store the image path as String
  final ImagePicker _picker = ImagePicker(); // Instance ImagePicker
  int? _userId;

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path; // Save the path
      });

      // Check if the file exists
      final file = File(_selectedImagePath!); // Create a File from the path
      if (await file.exists()) {
        print("File exists: ${file.path}");
      } else {
        print("File does not exist: ${file.path}");
      }
    } else {
      print('No image selected.');
    }
  
}

// Fungsi untuk menyimpan data ke SQLite
Future<void> _saveData() async {
  String name = _nameController.text.trim();
  String address = _addressController.text.trim();
  String imagePath = _selectedImagePath ?? 'assets/images/placeholder_avatar2.png';

  print('Saving data: Name: $name, Address: $address, ImagePath: $imagePath');

  if (_selectedImagePath == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Silakan tambahkan foto profil terlebih dahulu')),
    );
    return;
  }

  if (name.isEmpty || address.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Silakan isi nama dan alamat Anda')),
    );
    return;
  }

  try {
    await DBHelper().insertUserData(name, address, imagePath, id: _userId);
    print('Data updated successfully');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data Berhasil Disimpan')),
    );
  } catch (e) {
    print('Error saving data: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gagal Menyimpan Data: $e')),
    );
  }

  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Homepage(),
      ),
    );
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
                        child: _selectedImagePath  != null
                            ? Image.file(File(_selectedImagePath !), fit: BoxFit.cover)
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
