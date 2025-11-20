import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();

    List<Map<String, String>> notes = [
      {"title": "BCA", "date": "20-12-2025"},
      {"title": "BBA", "date": "08-08-2025"},
      {"title": "BCA", "date": "10-02-2024"},
      {"title": "BBA", "date": "25-01-2023"},
      {"title": "BBA", "date": "08-08-2025"},
      {"title": "BCA", "date": "10-02-2024"},
      {"title": "BBA", "date": "25-01-2023"},
      {"title": "BBA", "date": "08-08-2025"},
      {"title": "BCA", "date": "10-02-2024"},
      {"title": "BBA", "date": "25-01-2023"},
    ];

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hoverColor: Colors.blue,
                prefixIcon: Icon(Icons.search, color: Colors.blue.shade900),
                hintText: "Enter Name",
                label: Text(
                  "Search Notes...",
                  style: TextStyle(color: Colors.grey.shade800),
                ),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 30),
            Divider(color: Colors.white),
            // SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];

                  return containerWidget(
                    title: note["title"]!,
                    date: note["date"]!,
                    onOpen: () {
                      print("Open clicked for ${note["title"]}");
                    },
                  );
                },))
          ],
        ),
      ),
    );
  }
}

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
        // Title
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),

        const SizedBox(height: 8),

        // Date + Open Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),

            ElevatedButton.icon(
              onPressed: onOpen,
              icon: const Icon(
                Icons.open_in_new,
                color: Colors.white,
                size: 18,
              ),
              label: const Text("Open", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
