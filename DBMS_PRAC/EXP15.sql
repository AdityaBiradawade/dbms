/*
Problem statements 15

Database Connectivity: 
Write a program to implement MongoDB database connectivity with any front end language to implement Database navigation operations (add, delete, edit etc.) 

*/


pip install pymongo


from pymongo import MongoClient

# Step 1: Database Connection
client = MongoClient("mongodb://localhost:27017/")  # Default MongoDB localhost
db = client["CollegeDB"]  # Database Name
collection = db["Students"]  # Collection Name

# Step 2: Display Menu
def menu():
    print("\n----- MongoDB CRUD Operations -----")
    print("1. Add Record")
    print("2. Display All Records")
    print("3. Update/Edit Record")
    print("4. Delete Record")
    print("5. Exit")

# Step 3: Add Record
def add_record():
    roll = int(input("Enter Roll Number: "))
    name = input("Enter Student Name: ")
    dept = input("Enter Department: ")
    record = {"Roll_No": roll, "Name": name, "Department": dept}
    collection.insert_one(record)
    print("✅ Record Inserted Successfully")

# Step 4: Display All Records
def display_records():
    print("\n---- All Records ----")
    for student in collection.find():
        print(student)

# Step 5: Update/Edit Record
def update_record():
    roll = int(input("Enter Roll Number to Update: "))
    new_name = input("Enter New Name: ")
    new_dept = input("Enter New Department: ")
    collection.update_one({"Roll_No": roll}, {"$set": {"Name": new_name, "Department": new_dept}})
    print("✅ Record Updated Successfully")

# Step 6: Delete Record
def delete_record():
    roll = int(input("Enter Roll Number to Delete: "))
    collection.delete_one({"Roll_No": roll})
    print("✅ Record Deleted Successfully")

# Main Program Loop
while True:
    menu()
    choice = int(input("Enter Your Choice: "))

    if choice == 1:
        add_record()
    elif choice == 2:
        display_records()
    elif choice == 3:
        update_record()
    elif choice == 4:
        delete_record()
    elif choice == 5:
        print("Exiting Program... Goodbye!")
        break
    else:
        print("❌ Invalid Choice! Please Enter Again.")



/*

*/