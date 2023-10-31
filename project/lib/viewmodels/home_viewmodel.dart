import 'package:flutter/material.dart';

class HomeViewModel {
  int selectedTabIndex = 0; // Menyimpan indeks tab yang dipilih

  void goToHistoryPage(BuildContext context) {
    // Navigasi ke halaman "History"
    Navigator.pushNamed(context, '/history');
  }

  void goToHomeTab() {
    // Mengganti tab aktif ke "Home" (indeks 0)
    selectedTabIndex = 0;
  }

  void goToHistoryTab() {
    // Mengganti tab aktif ke "History" (indeks 1)
    selectedTabIndex = 1;
  }
}
