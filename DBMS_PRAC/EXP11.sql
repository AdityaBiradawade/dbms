/*
Problem Statement 11
 Create Database ICEM
Create following MongoDB Collections
Teachers (Tname,dno,dname,experience,salary,date_of_joining )
Students(Sname,roll_no,class)
Q1. Find the information about all teachers
Q2. Find the information about all teachers of computer department
Q3. Find the information about all teachers of computer,IT,and e&TC department
Q4. Find the information about all teachers of computer,IT,and E&TC department having salary            greater than or equl to 10000/-
Q5. Find the student information having roll_no = 2 or Sname=xyz
Q6. Update the experience of teacher-praveen to 10years, if the entry is not available in database
     consider the entry as new entry.
*/

// Use / Create Database
// Use / Create Database
use ICEM;

// Create & Insert Data into Teachers Collection
db.Teachers.insertMany([
  { Tname: "Praveen", dno: 1, dname: "Computer", experience: 5, salary: 12000, date_of_joining: "2018-06-10" },
  { Tname: "Neha", dno: 2, dname: "IT", experience: 7, salary: 15000, date_of_joining: "2016-01-05" },
  { Tname: "Anil", dno: 3, dname: "E&TC", experience: 4, salary: 9000, date_of_joining: "2019-04-15" },
  { Tname: "Sneha", dno: 1, dname: "Computer", experience: 3, salary: 10000, date_of_joining: "2020-08-01" }
]);

// Create & Insert Data into Students Collection
db.Students.insertMany([
  { Sname: "Rahul", roll_no: 1, class: "FY" },
  { Sname: "Priya", roll_no: 2, class: "SY" },
  { Sname: "XYZ", roll_no: 3, class: "TY" }
]);

// ---------------------- QUERIES ----------------------

// Q1. Find the information about all teachers
db.Teachers.find();

// Q2. Find the information about all teachers of Computer department
db.Teachers.find({ dname: "Computer" });

// Q3. Find all teachers of Computer, IT, and E&TC department
db.Teachers.find({ dname: { $in: ["Computer", "IT", "E&TC"] } });

// Q4. Find teachers from Computer, IT, and E&TC with salary >= 10000
db.Teachers.find({
  dname: { $in: ["Computer", "IT", "E&TC"] },
  salary: { $gte: 10000 }
});

// Q5. Find student with roll_no = 2 or Sname = "xyz"
db.Students.find({
  $or: [
    { roll_no: 2 },
    { Sname: { $regex: /^xyz$/i } }
  ]
});

// Q6. Update experience of teacher "Praveen" to 10 years (upsert)
db.Teachers.updateOne(
  { Tname: "Praveen" },
  {
    $set: {
      Tname: "Praveen",
      experience: 10,
      dname: "Computer",
      dno: 1,
      salary: 12000,
      date_of_joining: "2018-06-10"
    }
  },
  { upsert: true }
);

// Q7. Update the department of all teachers working in IT department to COMP
db.Teachers.updateMany(
  { dname: "IT" },
  { $set: { dname: "COMP" } }
);

// Q8. Show only teacher name and experience (like select Tname, experience)
db.Teachers.find(
  {},
  { _id: 0, Tname: 1, experience: 1 }
);

// Q9. Insert one record into Department collection using save()
db.Department.save({
  _id: 1,
  dname: "Computer",
  dno: 01,
  location: "Building A"
});