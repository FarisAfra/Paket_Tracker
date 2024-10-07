import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:paket_tracker_app/databases/db_helper.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/errors/error_nodata_screen.dart';
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

    await dbHelper
        .deleteTrackingRecord(record['id']); // Call your delete method
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

  String _formatTimestamp(String? timestamp) {
    if (timestamp == null) return 'Unknown Time';

    // Parsing string timestamp to DateTime object
    DateTime parsedDate = DateTime.parse(timestamp);

    // Formatting DateTime to desired format
    String formattedDate = DateFormat('dd MMM yyyy, HH:mm:ss').format(parsedDate);

    return formattedDate;
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
              child: _trackingRecords.isEmpty
              ?Center(
                child: ErrorNodataScreen(
                    title: 'Anda Belum Memiliki Riwayat',
                    desc:
                        'Silahkan Lakukan Pencarian Dahulu dan\nSimpan Data Paket Anda',
                    IconButton: AppIcons.IcTrackWhite,
                    TextButton: 'Lacak Paket Saya',
                    handler:
                        () {
                          
                        }),
              )
              : ListView.builder(
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
                                            AppSpacer
                                                .HorizontalSpacerExtraSmall,
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
                                        getCourierName(record['courier']),
                                        Text(
                                          'Pada: ${_formatTimestamp(record["timestamp"])}',
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

Widget getCourierName(String? courier) {
  switch (courier?.toLowerCase()) {
    case 'anteraja':
      return Text('AnterAja', style: AppFonts.poppinsMedium(fontSize: 10));
    case 'dakota':
      return Text('Dakota', style: AppFonts.poppinsMedium(fontSize: 10));
    case 'id':
      return Text('ID Express', style: AppFonts.poppinsMedium(fontSize: 10));
    case 'indah':
      return Text('Indah Cargo', style: AppFonts.poppinsMedium(fontSize: 10));
    case 'jet':
      return Text('JET Express', style: AppFonts.poppinsMedium(fontSize: 10));
    case 'jne':
      return Text('JNE Express', style: AppFonts.poppinsMedium(fontSize: 10));
    case 'jnt':
      return Text('J&T Express', style: AppFonts.poppinsMedium(fontSize: 10));
    case 'jnt cargo':
      return Text('J&T Cargo', style: AppFonts.poppinsMedium(fontSize: 10));
    case 'kgx':
      return Text('KGXpress', style: AppFonts.poppinsMedium(fontSize: 10));
    case 'lazada':
      return Text('Lazada Express',
          style: AppFonts.poppinsMedium(fontSize: 10));
    case 'lion parcel':
      return Text('Lion Parcel', style: AppFonts.poppinsMedium(fontSize: 10));
    case 'ninja':
      return Text('Ninja Express', style: AppFonts.poppinsMedium(fontSize: 10));
    case 'pcp':
      return Text('PCP Express', style: AppFonts.poppinsMedium(fontSize: 10));
    case 'pos indonesia':
      return Text('Pos Indonesia', style: AppFonts.poppinsMedium(fontSize: 10));
    case 'rex':
      return Text('REX Express', style: AppFonts.poppinsMedium(fontSize: 10));
    case 'rpx':
      return Text('RPX Express', style: AppFonts.poppinsMedium(fontSize: 10));
    case 'sap':
      return Text('SAP Express', style: AppFonts.poppinsMedium(fontSize: 10));
    case 'sicepat':
      return Text('SiCepat Express',
          style: AppFonts.poppinsMedium(fontSize: 10));
    case 'spx':
      return Text('Shopee Express',
          style: AppFonts.poppinsMedium(fontSize: 10));
    case 'tiki':
      return Text('TIKI', style: AppFonts.poppinsMedium(fontSize: 10));
    case 'tokopedia':
      return Text('Tokopedia', style: AppFonts.poppinsMedium(fontSize: 10));
    case 'wahana':
      return Text('Wahana', style: AppFonts.poppinsMedium(fontSize: 10));
    default:
      return Text('Unknown Courier',
          style: AppFonts.poppinsMedium(
              fontSize: 10)); // Nama default jika kurir tidak ditemukan
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
