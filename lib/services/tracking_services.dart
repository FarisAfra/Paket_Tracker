import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class TrackingService {
  // API URL
  final String apiUrl = 'https://api.binderbyte.com/v1/track?api_key=${dotenv.env['API_KEY']}&courier=jne&awb=582230008329223';

  // Function to fetch tracking data
  Future<void> fetchTrackingData() async {
    try {
      // Send GET request to the API
      final response = await http.get(Uri.parse(apiUrl));

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Decode the JSON response
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Check the status of the response
        if (jsonData['status'] == 200) {
          // Extract data from the response
          final summary = jsonData['data']['summary'];
          final detail = jsonData['data']['detail'];
          final history = jsonData['data']['history'];

          // Get specific values
          final awb = summary['awb'];
          final courier = summary['courier'];
          final receiver = detail['receiver'];
          final shipper = detail['shipper'];
          final origin = detail['origin'];
          final destination = detail['destination'];
          final firstHistoryDesc = history[0]['desc'];

          // Print the extracted data
          print('Awb: $awb');
          print('Courier: $courier');
          print('Receiver: $receiver');
          print('Shipper: $shipper');
          print('Origin: $origin');
          print('Destination: $destination');
          print('First History Description: $firstHistoryDesc');

          // Do something with the data in your Flutter app
        } else {
          print('Error: ${jsonData['message']}');
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
