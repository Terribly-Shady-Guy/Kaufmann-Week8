import 'package:dio/dio.dart';
import './models/course.dart';
import './models/student.dart';

class ClientApi {
  //used this as using http://localhost:1200 would cause a socketexception in android emulator
  static const String _apiUrl = "http://10.0.2.2:1200";
  final _dio = Dio(BaseOptions(baseUrl: _apiUrl));

  Future<List> getAllStudents() async {
    final response = await _dio.get('/getAllStudents');
    return response.data['students'];
  }

  Future<List> getAllCourses() async {
    final response = await _dio.get("/getAllCourses");
    return response.data['courses'];
  }

  Future findStudent(String id) async {
    final response =
        await _dio.get('/findStudent', queryParameters: {'id': id});

    return response.data['student'];
  }

  Future<List> findCourse(String courseInstructor) async {
    final response = await _dio.get('/findCourse',
        queryParameters: {'courseInstructor': courseInstructor});

    return response.data['course'];
  }

  Future addCourse(
      String instructor, int credits, String courseID, String name) async {
    await _dio.post('/addCourse', data: {
      'courseInstructor': instructor,
      'courseCredits': credits,
      'courseID': courseID,
      'courseName': name
    });
  }

  Future addStudent(String fname, String lname, int studentID) async {
    await _dio.post('/addStudent',
        data: {'fname': fname, 'lname': lname, 'studentID': studentID});
  }

  Future editStudentById(String id, String fname) async {
    final response =
        await _dio.put('/editStudentById', data: {'id': id, 'fname': fname});
  }

  Future editStudentByFname(
      String queryFname, String fname, String lname) async {
    final response = await _dio.put('/editStudentByFname',
        data: {'queryFname': queryFname, 'fname': fname, 'lname': lname});
  }

  Future editCourseByCourseName(
      String courseName, String courseInstructor) async {
    final response = await _dio.put('/editCourseByCourseName',
        data: {'courseName': courseName, 'courseInstructor': courseInstructor});
  }

  Future deleteCourseById(String id) async {
    final response = await _dio.delete('/deleteCourseById', data: {'id': id});
  }

  Future removeStudentFromClasses(int studentID) async {
    final response = await _dio
        .delete('/removeStudentFromClasses', data: {'studentID': studentID});
  }
}
