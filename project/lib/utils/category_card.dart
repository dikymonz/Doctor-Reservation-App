import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final iconImagePath;
  final String categoryName;

  CategoryCard({required this.iconImagePath, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue[200],
        ),
        child: Row(
          children: [
            Image.asset(
              iconImagePath,
              height: 70,
            ),
            SizedBox(width: 10),
            Text(categoryName, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
