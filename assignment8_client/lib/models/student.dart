class Student {
  final String fname;
  final String lname;
  final int studentID;

  Student(this.fname, this.lname, this.studentID);

  factory Student.fromJson(Map json) {
    final fname = json['fname'];
    final lname = json['lname'];
    final studentID = json['studentID'];

    return Student(fname, lname, studentID);
  }
}
