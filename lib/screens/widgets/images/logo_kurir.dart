import 'package:flutter/material.dart';

class LogoKurir {
  static const String Anteraja = 'assets/images/kurir/Anteraja.png';
  static const String Dakota = 'assets/images/kurir/Dakota.png';
  static const String ID = 'assets/images/kurir/ID.png';
  static const String Indah = 'assets/images/kurir/Indah.png';
  static const String JET = 'assets/images/kurir/JET.png';
  static const String JNE = 'assets/images/kurir/JNE.png';
  static const String JNT = 'assets/images/kurir/JNT.png';
  static const String JNTCargo = 'assets/images/kurir/JNTCargo.png';
  static const String KGX = 'assets/images/kurir/KGX.png';
  static const String Lazada = 'assets/images/kurir/Lazada.png';
  static const String LionParcel = 'assets/images/kurir/LionParcel.png';
  static const String Ninja = 'assets/images/kurir/Ninja.png';
  static const String PCP = 'assets/images/kurir/PCP.png';
  static const String Placeholder = 'assets/images/kurir/Placeholder.png';
  static const String POS = 'assets/images/kurir/POS.png';
  static const String REX = 'assets/images/kurir/REX.png';
  static const String RPX = 'assets/images/kurir/RPX.png';
  static const String SAP = 'assets/images/kurir/SAP.png';
  static const String Sicepat = 'assets/images/kurir/Sicepat.png';
  static const String SPX = 'assets/images/kurir/SPX.png';
  static const String Tiki = 'assets/images/kurir/Tiki.png';
  static const String Tokopedia = 'assets/images/kurir/Tokopedia.png';
  static const String Wahana = 'assets/images/kurir/Wahana.png';
}

abstract class LogoWidget extends StatelessWidget {
  final double size;

  const LogoWidget({this.size = 36, super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(getAssetPath(), width: size,);
  }

  String getAssetPath();
}

class LogoAnteraja extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.Anteraja;
}

class LogoDakota extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.Dakota;
}

class LogoID extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.ID;
}

class LogoIndah extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.Indah;
}

class LogoJET extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.JET;
}

class LogoJNE extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.JNE;
}

class LogoJNT extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.JNT;
}

class LogoJNTCargo extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.JNTCargo;
}

class LogoKGX extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.KGX;
}

class LogoLazada extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.Lazada;
}

class LogoLionParcel extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.LionParcel;
}

class LogoNinja extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.Ninja;
}

class LogoPCP extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.PCP;
}

class LogoPlaceholder extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.Placeholder;
}

class LogoPOS extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.POS;
}

class LogoREX extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.REX;
}

class LogoRPX extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.RPX;
}

class LogoSAP extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.SAP;
}

class LogoSicepat extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.Sicepat;
}

class LogoSPX extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.SPX;
}

class LogoTiki extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.Tiki;
}

class LogoTokopedia extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.Tokopedia;
}

class LogoWahana extends LogoWidget {
  @override
  String getAssetPath() => LogoKurir.Wahana;
}