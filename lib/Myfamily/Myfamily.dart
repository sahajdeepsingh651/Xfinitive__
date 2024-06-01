
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xfinitive/Myfamily/todo.dart';
import 'package:xfinitive/Myfamily/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FamilyScreen extends StatefulWidget {
  const FamilyScreen({super.key});

  @override
  State<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();
  final TextEditingController _mobilePhoneController =
      TextEditingController(); // Handles String, convert to/from int
  final TextEditingController _dobController =
      TextEditingController(); // Uncomment if date of birth field is re-enabled
  final TextEditingController _maritalStatusController =
      TextEditingController();
  final TextEditingController _heightController =
      TextEditingController(); // Handles String, convert to/from int
  final TextEditingController _weightController =
      TextEditingController(); // Handles String, convert to/from int
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _zipController =
      TextEditingController(); // Handles String, convert to/from int
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

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
        "My family",
        style: TextStyle(fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildUI() {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [Container(height :200,width:200,child: Image.asset('assets/images/Family Values Healthy Family.png')),
          _messagesListView(),
        ],
      ),
    ));
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
              child: Text("My family"),
            );
          }
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              Todo todo = todos[index].data();
              String todoId = todos[index].id;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    
                    
                    
                    
                    child:Container( decoration: BoxDecoration(
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
                                        title: Text(todo.yourRelationToThePerson ?? "No name",style: Theme.of(context).textTheme.titleMedium,),
                                        subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      
                                         
                                         Text( todo.fullName?? "",style: Theme.of(context).textTheme.titleMedium,),
                      Row(children: [
                        
                        Text(todo.age?.toString() ?? "",style: Theme.of(context).textTheme.titleMedium,)])
                                        ]),
                      
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
    return showDialog(
      context: context,
      builder: (context) {


        return AlertDialog(
          title: const Text('Add a family member'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(hintText: "Full Name"),
                ),

                TextField(
                  controller: _relationController,
                  decoration: const InputDecoration(
                      hintText: "Your Relation to the Person"),
                ),

                TextField(
                  controller: _mobilePhoneController,
                  decoration: const InputDecoration(hintText: "Mobile Phone"),
                ),

                TextField(
                  controller: _dobController,
                  decoration: const InputDecoration(hintText: "Date of Birth"),
                  // Consider using a DatePicker for dob input
                ),

                TextField(
                  controller: _maritalStatusController,
                  decoration: const InputDecoration(hintText: "Marital Status"),
                ),

                TextField(
                  controller: _heightController,
                  decoration: const InputDecoration(hintText: "Height"),
                ),

                TextField(
                  controller: _weightController,
                  decoration: const InputDecoration(hintText: "Weight"),
                ),

                TextField(
                  controller: _nationalityController,
                  decoration: const InputDecoration(hintText: "Nationality"),
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
                  controller: _address1Controller,
                  decoration: const InputDecoration(hintText: "Address Line 1"),
                ),

                TextField(
                  controller: _address2Controller,
                  decoration: const InputDecoration(hintText: "Address Line 2"),
                ),

                TextField(
                  controller: _zipController,
                  decoration:
                      const InputDecoration(hintText: "ZIP/Postal Code"),
                ),

                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: "Email"),
                ),

                TextField(
                  controller: _ageController,
                  decoration: const InputDecoration(hintText: "Age"),
                ),

                // Additional TextField implementations as per other properties...
              ],
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              color: Theme.of(context).colorScheme.primary,
              textColor: Colors.white,
              child: const Text('Add'),
              onPressed: () {
                Todo todo = Todo(
                  fullName: _fullNameController.text,
                  yourRelationToThePerson: _relationController.text,
                  mobilePhone: int.tryParse(_mobilePhoneController.text),
                  dob: _dobController.text,
                  maritalStatus: _maritalStatusController.text,
                  height: int.tryParse(_heightController.text),
                  weight: int.tryParse(_weightController.text),
                  nationality: _nationalityController.text,
                  country: _countryController.text,
                  city: _cityController.text,
                  state: _stateController.text,
                  address1: _address1Controller.text,
                  address2: _address2Controller.text,
                  zip: int.tryParse(_zipController.text),
                  email: _emailController.text,
                  age: int.tryParse(_ageController.text),
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
    _relationController.clear();
    _mobilePhoneController.clear();
    _dobController.clear();
    _maritalStatusController.clear();
    _heightController.clear();
    _weightController.clear();
    _nationalityController.clear();
    _countryController.clear();
    _cityController.clear();
    _stateController.clear();
    _address1Controller.clear();
    _address2Controller.clear();
    _zipController.clear();
    _emailController.clear();
    _ageController.clear();
  }
}
// _mobilePhoneController.text = todo.mobilePhone?.toString() ?? '';
// _heightController.text = todo.height?.toString() ?? '';
// _weightController.text = todo.weight?.toString() ?? '';
// _zipController.text = todo.zip?.toString() ?? '';conversion handling


// When retrieving the value to update or create a Todo object, convert the string back to an integer:
//int? mobilePhone = int.tryParse(_mobilePhoneController.text);
// int? height = int.tryParse(_heightController.text);
// int? weight = int.tryParse(_weightController.text);
// int? zip = int.tryParse(_zipController.text);
