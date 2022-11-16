import 'package:flutter/material.dart';
import 'home_page.dart';
import '../client_api.dart';

class NewCoursePage extends StatefulWidget {
  NewCoursePage({super.key});

  final ClientApi api = ClientApi();

  @override
  State<NewCoursePage> createState() => _NewCoursePageState();
}

class _NewCoursePageState extends State<NewCoursePage> {
  final TextEditingController courseIdController = TextEditingController();
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController creditsController = TextEditingController();
  final TextEditingController instructorController = TextEditingController();
  bool _isCreditsInvalid = false;

  void addCourse() {
    int? credits = int.tryParse(creditsController.text);

    if (credits == null) {
      setState(() {
        _isCreditsInvalid = true;
      });
    } else {
      setState(() {
        _isCreditsInvalid = false;
        widget.api
            .addCourse(instructorController.text, credits,
                courseIdController.text, courseNameController.text)
            .then((value) => _toHomePage());
      });
    }
  }

  void _toHomePage() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add new course")),
      body: Center(
        child: Column(children: <Widget>[
          Visibility(
            visible: _isCreditsInvalid,
            child: const Text(
              "credits must be an int",
              style: TextStyle(color: Colors.red),
            ),
          ),
          const Text("course ID:"),
          TextFormField(
            controller: courseIdController,
          ),
          const Text("Course name:"),
          TextFormField(controller: courseNameController),
          const Text("credits"),
          TextFormField(
            controller: creditsController,
            keyboardType: TextInputType.number,
          ),
          const Text("Instructor name:"),
          TextFormField(controller: instructorController),
          ElevatedButton(onPressed: addCourse, child: const Text("Add"))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toHomePage,
        child: const Icon(Icons.home),
      ),
    );
  }
}
