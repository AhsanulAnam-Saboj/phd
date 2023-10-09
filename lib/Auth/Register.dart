import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phd/a%20Main%20Pages/Home.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _username = TextEditingController();
  TextEditingController _emailId = TextEditingController();
  TextEditingController _enterpass = TextEditingController();
  TextEditingController _confirmpass = TextEditingController();
  bool passwordVisibility1 = true;
  bool passwordVisibility2 = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: const Text('Register New Account'), backgroundColor: Colors.grey[900]),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Icon(Icons.lock, color: Colors.grey[900], size: 100),
                  const SizedBox(height: 50),
                  Text('Hope you didn\'t face any serious problem!! ',
                      style: TextStyle(color: Colors.grey[700], fontSize: 16)),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: _username,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == '') {
                          return "Insert your name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: _emailId,
                      decoration: InputDecoration(
                        hintText: 'Enter your gmail',
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.contains('@gmail.com')) {
                          return null;
                        }
                        return 'Please enter a valid Gmail!';
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: _enterpass,
                      obscureText: passwordVisibility1,
                      decoration: InputDecoration(
                          hintText: 'Enter Password',
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() => passwordVisibility1 = !passwordVisibility1);
                            },
                            focusNode: FocusNode(skipTraversal: true),
                            child: Icon(passwordVisibility1 ? Icons.visibility : Icons.visibility_off,
                                color: Colors.black, size: 22),
                          )),
                      validator: (input) {
                        if (input!.length < 6) {
                          return 'Your password needs to be at least 6 character';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: _confirmpass,
                      obscureText: passwordVisibility2,
                      decoration: InputDecoration(
                          hintText: 'Confirm password',
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                passwordVisibility2 = !passwordVisibility2;
                              });
                            },
                            child: Icon(passwordVisibility2 ? Icons.visibility : Icons.visibility_off,
                                color: Colors.black, size: 22),
                          )),
                      validator: (input) {
                        if (input != _confirmpass.text) {
                          return 'Your password needs to be matched previous one!';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[900],
                        minimumSize: const Size(310, 62),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                    onPressed: () async {
                      String _email = _emailId.text.trim();
                      String _password = _enterpass.text.trim();
                      if (_formKey.currentState!.validate()) {
                        setState(() => isLoading = true);
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(email: _email, password: _password);
                        } catch (e) {
                          setState(() => isLoading = false);
                          return;
                        }
<<<<<<< HEAD
                       await FirebaseAuth.instance.currentUser!.updateDisplayName(_username.text);
=======
                        FirebaseAuth.instance.currentUser!.updateDisplayName(_username.text);
>>>>>>> origin/master
                        setState(() => isLoading = false);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                      }
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
