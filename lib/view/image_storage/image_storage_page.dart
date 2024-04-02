import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageStorageScreen extends StatelessWidget {
  const ImageStorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(),
            ElevatedButton(
                onPressed: () async {
                  ImagePicker imagePicker = ImagePicker();
                  XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
                  if (pickedImage != null) {
                    String uniqueImageName = DateTime.now().microsecondsSinceEpoch.toString();
                    print(pickedImage?.path.toString());

                    //  reference to root storage

                    Reference rootRef = FirebaseStorage.instance.ref();

                    // create new folder in root
                    Reference testImageRef = rootRef.child("TestImages");
                    //  create a reference to which the image should be stored
                    Reference uploadRef = testImageRef.child("$uniqueImageName");

                    try {
                      // put the picked image to the reference
                      await uploadRef.putFile(File(pickedImage.path));
                      // get the storage url to the reference

                      final url = await uploadRef.getDownloadURL();
                      print(url);
                    } catch (e) {
                      print(e.toString());
                    }
                  }
                },
                child: Text("Upload")),
          ],
        ),
      ),
    );
  }
}
