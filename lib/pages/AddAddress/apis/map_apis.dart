// ignore_for_file: depend_on_referenced_packages, avoid_dynamic_calls
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:neighbour_app/config/environments.dart';
import 'package:neighbour_app/utils/helper.dart';

final String mapApiKey = '${dotenv.env[Environments.mapApiKey]}';

Future<Map<String, dynamic>?> getDataFromPlaces(String placeId) async {
  try {
    const placesBaseURL = 'https://places.googleapis.com/v1/places';
    final placesRequest = '$placesBaseURL/$placeId';
    final headers = {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': mapApiKey,
      'X-Goog-FieldMask': 'id,location,adrFormatAddress',
    };

    final placesResponse = await http.get(
      Uri.parse(placesRequest),
      headers: headers,
    );
    if (placesResponse.statusCode == 200) {
      final details = jsonDecode(placesResponse.body) as Map<String, dynamic>;
      final address = extractAddress('${details['adrFormatAddress']}');
      if (isAddressComplete(address)) {
        return {
          'latitude': details['location']['latitude'].toString(),
          'longitude': details['location']['longitude'].toString(),
          'address': address,
        };
      } else {
        return {'error': 'error'};
      }
    }
  } catch (e) {
    return null;
  }
  return null;
}
