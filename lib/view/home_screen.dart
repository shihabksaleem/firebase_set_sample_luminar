import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final CollectionReference collection = FirebaseFirestore.instance.collection("employee");

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return collection
        .add({
          'name': nameController.text.trim(),
          'phone': int.parse(phoneController.text.trim()),
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateUser({required String id}) {
    return collection
        .doc(id)
        .update({
          'name': nameController.text.trim(),
          'phone': int.parse(phoneController.text.trim()),
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteUser({required String id}) {
    return collection
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(), label: Text("Name"), focusedBorder: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    label: Text("Phone number"),
                    focusedBorder: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  addUser();
                },
                child: const Text("send"),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: collection.orderBy("name").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data?.docs.length ?? 0,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot employeeSnap = snapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.grey.shade300,
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      employeeSnap['name'],
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      employeeSnap['phone'].toString(),
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        updateUser(id: employeeSnap.id);
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        deleteUser(id: employeeSnap.id);
                                      },
                                      icon: Icon(Icons.delete),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    return Container();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
