import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/errors/comming_soon.dart';

class BookmarkPaket extends StatefulWidget {
  const BookmarkPaket({super.key});

  @override
  State<BookmarkPaket> createState() => _BookmarkPaketState();
}

class _BookmarkPaketState extends State<BookmarkPaket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BgPutih,
      body: CommingSoonState()
    );
  }
}