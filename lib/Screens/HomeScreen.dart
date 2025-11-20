import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studify/Screens/AuthGate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> SignOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthGate()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> notes = [
      {"title": "BCA", "date": "20-12-2025"},
      {"title": "BBA", "date": "08-08-2025"},
      {"title": "BCA", "date": "10-02-2024"},
      {"title": "BBA", "date": "25-01-2023"},
      {"title": "DTP", "date": "10-01-2023"},
    ];

    return Scaffold(
      backgroundColor: Colors.blue.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Studify",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.blue.shade700,
                size: 28,
              ),
              onPressed: SignOut,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(22.0),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 15),

              // ⭐ NEWS SECTION
              Text(
                "News",
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 1),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade200.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("📢 New Notes Uploaded!", style: TextStyle(fontSize: 19)),
                    SizedBox(height: 10),
                    Text("New question papers and notes for BCA & DTP are now available."),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Divider(color: Colors.white),
              const SizedBox(height: 20),

              // ⭐ RECENT NOTES
              Text(
                "Recent Notes",
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // ⭐ FIXED — NO LISTVIEW INSIDE SCROLLVIEW
              Column(
                children: List.generate(notes.length, (index) {
                  final note = notes[index];
                  return containerWidget(
                    title: note["title"]!,
                    date: note["date"]!,
                    onOpen: () {},
                  );
                }),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

// ⭐ BEAUTIFUL NOTE CARD
Widget containerWidget({
  required String title,
  required String date,
  required VoidCallback onOpen,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.blue.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.shade100,
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),

            ElevatedButton.icon(
              onPressed: onOpen,
              icon: const Icon(Icons.open_in_new, color: Colors.white, size: 18),
              label: const Text("Open", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            )
          ],
        ),
      ],
    ),
  );
}
