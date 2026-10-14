// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SignupPage());
}

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _mobilenumberController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String? _selectedMohalla;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _mohallaList = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  void readData() {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("Mohalla");

      collectionReference.get().then((querySnapshot) {
        if (!mounted) return;
        setState(() {
          _mohallaList.clear();
          for (var doc in querySnapshot.docs) {
            _mohallaList.add(doc.id);
          }
        });
      }).catchError((error) {
        debugPrint('Error fetching Mohalla list: $error');
      });
    } catch (e) {
      debugPrint('Firestore access error: $e');
    }
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
    if (_passwordController.text != _confirmPasswordController.text) {
      _showPasswordMismatchAlert();
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      debugPrint('Mobile Number: ${_mobilenumberController.text}');
      debugPrint('Username: ${_usernameController.text}');
      debugPrint('Mohalla: $_selectedMohalla');
    }
  }

  void _showPasswordMismatchAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password Mismatch'),
          content: const Text('The entered passwords do not match. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
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
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _mobilenumberController,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Mobile Number is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
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
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
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
                const SizedBox(height: 20.0),
                DropdownButtonFormField<String>(
                  initialValue: _selectedMohalla,
                  hint: const Text('Select mohalla'),
                  onChanged: (value) {
                    setState(() {
                      _selectedMohalla = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a mohalla';
                    }
                    return null;
                  },
                  items: _mohallaList.map((mohalla) {
                    return DropdownMenuItem<String>(
                      value: mohalla,
                      child: Text(mohalla),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Mohalla',
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
