import 'package:flutter/material.dart';
import './home_page.dart';
import './student_fname_page.dart';
import '../client_api.dart';
import './data_loading_indicator.dart';
import './new_student_page.dart';

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
      appBar: AppBar(
        title: Text(widget.courseName),
        centerTitle: true,
      ),
      body: Center(
          child: _isDataAvailable
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                widget.api
                                    .deleteCourseById(widget.id)
                                    .then((value) => _toHomePage());
                              },
                              child: const Text("Delete course")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NewStudentPage()));
                              },
                              child: const Text("Add Student")),
                        )
                      ],
                    ),
                    Expanded(
                        child: ListView(
                      children: <Widget>[
                        ..._students.map((student) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  StudentFnamePage(
                                                      id: student['_id']))));
                                    },
                                    child: const Text("Change First Name"))
                              ],
                            ))
                      ],
                    ))
                  ],
                )
              : const DataLoadingIndicator()),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: FloatingActionButton(
          onPressed: _toHomePage,
          backgroundColor: Colors.orange,
          foregroundColor: Colors.cyan,
          child: const Icon(Icons.home),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
