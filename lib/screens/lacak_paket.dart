import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paket_tracker_app/databases/db_helper.dart';
import 'package:paket_tracker_app/models/tracking_data.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/icon_button.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/icon_toggle_save_button.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/primary_button.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/errors/card_error_widget.dart';
import 'package:paket_tracker_app/screens/widgets/errors/card_loading.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';
import 'package:paket_tracker_app/screens/widgets/images/logo_kurir.dart';
import 'package:paket_tracker_app/screens/widgets/inputs/dropdown_icon.dart';
import 'package:paket_tracker_app/screens/widgets/inputs/textfields_icon.dart';
import 'package:paket_tracker_app/screens/widgets/spacer.dart';
import 'package:paket_tracker_app/services/tracking_services.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:http/http.dart' as http;

class LacakPaket extends StatefulWidget {
  final String resi;

  const LacakPaket({required this.resi, super.key});

  @override
  State<LacakPaket> createState() => _LacakPaketState();
}

class _LacakPaketState extends State<LacakPaket> {
  String? _selectedCourier;
  String? _enteredResi;

  void onTrackPackage(String resi, String courier) async {
    setState(() {
      _enteredResi = resi;
      _selectedCourier = courier;
    });

    // Create an instance of DBHelper
    final dbHelper = DBHelper();
    await dbHelper.addOrUpdateTrackingRecord(resi, courier);

    // Optionally reload tracking records or perform other actions
    // _loadTrackingRecords();
  }

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
                LacakPaketWidget(
                  resi: widget.resi,
                  onTrackPackage: onTrackPackage,
                ),
                AppSpacer.VerticalSpacerMedium,
                Text(
                  'Hasil Pencarian Anda:',
                  style: AppFonts.poppinsRegular(),
                ),
                AppSpacer.VerticalSpacerMedium,
                if (_enteredResi != null && _selectedCourier != null)
                  HasilPencarian(
                    resi: _enteredResi!,
                    courier: _selectedCourier!,
                  ),
                SizedBox(height: 75)
              ],
            ),
          )),
        ));
  }
}

class LacakPaketWidget extends StatelessWidget {
  final String resi;
  final Function(String resi, String courier) onTrackPackage;

