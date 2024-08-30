import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paket_tracker_app/databases/db_helper.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';
import 'package:paket_tracker_app/screens/widgets/images/logo_kurir.dart';
import 'package:paket_tracker_app/screens/widgets/spacer.dart';
import 'package:quickalert/quickalert.dart';

class RiwayatPencarian extends StatefulWidget {
  const RiwayatPencarian({super.key});

  @override
  State<RiwayatPencarian> createState() => _RiwayatPencarianState();
}

class _RiwayatPencarianState extends State<RiwayatPencarian> {
  List<Map<String, dynamic>> _trackingRecords = [];

  @override
  void initState() {
    super.initState();
    _loadTrackingRecords();
  }

  Future<void> _loadTrackingRecords() async {
  final dbHelper = DBHelper();
  final records = await dbHelper.getTrackingRecords();

  print(records); // Check the content and structure

  // Ensure that records are modifiable
  if (records.isNotEmpty) {
    setState(() {
      _trackingRecords = List.from(records); // Copy to ensure modifiability
    });
  }
}

  Future<void> _loadSavedData() async {
    await _loadTrackingRecords(); // Reload the data
  }

  Future<void> _deleteRecord(int index) async {
    final dbHelper = DBHelper();
    final record = _trackingRecords[index];

    await dbHelper.deleteTrackingRecord(record['id']); // Call your delete method
    _loadTrackingRecords(); // Reload records after deletion
  }

  void _showOptionsDialog(int index) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.confirm,
    title: 'Warning!',
    text: 'Apakah Anda yakin ingin menghapus riwayat ini?',
    confirmBtnText: 'Hapus',
    cancelBtnText: 'Batal',
    confirmBtnColor: Colors.red,
    onConfirmBtnTap: () async {
      Navigator.of(context).pop(); // Close the alert
      await _deleteRecord(index); // Delete the record
    },
    onCancelBtnTap: () {
      Navigator.of(context).pop(); // Close the alert
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BgPutih,
      body: Column(
        children: [
          AppSpacer.VerticalSpacerMedium,
          Text(
            'Lihat dan Kelola Riwayat Pencarian Anda',
            style: AppFonts.poppinsRegular(),
          ),
          AppSpacer.VerticalSpacerSmall,
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadSavedData,
              child: ListView.builder(
                itemCount: _trackingRecords.length,
                itemBuilder: (context, index) {
                  final record = _trackingRecords[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: GestureDetector(
                      onTap: () {},
                      child: Card(
                        color: Colors.white,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    getCourierLogo(record['courier']),
                                    AppSpacer.HorizontalSpacerLarge,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                        children: [
                                          Text(
                                            record['resi'] ?? 'Unknown Resi',
                                            style: AppFonts.poppinsBold(),
                                          ),
                                          AppSpacer.HorizontalSpacerExtraSmall,
                                          GestureDetector(
                                            child: Icon(Icons.copy, size: 12),
                                            onTap: () {
                                              Clipboard.setData(
                                                ClipboardData(
                                                  text: record['resi'] ?? '',
                                                ),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Resi disalin ke clipboard'),
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                        Text(
                                          '${record['courier'] ?? 'Unknown Courier'}',
                                          style: AppFonts.poppinsMedium(
                                              fontSize: 10),
                                        ),
                                        Text(
                                          'Timestamp:  ${record["timestamp"] ?? 'Unknown Time'}',
                                          style: AppFonts.poppinsLight(
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        _showOptionsDialog(index);
                                      },
                                      child: Image.asset(
                                        AppIcons.IcDeleteRed,
                                        height: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
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
