import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/pdffile.dart';
import '../../view/screens/widget/constants.dart';

class PdfService {
  // Replace with your Laravel API URL

  static Future<List<PdfFile>> getPdfFiles() async {
    final response = await http.get(Uri.parse(pdfURL));
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body)['files'] as Map<String, dynamic>;
      final pdfFiles = <PdfFile>[];
      jsonList.forEach((key, value) {
        final categoryYear = key.split(' ');
        value.forEach((pdfName) {
          pdfFiles.add(PdfFile(category: categoryYear[0], year: categoryYear[1], name: pdfName));
        });
      });
      return pdfFiles;
    } else {
      throw Exception('Failed to load PDF files');
    }
  }
}