  const LacakPaketWidget(
      {required this.resi, required this.onTrackPackage, super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _resiController =
        TextEditingController(text: resi);
    String? selectedCourier = '';

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Container(
        color: AppColors.BiruSecondary,
        child: Stack(
          children: [
            Align(
              alignment: Alignment(1, 0),
              child: Image.asset(AppIcons.IcLocationBigTransparent),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lacak Paket Anda',
                          style: AppFonts.poppinsRegular(fontSize: 18)),
                      Text('Silahkan Masukkan No. Resi Paket Anda',
                          style: AppFonts.poppinsExtraLight(fontSize: 12)),
                      AppSpacer.VerticalSpacerSmall,
                      Row(
                        children: [
                          CustomTextfieldsIcon(
                            controller: _resiController,
                            icons: AppIcons.IcPackageSearchGrey,
                            hintText: 'Masukkan No. Resi',
                          ),
                          AppSpacer.HorizontalSpacerSmall,
                          CustomIconButton(
                            icons: AppIcons.IcScanWhite,
                            sizeIcons: 20,
                            padding: 8,
                            bgColor: AppColors.BiruPrimary,
                            handler: () {},
                          ),
                        ],
                      ),
                      AppSpacer.VerticalSpacerSmall,
                      CustomDropdown(
                        width: 310,
                        icons: AppIcons.IcTruckGrey,
                        hintText: 'Select Courier',
                        items: [
                          {
                            'label': 'Anteraja',
                            'value': 'anteraja',
                            'icon': LogoKurir.Anteraja,
                          },
                          {
                            'label': 'Dakota',
                            'value': 'dakota',
                            'icon': LogoKurir.Dakota,
                          },
                          {
                            'label': 'ID',
                            'value': 'id',
                            'icon': LogoKurir.ID,
                          },
                          {
                            'label': 'Indah',
                            'value': 'indah',
                            'icon': LogoKurir.Indah,
                          },
                          {
                            'label': 'JET',
                            'value': 'jet',
                            'icon': LogoKurir.JET,
                          },
                          {
                            'label': 'JNE',
                            'value': 'jne',
                            'icon': LogoKurir.JNE,
                          },
                          {
                            'label': 'JNT',
                            'value': 'jnt',
                            'icon': LogoKurir.JNT,
                          },
                          {
                            'label': 'JNT Cargo',
                            'value': 'jntcargo',
                            'icon': LogoKurir.JNTCargo,
                          },
                          {
                            'label': 'KGX',
                            'value': 'kgx',
                            'icon': LogoKurir.KGX,
                          },
                          {
                            'label': 'Lazada',
                            'value': 'lazada',
                            'icon': LogoKurir.Lazada,
                          },
                          {
                            'label': 'Lion Parcel',
                            'value': 'lionparcel',
                            'icon': LogoKurir.LionParcel,
                          },
                          {
                            'label': 'Ninja',
                            'value': 'ninja',
                            'icon': LogoKurir.Ninja,
                          },
                          {
                            'label': 'PCP',
                            'value': 'pcp',
                            'icon': LogoKurir.PCP,
                          },
                          {
                            'label': 'POS',
                            'value': 'pos',
                            'icon': LogoKurir.POS,
                          },
                          {
                            'label': 'REX',
                            'value': 'rex',
                            'icon': LogoKurir.REX,
                          },
                          {
                            'label': 'RPX',
                            'value': 'rpx',
                            'icon': LogoKurir.RPX,
                          },
                          {
                            'label': 'SAP',
                            'value': 'sap',
                            'icon': LogoKurir.SAP,
                          },
                          {
                            'label': 'SiCepat',
                            'value': 'sicepat',
                            'icon': LogoKurir.Sicepat,
                          },
                          {
                            'label': 'SPX',
                            'value': 'spx',
                            'icon': LogoKurir.SPX,
                          },
                          {
                            'label': 'Tiki',
                            'value': 'tiki',
                            'icon': LogoKurir.Tiki,
                          },
                          {
                            'label': 'Tokopedia',
                            'value': 'tokopedia',
                            'icon': LogoKurir.Tokopedia,
                          },
                          {
                            'label': 'Wahana',
                            'value': 'wahana',
                            'icon': LogoKurir.Wahana,
                          },
                        ],
                        onChanged: (value) {
                          selectedCourier = value;
                        },
                      ),
                      AppSpacer.VerticalSpacerMedium,
                      Center(
                        child: PrimaryButton(
                          Icons: AppIcons.IcTrackWhite,
                          HintText: 'Lacak Paket Saya',
                          handler: () {
                            onTrackPackage(
                              _resiController.text,
                              selectedCourier!,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class HasilPencarian extends StatefulWidget {
  final String resi;
  final String courier;

  const HasilPencarian({required this.resi, required this.courier, super.key});

  @override
  State<HasilPencarian> createState() => _HasilPencarianState();
}

class _HasilPencarianState extends State<HasilPencarian> {
  Future<Map<String, dynamic>> fetchTrackingData() async {
    final String apiUrl =
        'https://api.binderbyte.com/v1/track?api_key=${dotenv.env['API_KEY']}&courier=${widget.courier}&awb=${widget.resi}';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['status'] == 200) {
        return jsonData['data'];
      } else {
        throw Exception('Failed to load data: ${jsonData['message']}');
      }
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Map<String, dynamic>>(
        future: fetchTrackingData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomCardLoading(
              totalCard: 1,
              height: 260,
              marginX: 0,
              marginY: 0,
            );
          } else if (snapshot.hasError) {
            return CardErrorWidget(
                TextTitle: 'Data Resi Tidak Ditemukan',
                TextDesc:
                    'Pastikan Data yang Diinputkan Sudah Benar, dan Coba Lagi');
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            final awb = data['summary']['awb'];
            final courier = data['summary']['courier'];
            final shipper = data['detail']['shipper'];
            final receiver = data['detail']['receiver'];
            final origin = data['detail']['origin'];
            final destination = data['detail']['destination'];
            final status = data['summary']['status'];
            final service = data['summary']['service'];
            final weight = data['summary']['weight'];
            final amount = data['summary']['amount'];
            final date = data['summary']['date'];
            final history = data['history'];

            return Center(
              child: Container(
                width: double.infinity,
                height: 570,
                child: Column(
                  children: [
                    Card(
                      color: Colors.white,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                getCourierLogo('$courier'),
                                AppSpacer.HorizontalSpacerLarge,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('$awb', style: AppFonts.poppinsBold()),
                                    Text(
                                      '$courier',
                                      style:
                                          AppFonts.poppinsLight(fontSize: 10),
                                    )
                                  ],
                                ),
                                Spacer(),
                                IconToggleSaveButton(
                                  handler: () {
                                    
                                  },
                                  dataToSave: {
                                    'awb': awb,
                                    'courier': courier,
                                    'shipper': shipper,
                                    'receiver': receiver,
                                    'origin': origin,
                                    'destination': destination,
                                    'status': status,
                                    'service': service,
                                    'weight': weight,
                                    'amount': amount,
                                    'date': date,
                                  },
                                )
                              ],
                            ),
                            Divider(color: AppColors.BgPutih),
                            TimelineTile(
                                alignment: TimelineAlign.start,
                                isFirst: true,
                                indicatorStyle: IndicatorStyle(
                                    color: AppColors.Hitam, width: 10),
                                beforeLineStyle: LineStyle(
                                    color: AppColors.AbuMuda, thickness: 2),
                                endChild: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppSpacer.VerticalSpacerLarge,
                                      Text(
                                        'Pengirim:',
                                        style:
                                            AppFonts.poppinsLight(fontSize: 12),
                                      ),
                                      Container(
                                        child: Text('$shipper, $origin',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppFonts.poppinsBold(
                                                fontSize: 14)),
                                      ),
                                      AppSpacer.VerticalSpacerLarge
                                    ],
                                  ),
                                )),
                            TimelineTile(
                                alignment: TimelineAlign.start,
                                isLast: true,
                                indicatorStyle: IndicatorStyle(
                                    color: AppColors.AbuMuda, width: 10),
                                beforeLineStyle: LineStyle(
                                    color: AppColors.AbuMuda, thickness: 2),
                                endChild: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppSpacer.VerticalSpacerLarge,
                                      Text(
                                        'Penerima:',
                                        style:
                                            AppFonts.poppinsLight(fontSize: 12),
                                      ),
                                      Container(
                                        child: Text('$receiver, $destination',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppFonts.poppinsBold(
                                                fontSize: 14)),
                                      ),
                                      AppSpacer.VerticalSpacerLarge
                                    ],
                                  ),
                                )),
                            Divider(color: AppColors.BgPutih),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Status: ',
                                    style: AppFonts.poppinsLight(fontSize: 12)),
                                Flexible(
                                  child: Text('$status',
                                      style:
                                          AppFonts.poppinsBold(fontSize: 12)),
                                ),
                              ],
                            ),
                            Divider(color: AppColors.BgPutih),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'History Perjalanan Paket:',
                                  style: AppFonts.poppinsBold(),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '(Silahkan Scroll Riwayat Dibawah)',
                                  style: AppFonts.poppinsLight(fontSize: 8),
                                )
                              ],
                            ),
                            AppSpacer.VerticalSpacerSmall,
                            Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  color: AppColors.BiruSecondary,
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: ListView.builder(
                                    itemCount: history.length,
                                    itemBuilder: (context, index) {
                                      final historyItem = history[index];

                                      // Determine if the current TimelineTile is the first, last, or in between
                                      bool isFirst = index == 0;
                                      bool isLast = index == history.length - 1;

                                      return TimelineTile(
                                        alignment: TimelineAlign.start,
                                        isFirst: isFirst,
                                        isLast: isLast,
                                        indicatorStyle: IndicatorStyle(
                                          color: isFirst
                                              ? AppColors.BiruPrimary
                                              : AppColors.Putih,
                                          width: 10,
                                        ),
                                        beforeLineStyle: LineStyle(
                                          color: AppColors.Putih,
                                          thickness: 2,
                                        ),
                                        afterLineStyle: isLast
                                            ? null // No afterLineStyle for the last item
                                            : LineStyle(
                                                color: AppColors.Putih,
                                                thickness: 2,
                                              ),
                                        endChild: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppSpacer.VerticalSpacerLarge,
                                              Text(
                                                historyItem['desc'],
                                                style:
                                                    AppFonts.poppinsRegular(),
                                              ),
                                              Text(
                                                historyItem['date'],
                                                style: AppFonts.poppinsLight(
                                                    fontSize: 10),
                                              ),
                                              AppSpacer.VerticalSpacerLarge,
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Text('No data found.');
          }
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
    case 'jne express':
      return LogoJNE();
    case 'jnt express':
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
