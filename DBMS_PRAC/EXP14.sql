/*
Problem statements 14
1.	Design and implement a MongoDB MapReduce operation to analyze grocery sales data.
•	A grocery store maintains a collection named grocery_sales that stores daily sales records of various products such as fruits and vegetables. Each document in the collection contains details like the product name, category (Fruit or Vegetable), and quantity sold.
•	Using the MapReduce feature of MongoDB, write a program to calculate the total quantity sold for each product. The output should display each product name along with its total quantity sold across all records.


*/

// Use/Create Database
use groceryDB;

// Sample Data for grocery_sales collection
db.grocery_sales.insertMany([
  { product: "Apple", category: "Fruit", quantity: 10 },
  { product: "Banana", category: "Fruit", quantity: 15 },
  { product: "Apple", category: "Fruit", quantity: 8 },
  { product: "Potato", category: "Vegetable", quantity: 20 },
  { product: "Tomato", category: "Vegetable", quantity: 12 },
  { product: "Banana", category: "Fruit", quantity: 5 },
  { product: "Tomato", category: "Vegetable", quantity: 18 }
]);

// ------------------ MapReduce Operation ------------------

// Map Function → Emits product name and its quantity
var mapFunction = function () {
  emit(this.product, this.quantity);
};

// Reduce Function → Sums quantities of same product
var reduceFunction = function (key, values) {
  return Array.sum(values);
};

// Execute MapReduce
db.grocery_sales.mapReduce(
  mapFunction,
  reduceFunction,
  { out: "product_totals" } // Output Collection
);

// View Results
db.product_totals.find().pretty();