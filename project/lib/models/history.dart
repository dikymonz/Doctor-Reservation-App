import 'package:flutter/material.dart';

class HistoryModel {
  String name;
  DateTime date;
  TimeOfDay time;
  String description;

  HistoryModel({
    required this.name,
    required this.date,
    required this.time,
    required this.description,
  }) {
    if (name.isEmpty) {
      throw ArgumentError('Name cannot be empty');
    }
    if (description.isEmpty) {
      throw ArgumentError('Description cannot be empty');
    }
  }
}
