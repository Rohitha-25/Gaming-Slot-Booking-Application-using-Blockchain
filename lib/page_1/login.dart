import 'package:flutter/material.dart';
import 'package:project_escapism/page_1/main.dart';
import 'package:project_escapism/page_1/signup.dart';
import 'package:project_escapism/page_2/main.dart';

import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _form = GlobalKey<FormState>();

  final _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';

  void _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }

    _form.currentState!.save();
    
  try {

    if (_isLogin) {
      final userCredentials = await _firebase.signInWithEmailAndPassword(
        email: _enteredEmail, password: _enteredPassword);
      print(userCredentials);
    } 
    else {
      final userCredentials = await _firebase.createUserWithEmailAndPassword(
        email: _enteredEmail, password: _enteredPassword);
      print(userCredentials);
      } 
    } on FirebaseAuthException catch (error) {
      Text(error.message ?? 'Authentication failed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff081427),
      appBar: AppBar(
        backgroundColor: const Color(0xff081427),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back_ios,
          size: 20,
          color: Colors.white,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Column(
                  children: <Widget>[
                    Text("Login",
                    style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20),
                    Text("Login to your Account",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white),)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(color: Colors.white70)
                          ),
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty || !value.contains('@')){
                              return "please enter a valid email address.";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredEmail = value!;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.white70)
                          ),
                          style: const TextStyle(color: Colors.white),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().length < 6){
                              return "password must be atleast 6 characters.";
                            }
                            else if (!value.contains(RegExp(r'[0-9]'))){
                              return "password must have atleast 1 numerical character.";
                            }
                            else if (!value.contains(RegExp(r'[!@$]'))){
                              return "password must have atleast 1 special character.";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredPassword = value!;
                          },
                        ),
                      ],
                    )
                  )
                ),
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    decoration:
                      BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: const Border(
                          bottom: BorderSide(color: Colors.white),
                          top: BorderSide(color: Colors.white),
                          left: BorderSide(color: Colors.white),
                          right: BorderSide(color: Colors.white),
                        )
                      ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        _submit;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Home())); 
                      },
                      color: const Color(0xff081427),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    child: const Text(
                      "Login", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    ),
                  ),
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("don't have an account?",style: TextStyle(
                    color: Colors.white)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                    },
                    child: const Text("SignUp", style: TextStyle(
                      fontSize: 18,
                      color: Colors.white),)
                  )
                ],
              ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}