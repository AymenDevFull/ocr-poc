import 'package:google_ml_kit/google_ml_kit.dart';

class OcrService {
  OcrService();

  Future<List<String>> getRecognisedText(String path, String text) async {
    try {
      final textDetector = GoogleMlKit.vision.textRecognizer();
      final imageInput = InputImage.fromFilePath(path);
      final RecognizedText recognisedText =
          await textDetector.processImage(imageInput);
      await textDetector.close();
      final textBlock =
          recognisedText.blocks.map((textBlock) => textBlock.lines).toList();
      final textlines = textBlock.map((textLine) => textLine).toList();
      final lines = textlines.expand((element) => element).toList();
      final tvaList = lines
          .map(
            (line) => line.text,
          )
          .toList();
      
      return tvaList;
    } catch (e) {
      return [];
    }
  }
}
