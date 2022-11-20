import 'package:flutter/material.dart';
import './home_page.dart';
import '../client_api.dart';

class StudentFnamePage extends StatefulWidget {
  StudentFnamePage({super.key, required this.id});
  final String id;
  final ClientApi api = ClientApi();

  @override
  State<StudentFnamePage> createState() => _StudentFnamePageState();
}

class _StudentFnamePageState extends State<StudentFnamePage> {
  TextEditingController fnameController = TextEditingController();

  void _changeFname() {
    setState(() {
      widget.api
          .editStudentById(widget.id, fnameController.text)
          .then((value) => _toHome());
    });
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
        title: const Text("Change student first name"),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          const Text("First name:"),
          TextFormField(
            controller: fnameController,
          ),
          ElevatedButton(onPressed: _changeFname, child: const Text("Update"))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _toHome,
        child: const Icon(Icons.home),
      ),
    );
  }
}
