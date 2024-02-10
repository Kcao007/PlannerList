import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coding_minds_sample/navigation.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  Future<bool> createNewUser (String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    }
    catch (e) {
      print(e);
      return false;
    }
  }






  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    helperText: 'Email'
                ),
                validator: (String? email) {
                  if (email == null || email.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                    helperText: 'Password'
                ),
                obscureText: true,
                validator: (String? password) {
                  if (password == null || password.length > 8) {
                    return 'Please enter a password with at least 8 characters';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: confirmController,
                decoration: const InputDecoration(
                    helperText: 'Confirm Password'
                ),
                obscureText: true,
                validator: (String? confirm) {
                  if (confirm == null) {
                    return 'Please enter a password with at least 8 characters';
                  }
                  else if (confirm != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      try {
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        ).then((_) {
                          print('Successfully created user');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const NavigationPage()));
                        });
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: const Text("Sign up!")
                ),
              )
            ]
          )
        )
      )
    );
  }
}

/*
Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  const Row(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        Text('Sign Up', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                      ]
                  ),

                  const SizedBox(
                    width: 350,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const SizedBox(
                    width: 350,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const SizedBox(
                    width: 350,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget> [

                        const Text(
                          'Return to ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),

                        GestureDetector(
                            child: const Text(
                              'Sign In',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blue),
                            ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
                          },
                        ),

                      ]
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  ElevatedButton(onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NavigationPage()));},
                      child: const Text('Sign Up')
                  ),
                ] // children
            )
        )
    );
  }

 */