import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/models/reservation.dart';

class HistorySharedPreferencesUtils {
  static const _keyReservations = 'reservations';

  Future<List<ReservationData>> getReservations() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? reservationsString = prefs.getString(_keyReservations);

    if (reservationsString != null) {
      final List<dynamic> jsonList = json.decode(reservationsString);
      final List<ReservationData> reservations =
          jsonList.map((json) => ReservationData.fromJson(json)).toList();
      return reservations;
    } else {
      return [];
    }
  }

  Future<void> saveReservations(List<ReservationData> reservations) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList =
        reservations.map((res) => res.toJson()).toList();
    final String jsonString = json.encode(jsonList);

    await prefs.setString(_keyReservations, jsonString);
  }
}
