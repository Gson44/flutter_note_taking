import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'addnotes.dart';

class ReadNotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: Text("ReadNotes")),
        body: ReadNotesWidget());
  }
}

class ReadNotesWidget extends StatefulWidget {
  _ReadNotesWidget createState() => _ReadNotesWidget();
}

class _ReadNotesWidget extends State<ReadNotesWidget> {
  final FirebaseDatabase _database = FirebaseDatabase(
    databaseURL: 'https://arectech-5896a-default-rtdb.firebaseio.com',
  );
  List<String> notes = [];

  @override
  void initState() {
    super.initState();
    _database.reference().child('notes').onValue.listen((event) {
      var snapshot = event.snapshot;

      if (snapshot.value != null) {
        var tempNotes = snapshot.value as Map;
        var notesFromDb = tempNotes.values.toList();

        setState(() {
          notes = notesFromDb.cast<String>();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    void AddNotesScreen() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddNotes()));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(notes[index],
                    style: TextStyle(color: Colors.amber, fontSize: 22)),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: AddNotesScreen, child: Text("Add Notes")),
          ],
        )
      ],
    );
  }
}
