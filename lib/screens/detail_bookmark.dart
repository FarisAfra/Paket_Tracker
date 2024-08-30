import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/icon_button.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/outline_button.dart';
import 'package:paket_tracker_app/screens/widgets/buttons/primary_button.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/errors/card_error_widget.dart';
import 'package:paket_tracker_app/screens/widgets/errors/card_loading.dart';
import 'package:paket_tracker_app/screens/widgets/fonts.dart';
import 'package:paket_tracker_app/screens/widgets/icons.dart';
import 'package:paket_tracker_app/screens/widgets/images/logo_kurir.dart';
import 'package:http/http.dart' as http;
import 'package:paket_tracker_app/screens/widgets/spacer.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:timeline_tile/timeline_tile.dart';

class DetailBookmarkPage extends StatefulWidget {
  final Map<String, dynamic> data;
  final int index;

  const DetailBookmarkPage({
    Key? key, 
    required this.data,
    required this.index,
    }) : super(key: key);

  @override
  _DetailBookmarkPageState createState() => _DetailBookmarkPageState();
}

class _DetailBookmarkPageState extends State<DetailBookmarkPage> {
  List<Map<String, dynamic>> history = []; // List for storing history data
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    final String apiUrl =
        'https://api.binderbyte.com/v1/track?api_key=${dotenv.env['API_KEY']}&courier=${widget.data['courier']}&awb=${widget.data['awb']}';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        setState(() {
          history = List<Map<String, dynamic>>.from(
              responseData['data']['history'] ?? []);
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  Future<void> _updateDataName(String newName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? key = prefs.getKeys().elementAt(widget.index); // Get key by index

    if (key != null) {
      widget.data['name'] = newName; // Update the name in the current data
      String jsonData = jsonEncode(widget.data); // Encode back to JSON
      await prefs.setString(key, jsonData); // Save changes to SharedPreferences
      setState(() {}); // Update the UI
    }
  }

  Future<void> _deleteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? key = prefs.getKeys().elementAt(widget.index); // Get key by index

    if (key != null) {
      await prefs.remove(key); // Remove data from SharedPreferences
      setState(() {
        Navigator.pop(context); // Go back after deletion
      });

      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Data Dihapus',
        text: 'Data telah berhasil dihapus',
      );
    }
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
              Text('Detail Paket', style: AppFonts.poppinsBold(fontSize: 16)),
            ],
          ),
        ),
        actions: [
          CustomIconButton(icons: AppIcons.IcShareBlue, handler: () {}),
          SizedBox(width: 20)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getCourierLogo(widget.data['courier']),
            AppSpacer.VerticalSpacerMedium,
            Text(widget.data['name'] ?? 'Unknown Name',
                style: AppFonts.poppinsBold(fontSize: 16)),
            Text(widget.data['courier'] ?? 'Unknown courier',
                style: AppFonts.poppinsMedium(fontSize: 12)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No. Resi: ${widget.data['awb']}' ?? 'Unknown Awb',
                    style: AppFonts.poppinsLight(fontSize: 10)),
                AppSpacer.HorizontalSpacerExtraSmall,
                GestureDetector(
                  child: Icon(Icons.copy, size: 12),
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(
                        text: widget.data['awb'] ?? '',
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Resi disalin ke clipboard'),
                      ),
                    );
                  },
                )
              ],
            ),
            
            AppSpacer.VerticalSpacerMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryButton(
                    borderRadius: 5,
                    width: 150,
                    sizeIcons: 16,
                    Icons: AppIcons.IcTrackWhite,
                    HintText: 'Edit Data',
                    handler: () async {
                      // Show a dialog or a TextField to enter the new name
                      String? newName = await showDialog<String>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Edit Data'),
                          content: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter new name',
                            ),
                            onSubmitted: (value) {
                              Navigator.pop(context, value);
                            },
                          ),
                        ),
                      );// If a new name is provided, call the update function
                      if (newName != null && newName.isNotEmpty) {
                        await _updateDataName(newName); // Call update method
                      }
                    }
                      ),
                AppSpacer.HorizontalSpacerSmall,
                CustomOutlineButton(
                  OutlineColor: AppColors.Merah,
                  borderRadius: 5,
                    width: 150,
                    sizeIcons: 16,
                  Icons: AppIcons.IcDeleteRed, 
                  HintText: 'Hapus Data', 
                  handler: (){
                    _deleteData();
                  })
              ],
            ),
            AppSpacer.VerticalSpacerMedium,
            Card(
                color: AppColors.Putih,
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 12, left: 24, right: 24, bottom: 4),
                  child: Column(
                    children: [
                      Text('Detail Informasi Paket:',
                          style: AppFonts.poppinsBold(fontSize: 14)),
                      Divider(color: AppColors.BgPutih),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Status:',
                                  style: AppFonts.poppinsLight(fontSize: 10)),
                              Text('${widget.data['status'] ?? '*****'}',
                                  style:
                                      AppFonts.poppinsSemiBold(fontSize: 10)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Services:',
                                  style: AppFonts.poppinsLight(fontSize: 10)),
                              Text('${widget.data['service'] ?? '*****'}',
                                  style:
                                      AppFonts.poppinsSemiBold(fontSize: 10)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Berat:',
                                  style: AppFonts.poppinsLight(fontSize: 10)),
                              Text('${widget.data['weight'] ?? '*****'}',
                                  style:
                                      AppFonts.poppinsSemiBold(fontSize: 10)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date:',
                                  style: AppFonts.poppinsLight(fontSize: 10)),
                              Text('${widget.data['date'] ?? '*****'}',
                                  style:
                                      AppFonts.poppinsSemiBold(fontSize: 10)),
                            ],
                          ),
                        ],
                      ),
                      AppSpacer.VerticalSpacerSmall,
                      Divider(color: AppColors.BgPutih),
                      TimelineTile(
                          alignment: TimelineAlign.start,
                          isFirst: true,
                          indicatorStyle:
                              IndicatorStyle(color: AppColors.Hitam, width: 10),
                          beforeLineStyle:
                              LineStyle(color: AppColors.AbuMuda, thickness: 2),
                          endChild: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppSpacer.VerticalSpacerLarge,
                                Text(
                                  'Pengirim:',
                                  style: AppFonts.poppinsLight(fontSize: 12),
                                ),
                                Container(
                                  child: Text(
                                      '${widget.data['shipper'] ?? '*****'}, ${widget.data['origin'] ?? '*****'}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          AppFonts.poppinsBold(fontSize: 14)),
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
                          beforeLineStyle:
                              LineStyle(color: AppColors.AbuMuda, thickness: 2),
                          endChild: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppSpacer.VerticalSpacerLarge,
                                Text(
                                  'Penerima:',
                                  style: AppFonts.poppinsLight(fontSize: 12),
                                ),
                                Container(
                                  child: Text(
                                      '${widget.data['receiver'] ?? '*****'}, ${widget.data['destination'] ?? '*****'}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          AppFonts.poppinsBold(fontSize: 14)),
                                ),
                                AppSpacer.VerticalSpacerLarge
                              ],
                            ),
                          )),
                    ],
                  ),
                )),
            AppSpacer.VerticalSpacerExtraSmall,
            if (isLoading)
              Center(child: CustomCardLoading(
              totalCard: 1,
              height: 200,
              marginX: 0,
              marginY: 0,
            ))
            else if (hasError)
              Center(child: CardErrorWidget(
                TextTitle: 'Gagal Memuat Data',
                TextDesc:
                    'Pastikan Anda Terhubung Ke Internet, dan Coba Lagi'))
            else if (history.isEmpty)
              Center(child: CardErrorWidget(
                TextTitle: 'Data History Tidak Ditemukan',
                TextDesc:
                    'Pastikan Data yang Diinputkan Sudah Benar, dan Coba Lagi'))
            else
              Expanded(
                child: Card(
                  color: AppColors.Putih,
                  elevation: 3, // Optional elevation for a shadow effect
                  margin: EdgeInsets.symmetric(
                      vertical: 8, horizontal: 4), // Margin around the card
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text details at the top of the Card
                        Text(
                          'Detail History Perjalanan Paket:',
                          style: AppFonts.poppinsSemiBold(fontSize: 12),
                        ),
                        Text(
                          '(Silahkan Scroll Untuk Detail Lebih Lengkap)',
                          style: AppFonts.poppinsLight(fontSize: 10),
                        ),
                        AppSpacer.VerticalSpacerExtraSmall,
                        Divider(color: AppColors.BgPutih),
                        Expanded(
                          child: ListView.builder(
                            itemCount: history.length,
                            itemBuilder: (context, index) {
                              final historyItem = history[index];

                              bool isFirst = index == 0;
                              bool isLast = index == history.length - 1;

                              return TimelineTile(
                                alignment: TimelineAlign.start,
                                isFirst: isFirst,
                                isLast: isLast,
                                indicatorStyle: IndicatorStyle(
                                  color: isFirst
                                      ? AppColors.Hitam
                                      : AppColors.AbuMuda,
                                  width: 10,
                                ),
                                beforeLineStyle: LineStyle(
                                  color: AppColors.AbuMuda,
                                  thickness: 2,
                                ),
                                afterLineStyle: isLast
                                    ? null
                                    : LineStyle(
                                        color: AppColors.Hitam,
                                        thickness: 2,
                                      ),
                                endChild: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 16),
                                      Text(
                                        historyItem['desc'] ?? 'No Description',
                                        style: AppFonts.poppinsMedium(),
                                      ),
                                      Text(
                                        historyItem['date'] ?? 'No Date',
                                        style: AppFonts.poppinsRegular(
                                            color: AppColors.AbuTua,
                                            fontSize: 11),
                                      ),
                                      SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
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
