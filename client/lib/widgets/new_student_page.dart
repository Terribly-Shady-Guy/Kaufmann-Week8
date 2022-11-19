import 'package:flutter/material.dart';
import 'home_page.dart';
import '../client_api.dart';

class NewStudentPage extends StatefulWidget {
  NewStudentPage({super.key});

  final ClientApi api = ClientApi();

  @override
  State<NewStudentPage> createState() => _NewStudentPageState();
}

class _NewStudentPageState extends State<NewStudentPage> {
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _studentIDController = TextEditingController();

  bool _isStudentIDInvalid = false;

  void _addStudent() {
    int? studentID = int.tryParse(_studentIDController.text);

    if (studentID == null) {
      setState(() {
        _isStudentIDInvalid = true;
      });
    } else {
      setState(() {
        _isStudentIDInvalid = false;

        widget.api
            .addStudent(_fnameController.text, _lnameController.text, studentID)
            .then((value) => _toHome());
      });
    }
  }

  void _toHome() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new student"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Visibility(
            visible: _isStudentIDInvalid,
            child: const Text(
              "Student ID must be an int",
              style: TextStyle(color: Colors.red),
            ),
          ),
          const Text("Student ID:"),
          TextFormField(
            controller: _studentIDController,
          ),
          const Text("First Name:"),
          TextFormField(
            controller: _fnameController,
          ),
          const Text("Last name:"),
          TextFormField(
            controller: _lnameController,
          ),
          ElevatedButton(
              onPressed: _addStudent, child: const Text("Add Student"))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _toHome,
        child: const Icon(Icons.home),
      ),
    );
  }
}
