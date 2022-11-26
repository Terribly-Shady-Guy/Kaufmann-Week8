import 'package:flutter/material.dart';

class DataLoadingIndicator extends StatelessWidget {
  const DataLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Text(
          "Loading Data. Please Wait...",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        CircularProgressIndicator()
      ],
    );
  }
}
