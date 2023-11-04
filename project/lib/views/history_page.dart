import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/models/reservation.dart';
import 'package:project/utils/history_shared_preferences-utils.dart';
import 'package:project/views/profile_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<ReservationData> reservations = [];
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadReservations();
  }

  Future<void> _loadReservations() async {
    final historySharedPreferencesUtils =
        HistorySharedPreferencesUtils(); // Membuat instance objek

    final loadedReservations =
        await historySharedPreferencesUtils.getReservations();

    setState(() {
      reservations = loadedReservations;
      _dataLoaded = true;
    });
  }

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
                          'History',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Docs Reservations',
                          style: TextStyle(color: Colors.blue, fontSize: 12),
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
              Divider(),
              const SizedBox(height: 16),
              _dataLoaded
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: ListView.builder(
                          itemCount: reservations.length,
                          itemBuilder: (context, index) {
                            final reservation = reservations[index];
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              transform: _dataLoaded
                                  ? Matrix4.translationValues(0, 0, 0)
                                  : Matrix4.translationValues(0, -50, 0),
                              child: Card(
                                elevation: 5,
                                margin: const EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          ClipOval(),
                                          SizedBox(width: 16),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Name: ${reservation.name}',
                                                style: GoogleFonts.openSans(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                'Date: ${reservation.date.toString()}',
                                                style: GoogleFonts.openSans(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                'Time: ${reservation.time.format(context)}',
                                                style: GoogleFonts.openSans(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                'Description: ${reservation.description}',
                                                style: GoogleFonts.openSans(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _editReservation(context, index);
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  color: Colors.blue,
                                                ),
                                                Text('Edit'),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          GestureDetector(
                                            onTap: () {
                                              _deleteReservation(
                                                  context, index);
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                Text('Delete'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _editReservation(BuildContext context, int index) {
    final historySharedPreferencesUtils = HistorySharedPreferencesUtils();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<List<ReservationData>>(
          future: historySharedPreferencesUtils.getReservations(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              // Handle error if there's any
              return AlertDialog(
                title: Text('Error'),
                content: Text('An error occurred: ${snapshot.error}'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return AlertDialog(
                title: Text('No Reservations Available'),
                content: Text('There are no reservations available.'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            } else {
              final reservations = snapshot.data!;
              final selectedReservation = reservations[index];
              TextEditingController nameController =
                  TextEditingController(text: selectedReservation.name);
              TextEditingController dateController = TextEditingController(
                  text: selectedReservation.date.toString());
              TimeOfDay selectedTime = selectedReservation.time;
              TextEditingController descriptionController =
                  TextEditingController(text: selectedReservation.description);

              return AlertDialog(
                title: Text('Edit Reservation'),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                      ),
                      SizedBox(height: 16),
                      Text('Date:'),
                      TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(labelText: 'Date'),
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedReservation.date,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (selectedDate != null) {
                            setState(() {
                              selectedReservation.date = selectedDate;
                              dateController.text =
                                  selectedReservation.date.toString();
                            });
                          }
                        },
                      ),
                      SizedBox(height: 16),
                      Text('Time:'),
                      GestureDetector(
                        onTap: () async {
                          TimeOfDay? newTime = await showTimePicker(
                            context: context,
                            initialTime: selectedTime,
                          );
                          if (newTime != null) {
                            setState(() {
                              selectedTime = newTime;
                            });
                          }
                        },
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Time: ${selectedTime.format(context)}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Icon(Icons.edit, size: 20),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: descriptionController,
                        decoration: InputDecoration(labelText: 'Description'),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          selectedReservation.name = nameController.text;
                          selectedReservation.date =
                              DateTime.parse(dateController.text);
                          selectedReservation.description =
                              descriptionController.text;
                          selectedReservation.time = selectedTime;
                          reservations[index] = selectedReservation;
                          await historySharedPreferencesUtils
                              .saveReservations(reservations);

                          setState(() {});

                          Navigator.of(context).pop();
                        },
                        child: Text('Save Changes'),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    ).then((value) {
      _loadReservations();
    });
  }

  void _deleteReservation(BuildContext context, int index) {
    final historySharedPreferencesUtils = HistorySharedPreferencesUtils();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<List<ReservationData>>(
          future: historySharedPreferencesUtils.getReservations(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              // Handle error if there's any
              return AlertDialog(
                title: Text('Error'),
                content: Text('An error occurred: ${snapshot.error}'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return AlertDialog(
                title: Text('No Reservations Available'),
                content: Text('There are no reservations available.'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            } else {
              return AlertDialog(
                title: Text('Delete Reservation'),
                content:
                    Text('Are you sure you want to delete this reservation?'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      final reservations = snapshot.data!;
                      reservations.removeAt(index);
                      historySharedPreferencesUtils
                          .saveReservations(reservations);
                      Navigator.of(context).pop();
                    },
                    child: Text('Delete'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                ],
              );
            }
          },
        );
      },
    ).then((value) {
      _loadReservations();
    });
  }
}
