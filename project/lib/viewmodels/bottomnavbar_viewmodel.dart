import 'package:flutter/material.dart';
import 'package:project/views/history_page.dart';
import 'package:project/views/home_page.dart';

class BottomNavBarModel extends ChangeNotifier {
  int _currentIndex = 0;

  int getCurrentIndex() {
    return _currentIndex;
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Widget getCurrentPage() {
    if (_currentIndex == 0) {
      return HomePage(key: UniqueKey());
    } else if (_currentIndex == 1) {
      return HistoryPage();
    }
    // Tambahkan halaman lain jika diperlukan
    return Container();
  }

  String getCurrentPageTitle() {
    if (_currentIndex == 0) {
      return 'Doctor Reservation';
    } else if (_currentIndex == 1) {
      return 'History';
    } else if (_currentIndex == 2) {
      return 'Profile';
    }

    // Tambahkan judul halaman lain jika diperlukan
    return '';
  }
}
