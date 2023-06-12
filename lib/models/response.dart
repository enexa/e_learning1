class Response {
  Object? data;
  String? error;

  Response({this.data, this.error});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      data: json['data'],
      error: json['error'],
    );
  }
}
