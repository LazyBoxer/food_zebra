import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  FeedbackPageState createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  File? _imageFile;
  final picker = ImagePicker();
  final TextEditingController _textEditingController = TextEditingController();

  void _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  void _sendData() {
    final String text = _textEditingController.text;
    // TODO: send data somewhere
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('問題回報'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _getImage,
              child: const Text('選擇照片'),
            ),
            const SizedBox(height: 16.0),
            if (_imageFile != null) Image.file(_imageFile!),
            const SizedBox(height: 16.0),
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: '請輸入想要回報的問題...',
              ),
              maxLines: null,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _sendData,
              child: const Text('寄出'),
            ),
          ],
        ),
      ),
    );
  }
}
