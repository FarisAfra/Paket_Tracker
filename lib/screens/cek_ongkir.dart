import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/primary_button.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';
import 'package:paket_tracker_app/screens/widgets/images/logo_kurir.dart';
import 'package:paket_tracker_app/screens/widgets/inputs/dropdown_custom.dart';
import 'package:paket_tracker_app/screens/widgets/inputs/dropdown_icon.dart';
import 'package:paket_tracker_app/screens/widgets/inputs/textfields_icon.dart';
import 'package:paket_tracker_app/screens/widgets/spacer.dart';
import 'package:http/http.dart' as http;

class CekOngkir extends StatefulWidget {
  const CekOngkir({super.key});

  @override
  State<CekOngkir> createState() => _CekOngkirState();
}

class _CekOngkirState extends State<CekOngkir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.BgPutih,
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              children: [
                CekOngkirWidget(),
                AppSpacer.VerticalSpacerLarge,
              ],
            ),
          )),
        ));
  }
}

class CekOngkirWidget extends StatefulWidget {
  const CekOngkirWidget({super.key});

  @override
  State<CekOngkirWidget> createState() => _CekOngkirWidgetState();
}

class _CekOngkirWidgetState extends State<CekOngkirWidget> {
  final TextEditingController _beratController = TextEditingController();
  String? selectedProvAsal;
  String? selectedProvTujuan;
  String? selectedKotaAsal;
  String? selectedKotaTujuan;
  String? selectedCourier;
  List<Map<String, dynamic>> _provinsiAsalItems = [];
  List<Map<String, dynamic>> _provinsiTujuanItems = [];
  List<Map<String, dynamic>> _kotaAsalItems = [];
  List<Map<String, dynamic>> _kotaTujuanItems = [];

  final String apiKey = '38a6b4d57ae5c0c0e419fe3290b51e7f';

