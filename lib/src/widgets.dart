import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


/// Custom Bottom Navigation Bar
///
/// - Displays five navigation icons: Home, Messages, Search, Location, Profile.
/// - Highlights the active tab with a yellow color.
///
/// Used in: Home, Match, and Profile Screens.




class BottomNavBar extends StatelessWidget {
  /// The current index of the selected tab.
  final int selectedIndex;

  const BottomNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(context, Icons.home, 0, "/"),
          _buildNavItem(context, Icons.chat_bubble_outline, 1, "/chat"),
          _buildNavItem(context, Icons.add_circle_outline, 2, "/petProfile"),
          _buildNavItem(context, Icons.place, 3, "/map"),
          _buildNavItem(context, Icons.person, 4, "/profile"),
        ],
      ),
    );
  }

  /// Helper function to build navigation icons.
  Widget _buildNavItem(
      BuildContext context, IconData icon, int index, String route) {
    final isSelected = selectedIndex == index;

    return IconButton(
      icon: Icon(icon,
          size: 30, color: isSelected ? Colors.yellow : Colors.yellow[200]),
      onPressed: () {
        if (GoRouterState.of(context).uri.toString() != route) {
          context.go(route); // Navigate using GoRouter
        }
      },
    );
  }
}





class HealthDocumentsUploader extends StatefulWidget {
  final void Function(String)? onFileUploaded;

  const HealthDocumentsUploader({super.key, this.onFileUploaded});


  @override
  State<HealthDocumentsUploader> createState() => _HealthDocumentsUploaderState();
}

class _HealthDocumentsUploaderState extends State<HealthDocumentsUploader> {
  double _progress = 0.0;
  bool _uploading = false;
  String? _fileName;
  String? _downloadUrl;
  String? _errorMessage;

  Future<void> _pickFile() async {
    setState(() {
      _progress = 0;
      _uploading = true;
      _errorMessage = null;
      _downloadUrl = null;
    });

    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        withData: true, // this works for web and mobile
      );

      if (result != null && result.files.single.bytes != null) {
        final fileBytes = result.files.single.bytes!;
        final fileName = result.files.single.name;

        final userId = Supabase.instance.client.auth.currentUser?.id ?? 'new_pet';

        final storagePath = 'health_docs/$userId/$fileName';

        final response = await Supabase.instance.client.storage
            .from('pet-files') // this is your Supabase bucket name
            .uploadBinary(
          storagePath,
          fileBytes,
          fileOptions: const FileOptions(upsert: true),
        );

        if (response.isEmpty) {
          throw Exception("Empty response from Supabase");
        }

        final publicUrl = Supabase.instance.client.storage
            .from('pet-files')
            .getPublicUrl(storagePath);

        setState(() {
          _fileName = fileName;
          _downloadUrl = publicUrl;
          _uploading = false;
          _progress = 1.0;
        });

        widget.onFileUploaded?.call(fileName);

        print('File uploaded to Supabase: $publicUrl');
      } else {
        setState(() {
          _uploading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Upload failed: ${e.toString()}';
        _uploading = false;
      });
      print('Upload error: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _uploading ? null : _pickFile,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
              ),
              child: const Icon(Icons.insert_drive_file, size: 28),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: Colors.grey[300],
                  color: Colors.lightBlueAccent,
                  minHeight: 6,
                ),
                const SizedBox(height: 4),
                Text(
                  _uploading
                      ? '${(_progress * 100).toInt()}%'
                      : _fileName ?? 'Upload Health Document',
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                ),
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.redAccent, fontSize: 10),
                  )
                else if (_downloadUrl != null)
                  Text(
                    'Uploaded!',
                    style: const TextStyle(color: Colors.green, fontSize: 10),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}