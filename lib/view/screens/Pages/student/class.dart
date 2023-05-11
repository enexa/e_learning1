import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PdfFile {
  final String name;
  final String path;

  PdfFile({required this.name, required this.path});
}

class PdfListWidget extends StatefulWidget {
  @override
  _PdfListWidgetState createState() => _PdfListWidgetState();
}

class _PdfListWidgetState extends State<PdfListWidget> {
  late List<String> _categories;
  late List<String> _years;
  late Map<String, List<List<PdfFile>>> _pdfFiles;

  @override
  void initState() {
    super.initState();
    _categories = ['SW', 'IS', 'IT', 'CS'];
    _years = ['1st', '2nd', '3rd', '4th'];
    _pdfFiles = Map.fromIterable(
      _categories,
      key: (category) => category,
      value: (category) => List.generate(
        _years.length,
        (index) => [],
      ),
    );
    fetchPdfFiles();
  }

  Future<void> fetchPdfFiles() async {
    final response = await http.get(Uri.parse('http://10.42.0.1:8000/api/pdf'));
    final data = jsonDecode(response.body);
    setState(() {
      for (var key in data['files'].keys) {
        final parts = key.split(' ');
        final category = parts[0];
        final year = parts[1];
        final pdfFiles = data['files'][key].map<PdfFile>((path) {
          return PdfFile(name: path.split('/').last, path: path);
        }).toList();
        _pdfFiles[category]![_years.indexOf(year)] = pdfFiles;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Files'),
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (index, isExpanded) {
            setState(() {
              _categories[index] = isExpanded ? _categories[index] : '';
            });
          },
          children: _categories.map((category) {
            final index = _categories.indexOf(category);
            final pdfFiles = _pdfFiles[category]!;
            return ExpansionPanel(
              isExpanded: category.isNotEmpty,
              headerBuilder: (_, __) {
                return ListTile(
                  title: Text(category),
                );
              },
              body: Column(
                children: _years.map((year) {
                  final index = _years.indexOf(year);
                  final pdfFilesForYear = pdfFiles[index];
                  if (pdfFilesForYear.isEmpty || pdfFilesForYear[0].name.isEmpty) {
                    return SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      ListTile(
                        title: Text(year),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: pdfFilesForYear.length,
                        itemBuilder: (context, index) {
                          final pdfFile = pdfFilesForYear[index];
                          return ListTile(
                            title: Text(pdfFile.name),
                            onTap: () async {
                              final url = 'http://10.42.0.1:8000/api/${pdfFile.path}';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Could not open the file'),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
            }).toList(),
    ),
  ),
);
  }}
