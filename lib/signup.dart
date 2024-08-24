// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SignupPage());
}

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _mobilenumberController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  String _selectedMohalla = 'Select mohalla'; // Set a default value
  // Replace with actual data from the database
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _mohallaList = []; // Initialize the list

  @override
  void initState() {
    super.initState();
    // Call readData to initialize _mohallaList
    readData();
  }

  readData() {
    print("inside read data");
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("Mohalla");

    collectionReference.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("data = ${doc.data()}");
        setState(() {
          _mohallaList.add(doc.id); // Add document ID to the list
        });
      });
    });
  }

  @override
  void dispose() {
    _mobilenumberController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Validate the form
    if (_passwordController.text != _confirmPasswordController.text) {
      // Passwords do not match, show an alert
      _showPasswordMismatchAlert();
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, continue with form submission
      print('Mobile Number: ${_mobilenumberController.text}');
      print('Username: ${_usernameController.text}');
      print('Password: ${_passwordController.text}');
      print('Mohalla: $_selectedMohalla');
    }
  }

  void _showPasswordMismatchAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Password Mismatch'),
          content: Text('The entered passwords do not match. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _mobilenumberController,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Mobile Number is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Confirm Password is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  value: _selectedMohalla,
                  onChanged: (value) {
                    setState(() {
                      _selectedMohalla = value.toString();
                    });
                  },
                  items: _mohallaList.map((mohalla) {
                    return DropdownMenuItem(
                      value: mohalla,
                      child: Text(mohalla),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Mohalla',
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
