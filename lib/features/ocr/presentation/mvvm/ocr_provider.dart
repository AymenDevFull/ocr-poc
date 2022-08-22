import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr/core/ocr/ocr_service.dart';
import 'package:ocr/core/services/image_source_service.dart';

class OcrProvider extends ChangeNotifier {
  final OcrService ocrService;
  final ImagesSourceService sourceService;
  OcrProvider({
    required this.ocrService,
    required this.sourceService,
  });
  List<String> _tvaList = [];
  String? _source;

  Future<void> getTextRecognized(ImageSource source, String text) async {
    _source = await sourceService.getImage(source);
    if (_source != null) {
      _tvaList = await ocrService.getRecognisedText(_source!, text);
      notifyListeners();
    }
  }

  List<String> get tvaList => _tvaList;
  String? get source => _source;
}
