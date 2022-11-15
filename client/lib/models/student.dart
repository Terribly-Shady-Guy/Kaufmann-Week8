class Student {
  final String id;
  final String fname;
  final String lname;
  final int studentID;

  Student._(this.id, this.fname, this.lname, this.studentID);

  factory Student.fromJson(Map json) {
    final id = json[''].replaceAll('ObjectId(\"', '').replaceAll('\")', '');
    final fname = json['fname'];
    final lname = json['lname'];
    final studentID = json['studentID'];

    return Student._(id, fname, lname, studentID);
  }
}
