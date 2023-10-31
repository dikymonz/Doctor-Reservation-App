import 'package:flutter/material.dart';
import 'package:project/models/reservation.dart';
import 'package:project/utils/history_shared_preferences-utils.dart';

class ReservationViewModel with ChangeNotifier {
  final HistorySharedPreferencesUtils _historySharedPreferencesUtils =
      HistorySharedPreferencesUtils();

  Future<List<ReservationData>> getReservations() async {
    final existingReservations =
        await _historySharedPreferencesUtils.getReservations();
    return existingReservations;
  }

  Future<void> addReservation(ReservationData newReservation) async {
    final existingReservations =
        await _historySharedPreferencesUtils.getReservations();
    existingReservations.add(newReservation);
    await _historySharedPreferencesUtils.saveReservations(existingReservations);
  }
}
