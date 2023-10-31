import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:project/models/schedule_list.dart';

class ScheduleListPage extends StatefulWidget {
  const ScheduleListPage({Key? key}) : super(key: key);

  @override
  State<ScheduleListPage> createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<ScheduleListPage> {
  List<ScheduleList> scheduleItems = [
    ScheduleList(day: "Sunday", isDayOff: true),
    ScheduleList(day: "Monday"),
    ScheduleList(day: "Tuesday"),
    ScheduleList(day: "Wednesday"),
    ScheduleList(day: "Thursday"),
    ScheduleList(day: "Friday", isDayOff: true),
    ScheduleList(day: "Saturday"),
  ];

  List<Color> avatarColors = [
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.blue,
    Colors.purple,
    Colors.teal,
    Colors.indigo,
  ];

  void showReserveDialog(String day) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String message;
        String title;

        final selectedDay = scheduleItems.firstWhere((item) => item.day == day);

        if (selectedDay.isDayOff) {
          title = "Day Off";
          message = "Hari ini adalah hari libur";
        } else {
          title = "Reservasi";
          message = "Anda akan melakukan reservasi untuk hari $day";
        }

        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Batal"),
            ),
            if (title == "Reservasi")
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/reservation');
                },
                child: const Text("Reservasi"),
              )
          ],
        );
      },
    );
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            LineIcons.arrowCircleLeft,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Schedule',
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
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: ListView.builder(
                  itemCount: scheduleItems.length,
                  itemBuilder: (context, index) {
                    final day = scheduleItems[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: avatarColors[
                                            index % avatarColors.length],
                                        child: Text(
                                          day.day[0],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            day.day,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  if (!day.isDayOff)
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue[200],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          showReserveDialog(day.day);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blue,
                                        ),
                                        icon: Icon(LineIcons.calendarCheck),
                                        label: Text("Reservasi"),
                                      ),
                                    ),
                                  if (day.isDayOff)
                                    Text(
                                      "Day Off",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
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
            ],
          ),
        ),
      ),
    );
  }
}
