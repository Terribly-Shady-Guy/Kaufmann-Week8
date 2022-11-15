class Course {
  final String courseInstructor;
  final int courseCredits;
  final String courseID;
  final String courseName;

  Course(this.courseInstructor, this.courseCredits, this.courseID,
      this.courseName);

  factory Course.fromJson(Map json) {
    final courseInstructor = json['courseInstructor'];
    final courseCredits = json['courseCredits'];
    final courseID = json['courseID'];
    final courseName = json['courseName'];

    return Course(courseInstructor, courseCredits, courseID, courseName);
  }
}
