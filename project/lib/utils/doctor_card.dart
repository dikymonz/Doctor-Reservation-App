import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final String doctorImagePath;
  final String rating;
  final String doctorName;
  final String doctorProfession;

  DoctorCard(
      {required this.doctorImagePath,
      required this.rating,
      required this.doctorName,
      required this.doctorProfession});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.blue[200], borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            // Doctor imagesImg
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                doctorImagePath,
                height: 100,
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // Ratting out of 5
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow[600],
                ),
                Text(
                  rating,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            // Doctor name
            Text(
              doctorName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),

            // Doctor title
            Text(doctorProfession + ' 7 y.e.'),
          ],
        ),
      ),
    );
  }
}
