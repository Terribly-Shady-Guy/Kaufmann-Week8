const express = require("express");
const app = express();
const PORT = 1200;
app.use(express.json());

const nodemon = require("nodemon");

const mongoose = require("mongoose");
const e = require("express");

const connectionString = "mongodb+srv://admin:db1212@kaufmannweek12.niqst3i.mongodb.net/?retryWrites=true&w=majority";
mongoose.connect(connectionString, {
    useNewUrlParser: true,
    useUnifiedTopology: true
});

const db = mongoose.connection;

db.on("error", () => console.error.bind(console, "db connection error"));
db.once("open", () => console.log("connected to database successfully"));


//put code to get db schema here
require("./Models/students.js");
const Student = mongoose.model("Student");

require("./Models/courses.js");
const Course = mongoose.model("Course");

app.listen(PORT, () => console.log(`server started on http://localhost:${PORT}`));

app.get(`/getAllCourses`, async (req, res) => {
    try {
        let courses = await Course.find({}).lean()
        return res.status(200).json({"courses": courses});
    }
    catch (e){
        return res.status(500).json({message: "Could not get all courses", reason: e.message});
    }
});

app.get(`/getAllStudents`, async (req, res) => {
    try {
        let students = await Student.find({}).lean()
        return res.status(200).json({"students": students});
    }
    catch (e) {
        return res.status(500).json({message: "Could not get all students", reason: e.message});
    }
});

app.get(`/findStudent`, async (req, res) => {
    try {
        let student = await Student.findOne({studentID: req.body.studentID})

        if (student) {
            return res.status(200).json({student: student});
            
        } 
        else {
            return res.status(200).json({message: "Student not Found..."})            
        }
    }
    catch (e) {
        return res.status(500).json({message: "Connection ERROR...", reason: e.message})
    }
});

app.get(`/findCourse`, async (req, res) => {
    try {
        let course = await Course.find({courseInstructor: req.body.courseInstructor})

        if (course) {
            return res.status(200).json({"course": course});
            
        } 
        else {
            return res.status(200).json({message: "Course not Found..."})            
        }
    }
    catch (e) {
        return res.status(500).json({message: "Connection ERROR...", reason: e.message})
    }
});

app.post(`/addCourse`, async (req, res) => {
    try{
        let course = {
            courseInstructor: req.body.courseInstructor,
            courseCredits: req.body.courseCredits,
            courseID: req.body.courseID,
            courseName: req.body.courseName
        }

        await Course(course).save();
        return res.status(200).json({message: "Course Added..."});
    }
    catch (e) {
        if (e.name == "ValidationError") {
            return res.status(400).json({message: "Failed to add course", reason: e.message});
        }
        return res.status(500).json({message: "Something went wrong", reason: e.message});
    }
});

app.post(`/addStudent`, async (req, res) => {
    try{
        let student = {
            fname: req.body.fname,
            lname: req.body.lname,
            studentID: req.body.studentID
        }

        await Student(student).save();
        return res.status(200).json({message: "Student Added..."});
    }
    catch (e){
        if (e.name == "ValidationError") {
            return res.status(400).json({message: "Failed to add student", reason: e.message});
        }
        return res.status(500).json({message: "Something went wrong", reason: e.message});
    }
});

app.put("/editStudentById", async (req, res) => {
    try {
        let student = await Student.updateOne({_id: req.body.id}, {
            fname: req.body.fname
        });

        if (student) {
            return res.status(200).json({message: "Student first name updated"});
        }
        else {
            return res.status(200).json({message: "No change on student data"});
        }
    }
    catch (e) {
        return res.status(500).json({message: "failed to edit student", reason: e.message});
    }
});

app.put("/editStudentByFname", async (req, res) => {
    try {
        let student = await Student.updateOne({fname: req.body.queryFname}, {
            fname: req.body.fname, 
            lname: req.body.lname
        });
        
        if (student) {
            return res.status(200).json({message: "student name updated"});
        }
        else {
            return res.status(200).json({message: "student name was not updated"});
        }
    }
    catch (e) {
        return res.status(500).json({message: "failed to edit student", reason: e.message});
    }
});

app.put("/editCourseByCourseName", async (req, res) => {
    try {
        let course = await Course.updateOne({courseName: req.body.courseName}, {
            courseInstructor: req.body.courseInstructor
        });

        if (course) {
            return res.status(200).json({message: "course instructor updated"});
        }
        else {
            return res.status(200).json({message: "course instructor not updated"});
        }
    }
    catch (e) {
        return res.status(500).json({message: "failed to edit course", reason: e.message});
    }
});

app.delete("/deleteCourseById", async (req, res) => {
    try {
        let course = await Course.findOne({_id: req.body.id});

        if (course) {
            await Course.deleteOne({_id: req.body.id});
            return res.status(200).json({message: "course deleted"});
        }
        else {
            return res.status(200).json({message: "course does not exist"});
        }
    }
    catch (e) {
        return res.status(500).json({message: "failed to delete course", reason: e.message});
    }
});

app.delete("/removeStudentFromClasses", async (req, res) => {
    try {
        let student = await Student.findOne({studentID: req.body.studentID});

        if (student) {
            await Student.deleteOne({studentID: req.body.studentID});
            return res.status(200).json({message: "student deleted"});
        }
        else {
            return res.status(200).json({message: "student id does not exist"});
        }
    }
    catch (e) {
        return res.status(500).json({message: "failed to remove student", reason: e.message});
    }
});