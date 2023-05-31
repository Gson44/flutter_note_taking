import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'readnotes.dart';

class AddNotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: Text("AddNotes")),
        body: AddNotesWidget());
  }
}

class AddNotesWidget extends StatefulWidget {
  _AddNotesWidget createState() => _AddNotesWidget();
}

class _AddNotesWidget extends State<AddNotesWidget> {
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void addNote() async {
      // Initialize the FirebaseDatabase instance
      final FirebaseDatabase _database = FirebaseDatabase(
        databaseURL: 'https://arectech-5896a-default-rtdb.firebaseio.com',
      );

      // Get a DatabaseReference
      DatabaseReference databaseReference = _database.reference();

      try {
        // Push the note value to the 'notes' node in the Realtime Database
        await databaseReference.child('notes').push().set(noteController.text);

        // Show a success message using a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Note added successfully!'),
            duration: Duration(seconds: 2),
          ),
        );

        // Clear the text field
        noteController.clear();
      } catch (e) {
        // Show an error message using a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add note: $e'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }

    void ReadNotesScreen() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ReadNotes()));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Add Notes",
                style: TextStyle(fontSize: 22, color: Colors.amber)),
            SizedBox(width: 50),
            Container(
                width: 300,
                child: TextFormField(
                  controller: noteController,
                  style: TextStyle(color: Colors.pink.shade200),
                  decoration: InputDecoration(
                    labelText: "Enter Notes",
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
        ElevatedButton(onPressed: addNote, child: Text("Add Note")),
        SizedBox(height: 200),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: ReadNotesScreen, child: Text("Read notes"))
          ],
        )
      ],
    );
  }
}
