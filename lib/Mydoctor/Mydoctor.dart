import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xfinitive/Mydoctor/doctor.dart';
import 'package:xfinitive/Mydoctor/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: camel_case_types
class DoctorScreen__ extends StatefulWidget {
  const DoctorScreen__({super.key});

  @override
  State<DoctorScreen__> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen__> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _doctormobilenumber = TextEditingController();
  final TextEditingController _hospitalname = TextEditingController();
  final TextEditingController _doctortype = TextEditingController();
  late DatabaseService _databaseService;
  @override
  void initState() {
    super.initState();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    _databaseService = DatabaseService(userId!);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: _displayTextInputDialog,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: const Text(
        "My Doctors",
        style: TextStyle( fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [Container(height:200,width: 200,child:  Image.asset('assets/images/Lifesavers Online.png')),
            _messagesListView(),
          ],
        ),
      ),
    );
  }

  Widget _messagesListView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.80,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: _databaseService.getTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          List todos = snapshot.data?.docs ?? [];
          if (todos.isEmpty) {
            return const Center(
              child: Text("My Doctors"),
            );
          }
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              Todo2 todo = todos[index].data();
              String todoId = todos[index].id;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade300, // Replace with your desired RGB values
            Colors.green.shade400, // Replace with your desired RGB values
          ],
        ),
      ),
                  child: ListTile(
                    tileColor: Theme.of(context).colorScheme.primaryContainer,
                    title: Text(todo.fullName ?? "No name",style: Theme.of(context).textTheme.titleMedium,),
                    subtitle: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           
                            Row(children: [
                           
                              Text(todo.doctortype ?? "Enter doctor type",style: Theme.of(context).textTheme.titleSmall),
                            ]),
                            Row(children: [
                              
                              Text(todo.hospitalname ?? "no Hospital name entered",style: Theme.of(context).textTheme.titleSmall,),
                            ]),
                          ]),
                    ),
                  
                    // subtitle: Text("Height: ${todo.height?.toString() ?? 'N/A'}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _databaseService.deleteTodo(todoId),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _displayTextInputDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Doctors'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(hintText: "Full Name"),
                ),
                TextField(
                  controller: _countryController,
                  decoration: const InputDecoration(hintText: "Country"),
                ),
                TextField(
                  controller: _cityController,
                  decoration: const InputDecoration(hintText: "City"),
                ),
                TextField(
                  controller: _stateController,
                  decoration: const InputDecoration(hintText: "State"),
                ),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(hintText: "Address"),
                ),
                TextField(
                  controller: _zipController,
                  decoration:
                      const InputDecoration(hintText: "ZIP/Postal Code"),
                ),
                TextField(
                  controller: _doctortype,
                  decoration:
                      const InputDecoration(hintText: "Doctor's Speciality "),
                ),
                TextField(
                  controller: _doctormobilenumber,
                  decoration:
                      const InputDecoration(hintText: "Doctor's Mobile Number"),
                ),
                TextField(
                  controller: _hospitalname,
                  decoration: const InputDecoration(hintText: "Hospital Name"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              color: Theme.of(context).colorScheme.primary,
              textColor: Colors.white,
              child: const Text('Add'),
              onPressed: () {
                Todo2 todo = Todo2(
                  fullName: _fullNameController.text,
                  country: _countryController.text,
                  city: _cityController.text,
                  state: _stateController.text,
                  address: _addressController.text,
                  doctormobilenumber: int.tryParse(_doctormobilenumber.text),
                  doctortype: _doctortype.text,
                  zip: int.tryParse(_zipController.text),
                   hospitalname: _hospitalname.text,

                );
                _databaseService.addTodo(todo);
                Navigator.pop(context);
                _clearAllControllers();
              },
            ),
          ],
        );
      },
    );
  }

  void _clearAllControllers() {
    _fullNameController.clear();
    _countryController.clear();
    _cityController.clear();
    _stateController.clear();
    _addressController.clear();
    _zipController.clear();
    _doctormobilenumber.clear();
    _hospitalname.clear();
    _doctortype.clear();
  }
}
