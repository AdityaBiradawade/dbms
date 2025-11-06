/*
Problem statements 16
Design and develop MongoDB queries to analyze student performance data using aggregation and indexing.
The database should store student details such as name, department, marks, and city.
Perform the following:
•	Calculate average marks per department using aggregation.
•	Find the highest marks in each department. 
•	Find the sum of  marks in each department. 
•	Count the number of students from each city.
•	Calculate sum of  marks per department using aggregation arrange result in ascending order.
•	Create single and composite index on the department field to optimize queries


*/

// Use/Create Database
use studentDB;

// Sample Data Insertion
db.students.insertMany([
  { name: "Amit", department: "IT", marks: 85, city: "Pune" },
  { name: "Priya", department: "CS", marks: 78, city: "Mumbai" },
  { name: "Rohan", department: "IT", marks: 92, city: "Pune" },
  { name: "Sneha", department: "E&TC", marks: 88, city: "Nashik" },
  { name: "Kiran", department: "CS", marks: 95, city: "Pune" },
  { name: "Swati", department: "IT", marks: 76, city: "Mumbai" },
  { name: "Rahul", department: "E&TC", marks: 82, city: "Mumbai" }
]);

// 1. Calculate average marks per department
db.students.aggregate([
  { $group: { _id: "$department", avgMarks: { $avg: "$marks" } } }
]);

// 2. Find highest marks in each department
db.students.aggregate([
  { $group: { _id: "$department", highestMarks: { $max: "$marks" } } }
]);

// 3. Find total/sum of marks in each department
db.students.aggregate([
  { $group: { _id: "$department", totalMarks: { $sum: "$marks" } } }
]);

// 4. Count number of students from each city
db.students.aggregate([
  { $group: { _id: "$city", totalStudents: { $sum: 1 } } }
]);

// 5. Sum of marks per department and sort in ascending order
db.students.aggregate([
  { $group: { _id: "$department", totalMarks: { $sum: "$marks" } } },
  { $sort: { totalMarks: 1 } }
]);

// 6. Create Single Field Index on department
db.students.createIndex({ department: 1 });

// 7. Create Composite Index on department + city
db.students.createIndex({ department: 1, city: 1 });

// 8. Show all indexes created in students collection
db.students.getIndexes();