  Future<void> _loadProvinsiAsal() async {
    final response = await http.get(
        Uri.parse('https://api.rajaongkir.com/starter/province?key=$apiKey'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final provinsi = jsonData['rajaongkir']['results'];

      setState(() {
        _provinsiAsalItems = provinsi.map<Map<String, dynamic>>((prov) {
          return {
            'label': prov['province'],
            'value': prov['province_id'],
          };
        }).toList();
      });
    } else {
      debugPrint('Failed to load provinsi asal');
    }
  }

  Future<void> _loadProvinsiTujuan() async {
    final response = await http.get(
        Uri.parse('https://api.rajaongkir.com/starter/province?key=$apiKey'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final provinsi = jsonData['rajaongkir']['results'];

      setState(() {
        _provinsiTujuanItems = provinsi.map<Map<String, dynamic>>((prov) {
          return {
            'label': prov['province'],
            'value': prov['province_id'],
          };
        }).toList();
      });
    } else {
      debugPrint('Failed to load provinsi tujuan');
    }
  }

  Future<void> _loadKotaAsal(String provinsiId) async {
    final response = await http.get(Uri.parse(
        'https://api.rajaongkir.com/starter/city?province=$provinsiId&key=$apiKey'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final kotaAsal = jsonData['rajaongkir']['results'];

      setState(() {
        _kotaAsalItems = kotaAsal.map<Map<String, dynamic>>((kota) {
          return {
            'label': '${kota['type']} ${kota['city_name']}',
            'value': kota['city_id'],
          };
        }).toList();
        selectedKotaAsal = null; // Reset kota asal yang dipilih
      });
    } else {
      debugPrint('Failed to load kota asal');
    }
  }

  Future<void> _loadKotaTujuan(String provinsiId) async {
    final response = await http.get(Uri.parse(
        'https://api.rajaongkir.com/starter/city?province=$provinsiId&key=$apiKey'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final kotaTujuan = jsonData['rajaongkir']['results'];

      setState(() {
        _kotaTujuanItems = kotaTujuan.map<Map<String, dynamic>>((kota) {
          return {
            'label': '${kota['type']} ${kota['city_name']}',
            'value': kota['city_id'],
          };
        }).toList();
        selectedKotaTujuan = null; // Reset kota tujuan yang dipilih
      });
    } else {
      debugPrint('Failed to load kota tujuan');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProvinsiAsal();
    _loadProvinsiTujuan();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Container(
        color: AppColors.BiruSecondary,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(AppIcons.IcBoxBigTransparent),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cek Ongkir Paket',
                          style: AppFonts.poppinsRegular(fontSize: 18)),
                      Text(
                          'Silahkan Masukkan Detail Paket yang Akan Anda Kirim',
                          style: AppFonts.poppinsExtraLight(fontSize: 12)),
                      AppSpacer.VerticalSpacerSmall,

                      // Dropdown untuk Provinsi Asal
                      CustomDropdownOnly(
                        width: 262,
                        icons: AppIcons.IcAsalGrey,
                        hintText: _provinsiAsalItems.isEmpty
                            ? 'Memuat...'
                            : 'Provinsi Asal',
                        items: _provinsiAsalItems,
                        value: selectedProvAsal,
                        onChanged: (value) {
                          setState(() {
                            selectedProvAsal = value;
                            if (value != null) {
                              _loadKotaAsal(
                                  value); // Muat kota setelah memilih provinsi
                            }
                          });
                        },
                      ),
                      AppSpacer.VerticalSpacerSmall,

                      // Dropdown untuk Kota Asal
                      CustomDropdownOnly(
                        width: 262,
                        icons: AppIcons.IcAsalGrey,
                        hintText: _kotaAsalItems.isEmpty
                            ? 'Pilih Provinsi Dahulu'
                            : 'Pilih Kota Asal',
                        items: _kotaAsalItems,
                        value: selectedKotaAsal,
                        onChanged: (value) {
                          setState(() {
                            selectedKotaAsal = value;
                          });
                        },
                      ),
                      AppSpacer.VerticalSpacerSmall,

                      // Dropdown untuk Provinsi Tujuan
                      CustomDropdownOnly(
                        width: 262,
                        icons: AppIcons.IcTujuanGrey,
                        hintText: _provinsiTujuanItems.isEmpty
                            ? 'Memuat...'
                            : 'Provinsi Tujuan',
                        items: _provinsiTujuanItems,
                        value: selectedProvTujuan,
                        onChanged: (value) {
                          setState(() {
                            selectedProvTujuan = value;
                            if (value != null) {
                              _loadKotaTujuan(
                                  value); // Muat kota setelah memilih provinsi
                            }
                          });
                        },
                      ),
                      AppSpacer.VerticalSpacerSmall,

                      // Dropdown untuk Kota Tujuan
                      CustomDropdownOnly(
                        width: 262,
                        icons: AppIcons.IcTujuanGrey,
                        hintText: _kotaTujuanItems.isEmpty
                            ? 'Pilih Provinsi Dahulu'
                            : 'Pilih Kota Asal',
                        items: _kotaTujuanItems,
                        value: selectedKotaTujuan,
                        onChanged: (value) {
                          setState(() {
                            selectedKotaTujuan = value;
                          });
                        },
                      ),
                      AppSpacer.VerticalSpacerSmall,

                      // Dropdown untuk Kurir
                      CustomDropdown(
                        width: 262,
                        icons: AppIcons.IcTruckGrey,
                        hintText: 'Pilih Kurir',
                        items: [
                          {
                            'label': 'JNE',
                            'value': 'jne',
                            'icon': LogoKurir.JNE,
                          },
                          {
                            'label': 'POS',
                            'value': 'pos',
                            'icon': LogoKurir.POS,
                          },
                          {
                            'label': 'Tiki',
                            'value': 'tiki',
                            'icon': LogoKurir.Tiki,
                          },
                        ],
                        value: selectedCourier,
                        onChanged: (value) {
                          setState(() {
                            selectedCourier = value;
                          });
                        },
                      ),
                      AppSpacer.VerticalSpacerSmall,

                      // Input Berat Paket
                      CustomTextfieldsIcon(
                        controller: _beratController,
                        icons: AppIcons.IcBeratGrey,
                        hintText: 'Estimasi Berat Paket',
                      ),
                      AppSpacer.VerticalSpacerMedium,

                      // Tombol Cek Ongkos Kirim
                      PrimaryButton(
                        Icons: AppIcons.IcOngkirWhite,
                        HintText: 'Cek Ongkos Kirim',
                        handler: () async {
                          if (selectedKotaAsal == null ||
                              selectedKotaTujuan == null ||
                              selectedCourier == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Silakan pilih kota asal, kota tujuan, dan kurir.')),
                            );
                            return;
                          }

                          final berat = _beratController.text.isEmpty
                              ? '1000'
                              : _beratController.text;

                          final response = await http.post(
                            Uri.parse(
                                'https://api.rajaongkir.com/starter/cost'),
                            headers: {
                              'key': apiKey,
                              'Content-Type': 'application/json',
                            },
                            body: jsonEncode({
                              'origin': selectedKotaAsal,
                              'destination': selectedKotaTujuan,
                              'weight': berat,
                              'courier': selectedCourier,
                            }),
                          );

                          if (response.statusCode == 200) {
                            final jsonData = jsonDecode(response.body);
                            final ongkir = jsonData;

                            // Tampilkan hasil ongkos kirim
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OngkirResult(ongkir: ongkir)),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Gagal mendapatkan ongkos kirim.')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class OngkirResult extends StatelessWidget {
  final Map ongkir;

  OngkirResult({required this.ongkir});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Ongkos Kirim'),
      ),
      body: ListView.builder(
        itemCount: ongkir['rajaongkir']['results'].length,
        itemBuilder: (context, index) {
          final ongkirItem = ongkir['rajaongkir']['results'][index];

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              color: AppColors.Putih,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Layanan: ${ongkirItem['name']}',
                        style: AppFonts.poppinsSemiBold()),
                    Text('Kode: ${ongkirItem['code']}',
                        style: AppFonts.poppinsSemiBold()),
                    Text(
                        'Tujuan: ${ongkir['rajaongkir']['destination_details']['province']} - ${ongkir['rajaongkir']['destination_details']['city_name']}'),
                    Text(
                        'Kode Pos: ${ongkir['rajaongkir']['destination_details']['postal_code']}'),
                    if (ongkirItem['costs'].isNotEmpty)
                      Column(
                        children: ongkirItem['costs'].map<Widget>((cost) {
                          return Column(
                            children: [
                              Text('Jenis Layanan: ${cost['service']}'),
                              Text('Deskripsi: ${cost['description']}'),
                              Text('Biaya: ${cost['cost'][0]['value']}'),
                              Text(
                                  'Estimasi Waktu: ${cost['cost'][0]['etd']} hari'),
                            ],
                          );
                        }).toList(),
                      )
                    else
                      Text('Biaya: Tidak tersedia'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget getCourierLogo(String? courier) {
  switch (courier?.toLowerCase()) {
    case 'anteraja':
      return LogoAnteraja();
    case 'dakota':
      return LogoDakota();
    case 'id':
      return LogoID();
    case 'indah':
      return LogoIndah();
    case 'jet':
      return LogoJET();
    case 'jne':
      return LogoJNE();
    case 'jnt':
      return LogoJNT();
    case 'jnt cargo':
      return LogoJNTCargo();
    case 'kgx':
      return LogoKGX();
    case 'lazada':
      return LogoLazada();
    case 'lion parcel':
      return LogoLionParcel();
    case 'ninja':
      return LogoNinja();
    case 'pcp':
      return LogoPCP();
    case 'pos indonesia':
      return LogoPOS();
    case 'rex':
      return LogoREX();
    case 'rpx':
      return LogoRPX();
    case 'sap':
      return LogoSAP();
    case 'sicepat':
      return LogoSicepat();
    case 'spx':
      return LogoSPX();
    case 'tiki':
      return LogoTiki();
    case 'tokopedia':
      return LogoTokopedia();
    case 'wahana':
      return LogoWahana();
    default:
      return LogoPlaceholder(); // Logo default jika kurir tidak ditemukan
  }
}
