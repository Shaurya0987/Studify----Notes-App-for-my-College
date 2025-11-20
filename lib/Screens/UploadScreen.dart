import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studify/Services/Supabase_Storage_Service.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final storage = StorageService();
  File? selectedFile;
  String? uploadedUrl;

  // ⭐ pick & upload function
  Future<void> pickAndUploadFile() async {
    // Pick file
    File? file = await storage.pickFile();
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No file selected")),
      );
      return;
    }

    setState(() => selectedFile = file);

    // Upload file
    String? url = await storage.uploadFile(file, "uploads");

    if (url != null) {
      setState(() => uploadedUrl = url);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Uploaded Successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Upload failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.blue,
              width: 1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(29),
            boxShadow: [
              BoxShadow(
                blurStyle: BlurStyle.outer,
                blurRadius: 20,
                color: Colors.white,
              ),
            ],
          ),
          width: 330,
          height: 540,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Upload Your File",
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Select a file to upload and share",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                const SizedBox(height: 30),

                // Upload box
                Container(
                  height: 180,
                  width: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue.shade300,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.cloud_upload_outlined,
                      size: 105,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Browse files button
                Container(
                  width: 280,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextButton(
                    onPressed: pickAndUploadFile,
                    child: const Text(
                      "Browse Files",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    uploadWidget(FontAwesomeIcons.filePdf),
                    uploadWidget(Icons.edit_document),
                    uploadWidget(FontAwesomeIcons.image),
                  ],
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// BorderStyle function
BorderSide _dashBorder() {
  return BorderSide(
    color: Colors.blue.shade300,
    width: 2,
    style: BorderStyle.solid,
  );
}

// Circular icon widget
Widget uploadWidget(IconData icon) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.blue.shade800,
        width: 2,
      ),
    ),
    child: CircleAvatar(
      radius: 33,
      backgroundColor: Colors.blue.shade50,
      child: Icon(icon, size: 34, color: Colors.blue.shade900),
    ),
  );
}
