import mysql.connector

# Connect to MySQL
mydb = mysql.connector.connect(
    host="localhost",
    user="jack",
    password="Strong@password",
    database="con"
)
mycursor = mydb.cursor()

# Ask user what they want to do
print("What do you want to do?")
print("1. Insert")
print("2. Update")
print("3. Delete")
choice = input("Enter choice (1/2/3): ")

if choice == "1":
    # INSERT
    name = input("Type a name: ")
    address = input("Type an address: ")

    sql = "INSERT INTO employee (name, address) VALUES (%s, %s)"
    val = (name, address)

    mycursor.execute(sql, val)
    mydb.commit()

    print(mycursor.rowcount, "record inserted.")

elif choice == "2":
    # UPDATE
    name = input("Enter the name of the employee to update: ")
    new_address = input("Enter the new address: ")

    sql = "UPDATE employee SET address = %s WHERE name = %s"
    val = (new_address, name)

    mycursor.execute(sql, val)
    mydb.commit()

    print(mycursor.rowcount, "record updated.")

elif choice=="3":
#DELETE
    name = input("Enter the name of the employee to delete: ")

    sql = "DELETE FROM employee WHERE name = %s"
    val = (name,)

    mycursor.execute(sql, val)
    mydb.commit()

    print(mycursor.rowcount, "record deleted.")

else:
    print("Invalid choice. Please enter 1, 2, or 3.")

# Clean up
mycursor.close()
mydb.close()

