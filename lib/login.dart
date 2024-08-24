// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:masjid_app/main.dart';
import 'signup.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final now = new DateTime.now();
  final todayInDays = now.difference(new DateTime(now.year,1,1,0,0)).inDays;
  print("todayInDays = $todayInDays");
  runApp( MyApp());
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green, // Set header color to green
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Login Page'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://w7.pngwing.com/pngs/238/167/png-transparent-moon-and-stars-star-five-pointed-star-star-decoration-thumbnail.png', // URL to your logo image
                  width: 100.0,
                  height: 100.0,
                ),
                const SizedBox(height: 20.0),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Set button color to green
                  ),
                  child: Text('Login'),
                  onPressed: () {
   
                  },
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Don\'t have an account? Sign up',
                    style: TextStyle(
                      color: Color.fromARGB(255, 7, 7, 7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
