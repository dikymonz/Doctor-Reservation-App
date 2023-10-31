import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:project/viewmodels/bottomnavbar_viewmodel.dart';
import 'package:provider/provider.dart';

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavBarModel>(
      builder: (context, model, child) {
        return Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          body: Center(child: model.getCurrentPage()),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  textStyle: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.blue,
                  color: Colors.blue,
                  tabs: [
                    GButton(
                      icon: LineIcons.home,
                      text: 'Home', // Warna teks tombol
                      iconActiveColor:
                          Colors.white, // Warna ikon ketika tombol aktif
                    ),
                    GButton(
                      icon: LineIcons.history,
                      text: 'History', // Warna teks tombol
                      iconActiveColor:
                          Colors.white, // Warna ikon ketika tombol aktif
                    ),
                  ],
                  selectedIndex: model.getCurrentIndex(),
                  onTabChange: (index) {
                    model.setCurrentIndex(index);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
