import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DocumentCameraScreen extends StatefulWidget {
  const DocumentCameraScreen({super.key});

  @override
  State<DocumentCameraScreen> createState() =>
      _DocumentCameraScreenState();
}

class _DocumentCameraScreenState
    extends State<DocumentCameraScreen> {
  final ImagePicker _picker = ImagePicker();

  File? capturedImage;

  Future<void> openCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        capturedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Document'),
        backgroundColor: const Color(0xFF0B5D3B),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Icon(
              Icons.document_scanner_outlined,
              size: 80,
              color: Color(0xFF0B5D3B),
            ),

            const SizedBox(height: 20),

            const Text(
              'Compliance Document',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Capture a photo of the safety or compliance document.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 30),

            if (capturedImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  capturedImage!,
                  height: 260,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
              ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: openCamera,
                icon: const Icon(Icons.camera_alt),
                label: Text(
                  capturedImage == null
                      ? 'OPEN CAMERA'
                      : 'CAPTURE AGAIN',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B5D3B),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            if (capturedImage != null)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, capturedImage);
                  },
                  child: const Text('USE THIS DOCUMENT'),
                ),
              ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}