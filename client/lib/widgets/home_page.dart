import 'package:flutter/material.dart';
import '../client_api.dart';
import 'new_course_page.dart';
import 'students_page.dart';
import './data_load_indicator.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

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
      courses.sort((a, b) => a['courseName'].compareTo(b['courseName']));

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
        title: const Text('Courses'),
      ),
      body: Center(
          child: _isDataAvailable
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                              Text(
                                "Course ID",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                "Course Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                "Credits",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                "Instructor",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                          ..._courses.map((course) =>
                              _InteractiveCourseRow(course: course)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NewCoursePage()));
                                    },
                                    child: const Text("Add New Course")),
                              ])
                        ],
                      ),
                    )
                  ],
                )
              : const DataLoadingIndicator()),
    );
  }
}

class _InteractiveCourseRow extends StatelessWidget {
  const _InteractiveCourseRow({super.key, required this.course});

  final dynamic course;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(course['courseID']),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(course['courseName']),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(course['courseCredits'].toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(course['courseInstructor']),
          )
        ],
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StudentsPage(
                      courseName: course["courseName"],
                      id: course['_id'],
                    )));
      },
    );
  }
}
