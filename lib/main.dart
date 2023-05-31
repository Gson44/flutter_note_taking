import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testing/signup.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "addnotes.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Experiment",
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Login")),
      body: CustomWidgetState(),
    );
  }
}

class CustomWidgetState extends StatefulWidget {
  _CustomWidget createState() => _CustomWidget();
}

class _CustomWidget extends State<CustomWidgetState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void SignUpScreen() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignUp()));
    }

    Future<void> signIn() async {
      try {
        final UserCredential userCredential =
            await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        print("User signed in: ${userCredential.user!.email}");
        print(userCredential.user!.email);
        print(emailController.text.trim());
        if (userCredential.user!.email == emailController.text.trim()) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNotes()));
        }
      } on FirebaseAuthException catch (e) {
        print(e.toString());
      }
    }

    // rest of your build function...

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Email",
              style: TextStyle(fontSize: 28, color: Colors.amber),
            ),
            SizedBox(width: 72),
            Container(
                width: 300,
                child: TextFormField(
                  style: TextStyle(color: Colors.pink.shade200),
                  controller: emailController,
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
            Text(
              "Password",
              style: TextStyle(fontSize: 28, color: Colors.amber),
            ),
            SizedBox(width: 20),
            Container(
                width: 300,
                child: TextFormField(
                  controller: passwordController,
                  style: TextStyle(color: Colors.pink.shade200),
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
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: signIn, child: Text("Sign In")),
            SizedBox(
              width: 20,
            ),
            ElevatedButton(onPressed: SignUpScreen, child: Text("Sign Up"))
          ],
        )
      ],
    );
  }
}
