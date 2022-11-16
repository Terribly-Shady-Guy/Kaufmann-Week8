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

  void addCourse() {
    setState(() {
      widget.api.addCourse(
          instructorController.text,
          int.parse(creditsController.text),
          courseIdController.text,
          courseNameController.text);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => HomePage())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add new course")),
      body: Center(
        child: Column(children: <Widget>[
          const Text("course ID:"),
          TextFormField(
            controller: courseIdController,
          ),
          const Text("Course name:"),
          TextFormField(controller: courseNameController),
          const Text("credits"),
          TextFormField(controller: creditsController),
          const Text("Instructor name:"),
          TextFormField(controller: instructorController),
          ElevatedButton(
              onPressed: (() => addCourse()), child: const Text("Add"))
        ]),
      ),
    );
  }
}
