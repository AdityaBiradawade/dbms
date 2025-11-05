from pymongo import MongoClient

# Connect to local MongoDB (no username/password)
collection = MongoClient().library.employee  # default localhost:27017

# Menu
choice = input("Choose: 1=Insert, 2=Update, 3=Delete: ")

if choice == "1":
    name = input("Name: ")
    address = input("Address: ")
    result = collection.insert_one({"name": name, "address": address})
    print("Inserted record ID:", result.inserted_id)

elif choice == "2":
    name = input("Name to update: ")
    new_address = input("New address: ")
    result = collection.update_one({"name": name}, {"$set": {"address": new_address}})
    print("Records updated:", result.modified_count)

elif choice == "3":
    name = input("Name to delete: ")
    result = collection.delete_one({"name": name})
    print("Records deleted:", result.deleted_count)

else:
    print("Invalid choice!")
