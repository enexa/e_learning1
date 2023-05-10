import 'package:flutter/material.dart';

import '../../../../controller/service/pdfservice.dart';
import '../../../../models/pdffile.dart';
import '../../widget/constants.dart';

class PdfListScreen extends StatefulWidget {
  const PdfListScreen({Key? key}) : super(key: key);

  @override
  _PdfListScreenState createState() => _PdfListScreenState();
}

class _PdfListScreenState extends State<PdfListScreen> {
  late Future<List<PdfFile>> _pdfFiles;
  
  get apiUrl => null;

  @override
  void initState() {
    super.initState();
    _pdfFiles = PdfService.getPdfFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Files')),
      body: FutureBuilder<List<PdfFile>>(
        future: _pdfFiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!;
            final categories = {'SW', 'IS', 'IT', 'CS'};
            final years = {'1st', '2nd', '3rd', '4th'};
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories.elementAt(index);
                final categoryFiles = files.where((file) => file.category == category).toList();
                return ExpansionTile(
                  title: Text(category),
                  children: years.map((year) {
                    final yearFiles = categoryFiles.where((file) => file.year == year).toList();
                    return yearFiles.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: yearFiles.map((file) {
                              final pdfUrl = '$pdfURL/${file.category}/${file.year}/${file.name}';
                              return ListTile(
                                title: Text(file.name),
                                onTap: () {
                                  // TODO: Open the PDF file in a WebView or PDF viewer
                                },
                              );
                            }).toList(),
                          )
                        : const SizedBox();
}).toList(),
);
},
);
} else if (snapshot.hasError) {
return Center(child: Text(snapshot.error.toString()));
}
return const Center(child: CircularProgressIndicator());
},
),
);
}
}
