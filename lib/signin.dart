import 'package:coding_minds_sample/navigation.dart';
import 'package:coding_minds_sample/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coding_minds_sample/fireStore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<bool> signUserIn() async {
    showDialog(
      context: context, builder: (context) {
        return const Center(
          child: CircularProgressIndicator()
        );
      }
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
      return true;
    }

    on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showDialog(context: context, builder: (context) {
        return const AlertDialog(title: Text("Invalid login, please try again."));
      }
      );
      return false;
    }
  }

  showAlertDialog(BuildContext context, String text) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Text('Login', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
              ]
            ),

            SizedBox(
              width: 350,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                controller: emailController,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            SizedBox(
              width: 350,
              child: TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                controller: passwordController,
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget> [

                const Text(
                  'Don\'t have an account? ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),

                GestureDetector(
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blue),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpPage()));
                  },
                ),


              ]
            ),

            const SizedBox(
              height: 5,
            ),

            ElevatedButton(onPressed: () {
              var email = emailController.text.toString();
              var password = passwordController.text.toString();

              FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password
              ).then((value) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NavigationPage()));
                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NavigationPage()));},

                }).onError((error, stackTrace) {
                  showAlertDialog(context, "Error ${error.toString()}");
                });

              debugPrint('Clicked log in');
            },
              child: const Text('Sign In')
            ),
          ] // children
        )
      )
    );
  }
}