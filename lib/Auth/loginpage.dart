import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phd/Auth/ForgetPassword.dart';
import 'package:phd/a%20Main%20Pages/Home.dart';

import 'Register.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailid = TextEditingController();
  TextEditingController _enterpass = TextEditingController();
  bool isLoading = false;
  void performLogin() {
    // Simulating login process
    setState(() {
      isLoading = true;
    });

    // Simulating delay for login
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        isLoading = false;
      });

      // Navigate to the main screen after successful login
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  Widget build(BuildContext contex) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      // appBar: AppBar(
      //   title: Text('Log In'),
      //   backgroundColor: Colors.grey[900],
      // ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Icon(
                  Icons.lock,
                  color: Colors.grey[900],
                  size: 100,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Hope you didn\'t face any serious problem!! ',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                            controller: _emailid,
                            decoration: InputDecoration(
                              hintText: 'Enter your gmail',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                            validator: (value) {
                              if (value!.contains('@gmail.com')) {
                                return null;
                              }
                              return 'Please enter a valid Gmail!';
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: TextFormField(
                            controller: _enterpass,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                            obscureText: true,
                            validator: (input) {
                              if (input!.length < 6) {
                                return 'Your password needs to be at least 6 character';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Register()));
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueAccent,
                              decoration:
                                  TextDecoration.underline, // Add underline
                            ),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgetPassword()));
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.redAccent,
                              decoration:
                                  TextDecoration.underline, // Add underline
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[900],
                        minimumSize: Size(310, 62),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => isLoading = true);
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailid.text.trim(),
                                  password: _enterpass.text.trim());
                        } catch (e) {
                          setState(() => isLoading = false);
                          var snackDemo = SnackBar(
                            duration: const Duration(seconds: 2),
                            content: Text(e.toString()),
                            backgroundColor: Colors.blue,
                            elevation: 15,
                            behavior: SnackBarBehavior.floating,
                            padding: const EdgeInsets.all(20),
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            margin: const EdgeInsets.all(20),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackDemo);
                          return;
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ));
                      }
                    },
                    child: const Text('Sign In',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
                SizedBox(height: 50),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(children: [
                      Expanded(
                          child:
                              Divider(thickness: 0.5, color: Colors.grey[500])),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text('or continue with',
                              style: TextStyle(color: Colors.grey[700]))),
                      Expanded(
                          child:
                              Divider(thickness: 0.5, color: Colors.grey[500]))
                    ])),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[300],
                      ),
                      child: Image.asset(
                        'assets/google.png',
                        height: 40,
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[300],
                      ),
                      child: Image.asset(
                        'assets/apple.png',
                        height: 40,
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[300],
                      ),
                      child: Image.asset(
                        'assets/face.png',
                        height: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
