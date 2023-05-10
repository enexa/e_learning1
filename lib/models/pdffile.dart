class PdfFile {
  final String category;
  final String year;
  final String name;

  PdfFile({required this.category, required this.year, required this.name});

  factory PdfFile.fromJson(Map<String, dynamic> json) {
    return PdfFile(
      category: json['category'],
      year: json['year'],
      name: json['name'],
    );
  }
}
