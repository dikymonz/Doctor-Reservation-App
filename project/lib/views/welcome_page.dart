// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:project/viewmodels/welcome_viewmodel.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class WelcomePage extends StatefulWidget {
//   const WelcomePage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _WelcomePageState createState() => _WelcomePageState();
// }

// class _WelcomePageState extends State<WelcomePage> {
//   final WelcomeViewModel viewModel = WelcomeViewModel();
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//   bool _showGetStartedButton = false;

//   final List<String> images = [
//     'assets/images/Welcome1.png',
//     'assets/images/Welcome2.png',
//     'assets/images/Welcome3.png',
//   ];

//   final List<String> descriptions = [
//     'Welcome to Doctors Reservation App',
//     'Find and book doctors easily',
//     'Manage your appointments with ease',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _checkIfFirstTime();
//   }

//   _checkIfFirstTime() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isFirstTime = prefs.getBool('first_time') ?? true;

//     if (isFirstTime) {
//       prefs.setBool('first_time', false);
//     } else {
//       // Redirect to other page (e.g., Home Page)
//       Navigator.pushReplacementNamed(context, '/home');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           color: Colors.blue[200],
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Expanded(
//                 child: PageView.builder(
//                   controller: _pageController,
//                   itemCount: images.length,
//                   onPageChanged: (int index) {
//                     setState(() {
//                       _currentPage = index;
//                       if (_currentPage == images.length - 1) {
//                         _showGetStartedButton = true;
//                       } else {
//                         _showGetStartedButton = false;
//                       }
//                     });
//                   },
//                   itemBuilder: (context, index) {
//                     return Align(
//                       alignment: Alignment.center,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Image.asset(
//                             images[index],
//                             height: 300,
//                             width: 300,
//                           ),
//                           SizedBox(height: 20),
//                           Padding(
//                             padding: const EdgeInsets.all(4.0),
//                             child: Text(
//                               descriptions[index],
//                               style: GoogleFonts.spaceGrotesk(
//                                 fontSize: 24,
//                                 color: Colors.white,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: _buildPageIndicator(),
//               ),
//               SizedBox(height: 20),
//               if (_showGetStartedButton)
//                 ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(Colors.white),
//                   ),
//                   onPressed: () {
//                     // Implementasi fungsi ketika tombol Get Started ditekan
//                     viewModel.goToLoginPage(context);
//                   },
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Colors.blue[200],
//                       ),
//                       SizedBox(width: 8),
//                       Text(
//                         'Get Started',
//                         style: GoogleFonts.spaceGrotesk(
//                           fontSize: 18,
//                           color: Colors.blue[200],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               if (!_showGetStartedButton)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     TextButton(
//                       style: ButtonStyle(
//                         overlayColor:
//                             MaterialStateProperty.resolveWith((states) {
//                           if (states.contains(MaterialState.hovered)) {
//                             return Colors.transparent;
//                           }
//                           return null; // Defer to the widget's default.
//                         }),
//                       ),
//                       child: Text(
//                         'Skip',
//                         style: GoogleFonts.spaceGrotesk(
//                           fontSize: 18,
//                           color: Colors.white,
//                         ),
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _showGetStartedButton = true;
//                         });
//                       },
//                     ),
//                     TextButton(
//                       style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all(Colors.blue[200]),
//                       ),
//                       onPressed: () {
//                         _pageController.nextPage(
//                             duration: Duration(milliseconds: 500),
//                             curve: Curves.ease);
//                       },
//                       child: Text(
//                         'Continue',
//                         style: GoogleFonts.spaceGrotesk(
//                             fontSize: 18, color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildPageIndicator() {
//     List<Widget> list = [];
//     for (int i = 0; i < images.length; i++) {
//       list.add(i == _currentPage ? _indicator(true) : _indicator(false));
//     }
//     return list;
//   }

//   Widget _indicator(bool isActive) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 8),
//       height: 8,
//       width: 8,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: isActive ? Colors.white : Colors.grey,
//       ),
//     );
//   }
// }
