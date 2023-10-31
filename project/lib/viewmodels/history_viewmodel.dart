import 'package:flutter/material.dart';

class HistoryModel {
  String historyData;

  HistoryModel(this.historyData);
}

class HistoryViewModel with ChangeNotifier {
  List<HistoryModel> _history = [];

  List<HistoryModel> get history => _history;

  // Tambahkan history ke dalam list
  void addHistory(String historyData) {
    final newHistory = HistoryModel(historyData);
    _history.add(newHistory);
    notifyListeners();
  }

  // Dapatkan semua history yang tersimpan
  List<HistoryModel> getAllHistory() {
    return _history;
  }

  // Bersihkan semua history
  void clearHistory() {
    _history.clear();
    notifyListeners();
  }
}
