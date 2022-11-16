import 'package:flutter/material.dart';
import 'home_page.dart';
import '../client_api.dart';

class StudentsPage extends StatefulWidget {
  StudentsPage({super.key, required this.courseName, required this.id});

  final String courseName;
  final ClientApi api = ClientApi();
  final String id;

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  List _students = [];
  bool _isDataAvailable = false;

  @override
  void initState() {
    super.initState();

    widget.api.getAllStudents().then((students) {
      setState(() {
        _isDataAvailable = true;
        _students = students;
      });
    });
  }

  void _toHomePage() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.courseName)),
      body: Center(
          child: _isDataAvailable
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          widget.api
                              .deleteCourseById(widget.id)
                              .then((value) => _toHomePage());
                        },
                        child: const Text("Delete course")),
                    Expanded(
                        child: ListView(
                      children: <Widget>[
                        ..._students.map((student) => Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(student['studentID'].toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(student['fname']),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(student['lname']),
                                )
                              ],
                            ))
                      ],
                    ))
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text("Data Loading. Please Wait..."),
                    CircularProgressIndicator()
                  ],
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: _toHomePage,
        child: const Icon(Icons.home),
      ),
    );
  }
}
