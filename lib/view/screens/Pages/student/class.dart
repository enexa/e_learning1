import 'dart:convert';
import 'dart:io';

import 'package:e_learning/view/screens/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';

class PdfFile {
  final int id;
  final String category;
  final String year;
  final String name;
  final String path;

  PdfFile({
    required this.id,
    required this.category,
    required this.year,
    required this.name,
    required this.path,
  });
}

class PdfScreen extends StatefulWidget {
  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  List<PdfFile> pdfFiles = [];
  bool isLoading = true;
  String? selectedCategory;
  String? selectedYear;

  @override
  void initState() {
    super.initState();
    fetchPDFFiles();
  }

  Future<void> fetchPDFFiles() async {
    var url = Uri.parse('http://192.168.0.15:8000/api/pdf');
    var token = 'Bearer 1|W8DIFtBJYZP9kFKcNbnLhEhrHiYSESxtsX5IFodx';

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<dynamic> pdfData = jsonData as List<dynamic>;

      setState(() {
        pdfFiles = pdfData
            .map((pdf) => PdfFile(
                  id: pdf['id'],
                  category: pdf['category'],
                  year: pdf['year'],
                  name: pdf['name'],
                  path: pdf['path'],
                ))
            .toList();
        isLoading = false;
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
      setState(() {
        isLoading = false;
      });
    }
  }

  List<String> getUniqueCategories() {
    var uniqueCategories =
        pdfFiles.map((pdf) => pdf.category).toSet().toList();
    uniqueCategories.sort();
    return uniqueCategories;
  }

  List<String> getUniqueYearsForCategory(String category) {
    var uniqueYears = pdfFiles
        .where((pdf) => pdf.category == category)
        .map((pdf) => pdf.year)
        .toSet()
        .toList();
    uniqueYears.sort();
    return uniqueYears;
  }

  Future<void> downloadPDF(String url, String fileName) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final externalDir = await getExternalStorageDirectory();
      final filePath = "${externalDir!.path}/$fileName";

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        Fluttertoast.showToast(msg: 'PDF downloaded successfully');
      } else {
        Fluttertoast.showToast(msg: 'Failed to download PDF');
      }
    } else {
      Fluttertoast.showToast(msg: 'Permission denied');
    }
  }

  Widget buildShimmeringContainer(double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }

  Widget buildShimmeringListView() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              buildShimmeringContainer(70, 70),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildShimmeringContainer(12, double.infinity),
                    const SizedBox(height: 5),
                    buildShimmeringContainer(12, 150),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? buildShimmeringListView()
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: getUniqueCategories().length,
                    itemBuilder: (context, index) {
                      var category = getUniqueCategories()[index];
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ExpansionTile(
                            title: Text(category,style: subtitlestyle(blackclr)),
                            children: [
                              ...getUniqueYearsForCategory(category).map(
                                (year) {
                                  return ListTile(
                                    leading: Icon(Icons.picture_as_pdf,color: blackclr,),
                                    title: Text('Year $year'),
                                    onTap: () {
                                      setState(() {
                                        selectedCategory = category;
                                        selectedYear = year;
                                      });
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  if (selectedCategory != null && selectedYear != null)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: pdfFiles.length,
                      itemBuilder: (context, index) {
                        var pdfFile = pdfFiles[index];
                        if (pdfFile.category == selectedCategory &&
                            pdfFile.year == selectedYear) {
                          return ListTile(
                            leading: Icon(Icons.picture_as_pdf,color: blackclr,),
                            title: Text(pdfFile.name),
                            trailing: IconButton(
                              icon: Icon(Icons.download,color: blackclr,),
                              onPressed: () {
                                downloadPDF(pdfFile.path, pdfFile.name);
                              },
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                ],
              ),
            ),
    );
  }
}
