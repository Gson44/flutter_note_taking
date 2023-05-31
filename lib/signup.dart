import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: Text("Sign Up Page")),
        body: SignUpWidget());
  }
}

class SignUpWidget extends StatefulWidget {
  _SignUpWidget createState() => _SignUpWidget();
}

class _SignUpWidget extends State<SignUpWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> signUp() async {
      try {
        final UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());
        print("User signed up: ${userCredential.user!.email}");

        final snackBar = SnackBar(
          content: Text("Account Created"),
          duration: Duration(seconds: 3),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } on FirebaseAuthException catch (e) {
        print(e.toString());
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Email", style: TextStyle(fontSize: 22, color: Colors.amber)),
            SizedBox(width: 50),
            Container(
                width: 300,
                child: TextFormField(
                  controller: emailController,
                  style: TextStyle(color: Colors.pink.shade200),
                  decoration: InputDecoration(
                    labelText: "Enter Email",
                    labelStyle: TextStyle(color: Colors.pink.shade200),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink.shade200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink.shade200),
                    ),
                  ),
                )),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Password",
                style: TextStyle(fontSize: 22, color: Colors.amber)),
            SizedBox(
              width: 10,
            ),
            Container(
                width: 300,
                child: TextFormField(
                  style: TextStyle(color: Colors.pink.shade200),
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Enter Password",
                    labelStyle: TextStyle(color: Colors.pink.shade200),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink.shade200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink.shade200),
                    ),
                  ),
                  obscureText: true,
                )),
          ],
        ),
        ElevatedButton(onPressed: signUp, child: Text("Create"))
      ],
    );
  }
}
