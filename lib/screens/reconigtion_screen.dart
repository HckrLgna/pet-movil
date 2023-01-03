import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pets_movil/my_new_package/lib/tflite.dart';

class ReconigtionScreen extends StatefulWidget {
   
  const ReconigtionScreen({Key? key}) : super(key: key);

  @override
  State<ReconigtionScreen> createState() => _ReconigtionScreenState();
}

class _ReconigtionScreenState extends State<ReconigtionScreen> {
  File? _imageFile;
  List? _classifiedResult;
  final picker = ImagePicker();

  @override
  void initState() {    
    super.initState();
    loadImageModel();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  Future selectImage() async {    
    var image = await picker.pickImage(source: ImageSource.gallery, maxHeight: 300);
    classifyImage( image );
  }

  Future loadImageModel() async {
    Tflite.close();
    String? result;
    result = await Tflite.loadModel(
      model: "assets/mobilenet_v1_1.0_224.tflite",
      labels: "assets/mobilenet_v1_1.0_224.txt",
    );
    debugPrint("==== RESULT: ==== $result");
  }

  Future classifyImage(image) async {
    _classifiedResult = null;
    // Run tensorflowlite image classification model on the image
    debugPrint("classification start $image");
    final List? result = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    debugPrint("classification done");
    setState(() {
      if ( image != null ) {
        _imageFile = File(image.path);
        _classifiedResult = result;
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Classification"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(color: Colors.white),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(2, 2),
                    spreadRadius: 2,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: (_imageFile != null) ? Image.file( _imageFile! ) : Image.network('https://i.imgur.com/sUFH1Aq.png')
            ),
            MaterialButton(
              onPressed: (){
                selectImage();
              },
              child: const Text('Select Image')
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              child: Column(
                children: _classifiedResult != null ?
                  _classifiedResult!.map((result) {
                    return Card(
                      elevation: 0.0,
                      color: Colors.lightBlue,
                      child: Container(
                        width: 300,
                        margin: const EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            "${result["label"]} :  ${(result["confidence"] * 100).toStringAsFixed(1)}%",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }).toList() : [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}