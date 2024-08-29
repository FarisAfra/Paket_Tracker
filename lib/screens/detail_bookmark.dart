import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paket_tracker_app/screens/widgets/colors.dart';
import 'package:paket_tracker_app/screens/widgets/images/logo_kurir.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:timeline_tile/timeline_tile.dart';

class DetailBookmarkPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const DetailBookmarkPage({Key? key, required this.data}) : super(key: key);

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
          history = List<Map<String, dynamic>>.from(responseData['data']['history'] ?? []);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Bookmark'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                getCourierLogo(widget.data['courier']),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data['name'] ?? 'Unknown Name',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Kurir: ${widget.data['courier'] ?? 'Unknown Courier'}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'No. Resi: ${widget.data['awb'] ?? 'Unknown Resi'}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else if (hasError)
              Center(child: Text('Error loading data'))
            else if (history.isEmpty)
              Center(child: Text('No history available'))
            else
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.BiruSecondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                            color: isFirst ? AppColors.BiruPrimary : AppColors.Putih,
                            width: 10,
                          ),
                          beforeLineStyle: LineStyle(
                            color: AppColors.Putih,
                            thickness: 2,
                          ),
                          afterLineStyle: isLast ? null : LineStyle(
                            color: AppColors.Putih,
                            thickness: 2,
                          ),
                          endChild: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 16),
                                Text(
                                  historyItem['desc'] ?? 'No Description',
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  historyItem['date'] ?? 'No Date',
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                        );
                      },
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


