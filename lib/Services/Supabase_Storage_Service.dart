import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final SupabaseClient _client = Supabase.instance.client;

  /// Pick ANY file (pdf, image, doc, video, etc.)
  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      withData: false,
    );

    if (result == null) return null;
    return File(result.files.single.path!);
  }

  /// Upload file to Supabase Storage
  /// folderName = bucket/folder path (ex: "notes", "uploads")
  Future<String?> uploadFile(File file, String folderName) async {
    try {
      // create unique filename
      final fileName =
          "${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}";

      final filePath = "$folderName/$fileName";

      // Upload to Supabase storage
      final response = await _client.storage
          .from('studifybucket') // replace with your bucket name
          .upload(filePath, file);

      if (response.isEmpty) return null;

      // Get public URL
      final publicUrl = _client.storage
          .from('studifybucket') // same bucket
          .getPublicUrl(filePath);

      return publicUrl;
    } catch (e) {
      print("Supabase Upload Error: $e");
      return null;
    }
  }

  /// delete file from Supabase Storage
  Future<bool> deleteFile(String path) async {
    try {
      await _client.storage.from('studifybucket').remove([path]);
      return true;
    } catch (e) {
      print("Delete Error: $e");
      return false;
    }
  }
}
