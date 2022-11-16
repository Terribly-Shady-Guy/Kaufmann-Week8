import 'package:flutter/material.dart';
import '../client_api.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.title});

  final String title;
  final ClientApi api = ClientApi();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _courses = [];
  bool _isDataAvailable = false;

  @override
  void initState() {
    super.initState();

    widget.api.getAllCourses().then((courses) {
      setState((() {
        _courses = courses;
        _isDataAvailable = true;
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: _isDataAvailable
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[const Text("Test")],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "Loading data. Please wait...",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    CircularProgressIndicator()
                  ],
                )),
    );
  }
}
