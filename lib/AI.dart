// import 'package:flutter/material.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

// class SignLanguageRecognition extends StatefulWidget {
//   @override
//   _SignLanguageRecognitionState createState() => _SignLanguageRecognitionState();
// }

// class _SignLanguageRecognitionState extends State<SignLanguageRecognition> {
//   late Interpreter _interpreter;
//   final ImagePicker _picker = ImagePicker();
//   late File _image;
//   bool _isImageLoaded = false;
//   String _result = "";

//   @override
//   void initState() {
//     super.initState();
//     _loadModel();
//   }

//   Future<void> _loadModel() async {
//     _interpreter = await Interpreter.fromAsset('model.tflite');
//   }

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//         _isImageLoaded = true;
//       });
//       _predict();
//     }
//   }

//   Future<void> _predict() async {
//     // إعداد الصورة المدخلة للنموذج
//     var inputImage = ImageProcessorBuilder()
//         .add(ResizeOp(224, 224, ResizeMethod.BILINEAR))
//         .build()
//         .process(TensorImage.fromFile(_image));

//     // استدعاء النموذج والحصول على النتائج
//     var output = List.filled(1 * 29, 0).reshape([1, 29]);
//     _interpreter.run(inputImage.buffer, output);
    
//     setState(() {
//       _result = _getLabel(output[0]);
//     });
//   }

//   String _getLabel(List<double> output) {
//     // تحويل النتائج إلى نص
//     var labels = ["إشارة 1", "إشارة 2", "إشارة 3"]; // قائمة الإشارات
//     int maxIndex = 0;
//     for (int i = 0; i < output.length; i++) {
//       if (output[i] > output[maxIndex]) {
//         maxIndex = i;
//       }
//     }
//     return labels[maxIndex];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('التعرف على لغة الإشارة'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _isImageLoaded
//                 ? Image.file(_image, height: 300, width: 300)
//                 : Container(),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('اختيار صورة'),
//             ),
//             SizedBox(height: 16),
//             Text(_result, style: TextStyle(fontSize: 24)),
//           ],
//         ),
//       ),
//     );
//   }
// }
