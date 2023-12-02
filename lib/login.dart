import 'package:coding_minds_sample/navigation.dart';
import 'package:coding_minds_sample/signup.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NavigationPage()));},
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NavigationPage()));},
                child: const Text('Sign In')
            ),
          ] // children
        )
      )
    );
  }
}
