import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';
import 'loginForm.dart';
import 'leagues.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _email;
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Color.fromARGB(255, 16, 21, 24),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 110.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person,
                      color: Color.fromARGB(255, 185, 175, 175)),
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20.0),
                      right: Radius.circular(20.0),
                    ),
                  ),
                  fillColor: Color.fromARGB(255, 67, 83, 94),
                  filled: true,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                  _username = value;
                  });
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email,
                      color: Color.fromARGB(255, 185, 175, 175)),
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20.0),
                      right: Radius.circular(20.0),
                    ),
                  ),
                  fillColor: Color.fromARGB(255, 67, 83, 94),
                  filled: true,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                  _email = value;
                  });
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.key,
                      color: Color.fromARGB(255, 185, 175, 175)),
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20.0),
                      right: Radius.circular(20.0),
                    ),
                  ),
                  fillColor: Color.fromARGB(255, 67, 83, 94),
                  filled: true,
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                  _password = value;
                  });
                },
              ),
              SizedBox(height: 10.0),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     labelText: 'Confirm Password',
              //     prefixIcon: Icon(Icons.key,
              //         color: Color.fromARGB(255, 185, 175, 175)),
              //     labelStyle: TextStyle(color: Colors.white),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.horizontal(
              //         left: Radius.circular(20.0),
              //         right: Radius.circular(20.0),
              //       ),
              //     ),
              //     fillColor: Color.fromARGB(255, 67, 83, 94),
              //     filled: true,
              //   ),
              //   obscureText: true,
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please confirm your password';
              //     }

              //     if (_password != null && value == _password) {
              //       return 'Passwords match';
              //     } else {
              //       print("PASSWORD: $_password");
              //       return 'Passwords do not match';
              //     }
              //   },
              //   onChanged: (value) {
              //     setState(() {
              //     _confirmPassword = value;
              //     });
              //   },
              // ),
              SizedBox(height: 40.0),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      GoRouter.of(context).go("/LoginFormPage");
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(20.0),
                        right: Radius.circular(20.0),
                      ),
                    ),
                  )),
              SizedBox(height: 30.0),
              TextButton(
                onPressed: () {
                  GoRouter.of(context).push("/LoginFormPage");
                },
                child: Text(
                  "Already have an account? Sign in",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
