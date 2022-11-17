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
  final TextEditingController _courseIdController = TextEditingController();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _creditsController = TextEditingController();
  final TextEditingController _instructorController = TextEditingController();
  bool _isCreditsInvalid = false;

  void _addCourse() {
    int? credits = int.tryParse(_creditsController.text);

    if (credits == null) {
      setState(() {
        _isCreditsInvalid = true;
      });
    } else {
      setState(() {
        _isCreditsInvalid = false;
        widget.api
            .addCourse(_instructorController.text, credits,
                _courseIdController.text, _courseNameController.text)
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
            controller: _courseIdController,
          ),
          const Text("Course name:"),
          TextFormField(controller: _courseNameController),
          const Text("credits"),
          TextFormField(
            controller: _creditsController,
            keyboardType: TextInputType.number,
          ),
          const Text("Instructor name:"),
          TextFormField(controller: _instructorController),
          ElevatedButton(onPressed: _addCourse, child: const Text("Add"))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toHomePage,
        child: const Icon(Icons.home),
      ),
    );
  }
}
