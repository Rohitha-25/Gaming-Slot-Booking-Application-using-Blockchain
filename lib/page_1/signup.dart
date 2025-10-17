import 'package:flutter/material.dart';
import 'package:project_escapism/page_1/login.dart';

import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final _form = GlobalKey<FormState>();

  final _isSignUp = true;
  var _enteredEmail = '';
  var _enteredPassword = '';

  final TextEditingController _pass = TextEditingController();

  void _submit() async {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
    }

  try {

    if (_isSignUp) {
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
      resizeToAvoidBottomInset: true,
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Column(
                children: <Widget>[
                  Text("SignUp",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 20,),
                  Text("Create an Account",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white),)
                ],
              ),
              Form(
                  key: _form,
                  child: Column(
                    children: <Widget>[
                    TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Username",
                          labelStyle: TextStyle(color: Colors.white70)
                        ),
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.name,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty){
                            return 'please enter your username.';
                          }
                          return null;
                        },
                      ),
                    TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white70)
                        ),
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty || !value.contains('@')){
                            return 'please enter a valid email address.';
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
                        controller: _pass,
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
                      ),
                    TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Confirm Password",
                          labelStyle: TextStyle(color: Colors.white70)
                        ),
                        style: const TextStyle(color: Colors.white),
                        obscureText: true,
                        validator: (value) {
                          if (value != _pass.text){
                            return "password doesn't match, please check your entered password and confirm.";
                          }
                          return null;
                        },
                        onSaved: (value) {
                            _enteredPassword = value!;
                          },
                      )
                  ],
                ),
              ),
              Container(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())); 
                      },
                      color: const Color(0xff081427),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    child: const Text(
                      "SignUp", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Already have an Account?",style: TextStyle(
                    color: Colors.white)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: const Text("Login", style: TextStyle(
                      fontSize: 18,
                      color: Colors.white),)
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}