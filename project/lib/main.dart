import 'package:flutter/material.dart';
import 'package:project/viewmodels/bottomnavbar_viewmodel.dart';
import 'package:project/views/chatmessage_page.dart';
import 'package:project/views/home_page.dart';
import 'package:project/views/reservation_page.dart';
import 'package:project/views/schedule_list_page.dart';
import 'package:provider/provider.dart';
import 'package:project/views/bottom_navbar.dart';
import 'package:project/views/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavBarModel()),

        // Tambahkan provider lain jika diperlukan untuk ViewModel lain
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dokter Reservasi',
        initialRoute: '/',
        routes: {
          '/': (context) => BottomNav(),
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(key: UniqueKey()),
          '/history': (context) => const ReservationPage(),
          '/schedule': (context) => const ScheduleListPage(),
          '/reservation': (context) => const ReservationPage(),
          '/chatmessage': (context) => const ChatAi(title: 'Chat AI'),
        },
      ),
    );
  }
}
