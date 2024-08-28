import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';

class IconToggleButton extends StatefulWidget {
  final VoidCallback? handler; // Handler tambahan yang dipanggil saat ikon di-tap

  const IconToggleButton({Key? key, this.handler}) : super(key: key);

  @override
  _IconToggleButtonState createState() => _IconToggleButtonState();
}

class _IconToggleButtonState extends State<IconToggleButton> {
  bool isClicked = false; // State untuk melacak status ikon

  void _toggleIcon() {
    setState(() {
      isClicked = !isClicked; // Toggle status ikon
    });

    // Memanggil handler tambahan jika ada
    if (widget.handler != null) {
      widget.handler!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleIcon, // Panggil _toggleIcon saat di-tap
      child: Image.asset(
        isClicked ? AppIcons.IcSaveBlue : AppIcons.IcSaveOutlineBlue, // Ganti ikon berdasarkan status
        height: 20,
      ),
    );
  }
}
