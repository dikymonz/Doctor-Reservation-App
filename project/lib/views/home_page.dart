import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/utils/category_card.dart';
import 'package:project/utils/doctor_card.dart';
import 'package:project/viewmodels/home_viewmodel.dart';
import 'package:project/views/chatmessage_page.dart';
import 'package:project/views/profile_page.dart';
import 'package:project/views/reservation_page.dart';
import 'package:project/views/schedule_list_page.dart';

class HomePage extends StatefulWidget {
  final HomeViewModel viewModel = HomeViewModel();

  HomePage({required Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Docs Reserve',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Welcome, Delia Sepiana',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProfilePage(), // Navigasi ke halaman profil
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: Lottie.network(
                          'https://lottie.host/8fa3c648-163a-49d2-981e-5ed194e64e12/mnKVtijzqy.json',
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'How do you feel?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Ceritakan keluhan anda melalui tombol di bawah ini.',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChatAi(title: 'Chat AI'),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.blue[200],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(child: Text('Konsultasi Gratis')),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReservationPage(),
                            ),
                          );
                        },
                        child: Hero(
                          tag: 'reservasiHero',
                          child: CategoryCard(
                            categoryName: 'Reservations',
                            iconImagePath: "assets/images/Reservationdata.png",
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScheduleListPage(),
                            ),
                          );
                        },
                        child: Hero(
                          tag: 'jadwalHero',
                          child: CategoryCard(
                            categoryName: 'Schedule      ',
                            iconImagePath: "assets/images/Schedule.png",
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatAi(title: 'Chat AI'),
                            ),
                          );
                        },
                        child: Hero(
                          tag: 'konsultasiHero',
                          child: CategoryCard(
                            categoryName: 'Consultation',
                            iconImagePath: "assets/images/Chatkonsul.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Available Doctor',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'See all',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        DoctorCard(
                          doctorImagePath: "assets/images/Drnorma.png",
                          rating: '4.9',
                          doctorName: 'drg. Norma Yustisiana, Sp.Pros',
                          doctorProfession:
                              'Dokter Gigi Spesialis Prostodonsia',
                        ),
                        DoctorCard(
                          doctorImagePath: "assets/images/Drgfara.jpg",
                          rating: '4.9',
                          doctorName: 'drg. Norma Yustisiana, Sp.Pros',
                          doctorProfession:
                              'Dokter Gigi Spesialis Prostodonsia',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
