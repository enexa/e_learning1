import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class PdfScreen extends StatefulWidget {
  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  List<String> categories = ['CS', 'IS', 'IT', 'SW'];
  List<String> years = ['1', '2', '3', '4'];
  List<Map<String, dynamic>> pdfList = [];

  @override
  void initState() {
    super.initState();
    fetchPdfFiles();
  }

  Future<void> fetchPdfFiles() async {
    try {
      Dio dio = Dio();
      Response response = await dio.get('http://10.42.0.1:8000/api/pdf');
      if (response.statusCode == 200) {
        setState(() {
          pdfList = List<Map<String, dynamic>>.from(response.data);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> downloadAndOpenPdf(String url, String fileName) async {
    Dio dio = Dio();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/$fileName.pdf';

    try {
      await dio.download(url, filePath);
      OpenFile.open(filePath);
    } catch (e) {
      print(e.toString());
    }
  }

  List<Map<String, dynamic>> filterPdfList(String category, String year) {
    return pdfList
        .where((pdf) => pdf['category'] == category && pdf['year'] == year)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          String category = categories[index];

          return ExpansionTile(
            title: Text(category),
            children: [
              for (String year in years)
                ListTile(
                  title: Text('Year $year'),
                  onTap: () {
                    List<Map<String, dynamic>> filteredPdfList =
                        filterPdfList(category, year);

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('PDF Files'),
                          content: Column(
                            children: [
                              for (Map<String, dynamic> pdf in filteredPdfList)
                                ListTile(
                                  title: Text(pdf['name']),
                                  onTap: () {
                                    downloadAndOpenPdf(pdf['path'], pdf['name']);
                                  },
                                ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
