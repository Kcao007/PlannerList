import 'package:coding_minds_sample/login.dart';
import 'package:coding_minds_sample/navigation.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
