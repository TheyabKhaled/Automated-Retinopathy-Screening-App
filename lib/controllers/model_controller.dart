import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:tflite/tflite.dart';
import '../models/result.dart';
import 'package:image/image.dart' as img;

class ModelController {
  static final List<Result> _outputs = [];
  static bool modelLoaded = false;

  static Future<String?> loadModel() async {
    return Tflite.loadModel(
      model: "assets/model/model_unquant.tflite",
      labels: "assets/model/labels.txt",
    );
  }

  static Future<Result?> classifyImage(XFile file) async {
    List<int> byteList = await getImageBytes(file);

    List<dynamic>? value = await Tflite.runModelOnBinary(
      binary:
          imageToByteListFloat32(img.decodeImage(byteList)!, 224, 127.5, 127.5),
    );
    if (value?.isNotEmpty ?? false) {
      _outputs.clear();

      for (var element in value!) {
        _outputs.add(
          Result(
            element['confidence'],
            element['index'],
            element['label'],
          ),
        );
      }
    }

    _outputs.sort((a, b) => a.confidence!.compareTo(b.confidence!));

    return _outputs.isNotEmpty ? _outputs[0] : null;
  }

  static Future<List<int>> getImageBytes(XFile imageFile) async {
    File file = File(imageFile.path);
    List<int> imageBytes = await file.readAsBytes();
    return imageBytes;
  }

  static Uint8List imageToByteListFloat32(
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

  static Uint8List imageToByteListUint8(img.Image image, int inputSize) {
    var convertedBytes = Uint8List(1 * inputSize * inputSize * 3);
    var buffer = Uint8List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = img.getRed(pixel);
        buffer[pixelIndex++] = img.getGreen(pixel);
        buffer[pixelIndex++] = img.getBlue(pixel);
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  static void disposeModel() {
    Tflite.close();
  }
}
