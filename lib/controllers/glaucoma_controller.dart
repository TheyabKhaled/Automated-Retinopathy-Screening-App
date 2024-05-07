import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

import '../models/result.dart';

Future<Result?> getGlaucomaResult(XFile file) async {
  final interpreter =
      await tfl.Interpreter.fromAsset('assets/model/glaucoma_model.tflite');
  List<int> byteList = await getImageBytes(file);

  var input =
      imageToByteListFloat32(img.decodeImage(byteList)!, 160, 127.5, 127.5);

  var output = List.filled(1 * 1, 0).reshape([1, 1]);

  interpreter.run(input, output);

  double confidence = output[0][0];

  return Result(confidence, confidence.toInt(), getLabel(confidence));
}

String getLabel(double confidence) {
  return confidence > 19.85 ? "Positive" : "Negative";
}

Future<List<int>> getImageBytes(XFile imageFile) async {
  File file = File(imageFile.path);
  List<int> imageBytes = await file.readAsBytes();
  return imageBytes;
}

Uint8List imageToByteListFloat32(
    img.Image image, int inputSize, double mean, double std) {
  var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
  var buffer = Float32List.view(convertedBytes.buffer);
  int pixelIndex = 0;
  for (var i = 0; i < inputSize; i++) {
    for (var j = 0; j < inputSize; j++) {
      var pixel = image.getPixel(j, i);
      buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
      buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
      buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
    }
  }
  return convertedBytes.buffer.asUint8List();
}
