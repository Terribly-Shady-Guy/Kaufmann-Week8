import 'package:dio/dio.dart';
import './models/course.dart';
import './models/student.dart';

class ClientApi {
  static const String _apiUrl = "http://localhost:1200/";
  final _dio = Dio(BaseOptions(baseUrl: _apiUrl));

  Future<List> getAllStudents() async {
    final response = await _dio.get('/getallstudents');
    return response.data['students'];
  }

  Future<List> getAllCourses() async {
    final response = await _dio.get("/getallcourses");
    return response.data['courses'];
  }

  Future findStudent(String id) async {
    final response =
        await _dio.get('/findstudent', queryParameters: {'id': id});

    return response.data['student'];
  }

  Future<List> findCourse(String courseInstructor) async {
    final response = await _dio.get('/findcourse',
        queryParameters: {'courseInstructor': courseInstructor});

    return response.data['course'];
  }

  Future addCourse(
      String instructor, int credits, String courseID, String name) async {
    await _dio.post('addcourse', data: {
      'courseInstructor': instructor,
      'courseCredits': credits,
      'courseID': courseID,
      'courseName': name
    });
  }

  Future addStudent(String fname, String lname, int studentID) async {
    await _dio.post('/addstudent',
        data: {'fname': fname, 'lname': lname, 'studentID': studentID});
  }

  Future editStudentById(String id) async {
    final response = await _dio.put('/editstudentbyid', data: {'id': id});
  }

  Future editStudentByFname(
      String queryFname, String fname, String lname) async {
    final response = await _dio.put('/editstudentbyfname',
        data: {'queryFname': queryFname, 'fname': fname, 'lname': lname});
  }

  Future editCourseByCourseName(
      String courseName, String courseInstructor) async {
    final response = await _dio.put('/editcoursebycoursename',
        data: {'courseName': courseName, 'courseInstructor': courseInstructor});
  }

  Future deleteCourseById(String id) async {
    final response = await _dio.delete('/deletecoursebyid', data: {'id': id});
  }

  Future removeStudentFromClasses(int studentID) async {
    final response = await _dio
        .delete('/removestudentfromclasses', data: {'studentID': studentID});
  }
}
