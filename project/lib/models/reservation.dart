import 'package:flutter/material.dart';

class ReservationData {
  String name;
  DateTime date;
  TimeOfDay time;
  String description;

  ReservationData({
    required this.name,
    required this.date,
    required this.time,
    required this.description,
  });

  factory ReservationData.fromJson(Map<String, dynamic> json) {
    return ReservationData(
      name: json['name'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
        hour: json['hour'],
        minute: json['minute'],
      ),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date.toIso8601String(),
      'hour': time.hour,
      'minute': time.minute,
      'description': description,
    };
  }
}
