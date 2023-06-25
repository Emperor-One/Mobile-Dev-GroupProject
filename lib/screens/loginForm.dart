import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import 'Registration.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fantasy Football App'),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Color.fromARGB(255, 16, 21, 24),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 50.0),
                  Image.asset(
                    'images/soccer_strategist.png',
                    height: 100.0,
                    alignment: Alignment.center,
                  ),
                  SizedBox(height: 150.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email,
                                color: Color.fromARGB(255, 185, 175, 175)),
                            labelText: 'Email',
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
                            _email = value;
                          },
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock,
                                color: Color.fromARGB(255, 185, 175, 175)),
                            labelText: 'Password',
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
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _password = value;
                          },
                        ),
                        SizedBox(height: 50.0),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                GoRouter.of(context).push("/nextPage");
                              }
                            },
                            child: Text(
                              'Sign In',
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
                        SizedBox(height: 10.0),
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context).push("/registrationPage");
                          },
                          child: Text(
                            "Don't have an account? Sign up",
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
                  )
                ])));
  }
}
