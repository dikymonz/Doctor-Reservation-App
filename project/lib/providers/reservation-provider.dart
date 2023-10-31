import 'package:flutter/material.dart';
import 'package:project/models/reservation.dart';

class ReservationProvider with ChangeNotifier {
  final List<ReservationData> _reservations = [];
  List<ReservationData> get reservations => _reservations;

  void add(ReservationData reservations) {
    _reservations.add(reservations);
    notifyListeners();
  }

  void edit(int index, ReservationData updateReservation) {
    if (index >= 0 && index < _reservations.length) {
      _reservations[index] = updateReservation;
      notifyListeners();
    }
  }

  void remove(int index) {
    if (index >= 0 && index < _reservations.length) {
      _reservations.removeAt(index);
      notifyListeners();
    }
  }
}
