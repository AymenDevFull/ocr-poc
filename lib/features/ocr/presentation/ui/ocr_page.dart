import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr/core/ocr/ocr_service.dart';
import 'package:ocr/core/services/image_source_service.dart';
import 'package:ocr/features/ocr/presentation/mvvm/ocr_provider.dart';
import 'package:provider/provider.dart';

class OcrPage extends StatelessWidget {
  const OcrPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("OCR POC"),
      ),
      body: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (_) => OcrProvider(
              ocrService: OcrService(),
              sourceService: ImagesSourceService(
                imagePicker: ImagePicker(),
              )),
          child: Consumer<OcrProvider>(
            builder: (context, provider, _) {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  if (provider.source != null)
                    SizedBox(child: Image.file(File(provider.source!)))
                  else
                    Container(
                      width: 300,
                      height: 300,
                      color: Colors.grey[300]!,
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.grey,
                              shadowColor: Colors.grey[400],
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            onPressed: () {
                              provider.getTextRecognized(
                                  ImageSource.gallery, "TVA");
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.image,
                                    size: 30,
                                  ),
                                  Text(
                                    "Gallery",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[600]),
                                  )
                                ],
                              ),
                            ),
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.grey,
                              shadowColor: Colors.grey[400],
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            onPressed: () {
                              provider.getTextRecognized(
                                ImageSource.camera,
                                "TVA",
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.camera_alt,
                                    size: 30,
                                  ),
                                  Text(
                                    "Camera",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[600]),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                  if (provider.tvaList.isNotEmpty)
                    SizedBox(
                      height: 500,
                      child: ListView.builder(
                        itemCount: provider.tvaList.length,
                        prototypeItem: const ListTile(
                          title: Text("Tva list",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              )),
                        ),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              provider.tvaList[index].toString(),
                            ),
                          );
                        },
                      ),
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
