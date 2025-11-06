/*
Problem statement 12. 
Consider each document in the zipcode collection has the following form:
{
"_id": "10280",
"city": "NEW YORK",
"state": "NY",
"pop": 5574,
}
1. Return States with Populations above 1 Lakh.
2. Display the department wise average salary
3. Display the no. Of employees working in each department
4. Display the department wise total salary of departments having total salary greater than or equals   to 50000/-
5. Write the queries using the different operators like max, min. Etc.
6. Create the simple index on roll_no field
7. create unique index on any field for above given collections
8. create compound index on any fields for above given collections
9. Show all the indexes created in the database 
10. Show all the indexes created in above collections.



*/

// Use / Create Database
use ICEM;

// Sample zipcode collection data
db.zipcode.insertMany([
  { _id: "10280", city: "NEW YORK", state: "NY", pop: 5574 },
  { _id: "56001", city: "MUMBAI", state: "MH", pop: 150000 },
  { _id: "11001", city: "DELHI", state: "DL", pop: 250000 },
  { _id: "40001", city: "PUNE", state: "MH", pop: 98000 }
]);

// Sample Employees collection for department-related queries
db.employees.insertMany([
  { name: "Amit", department: "IT", salary: 30000 },
  { name: "Neha", department: "IT", salary: 35000 },
  { name: "Rohan", department: "HR", salary: 20000 },
  { name: "Sneha", department: "HR", salary: 25000 },
  { name: "Varun", department: "Sales", salary: 40000 },
  { name: "Kiran", department: "Sales", salary: 15000 }
]);

// 1️⃣ Return States with Populations above 1 Lakh
db.zipcode.aggregate([
  { $match: { pop: { $gt: 100000 } } },
  { $group: { _id: "$state", totalPopulation: { $sum: "$pop" } } }
]);

// 2️⃣ Display department-wise average salary
db.employees.aggregate([
  { $group: { _id: "$department", avgSalary: { $avg: "$salary" } } }
]);

// 3️⃣ Display the number of employees working in each department
db.employees.aggregate([
  { $group: { _id: "$department", employeeCount: { $sum: 1 } } }
]);

// 4️⃣ Department-wise total salary where total salary >= 50000
db.employees.aggregate([
  { $group: { _id: "$department", totalSalary: { $sum: "$salary" } } },
  { $match: { totalSalary: { $gte: 50000 } } }
]);

// 5️⃣ Queries using max, min, etc.
// 5A. Maximum salary in employees
db.employees.aggregate([{ $group: { _id: null, maxSalary: { $max: "$salary" } } }]);
// 5B. Minimum salary in employees
db.employees.aggregate([{ $group: { _id: null, minSalary: { $min: "$salary" } } }]);
// 5C. Total population per state
db.zipcode.aggregate([{ $group: { _id: "$state", totalPop: { $sum: "$pop" } } }]);

// 6️⃣ Create a simple index on roll_no field in Students collection
db.Students.createIndex({ roll_no: 1 });  // 1 means ascending order

// 7️⃣ Create unique index on any field (example: employee name must be unique)
db.employees.createIndex({ name: 1 }, { unique: true });

// 8️⃣ Create compound index (example: on department + salary)
db.employees.createIndex({ department: 1, salary: -1 });

// 9️⃣ Show all indexes in the entire database (for each collection)
db.getCollectionNames().forEach(function(collName) {
  print("\nCollection: " + collName);
  printjson(db.getCollection(collName).getIndexes());
});

// 🔟 Show indexes only for specific collections
// Indexes for zipcode
db.zipcode.getIndexes();

// Indexes for employees
db.employees.getIndexes();

// Indexes for Students
db.Students.getIndexes();