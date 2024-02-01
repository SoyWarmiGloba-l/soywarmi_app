import 'package:flutter/material.dart';

class GenderCard extends StatelessWidget {
  final String label;
  final bool selected;
  GenderCard({super.key, required this.label,required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: (selected)?Color.fromRGBO(0,200,0,1):Theme.of(context).primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
              fontSize: 12,
            ),
          ),
        ));
  }
}
