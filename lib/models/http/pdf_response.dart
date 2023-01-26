// To parse this JSON data, do
//
//     final pdfResponse = pdfResponseFromMap(jsonString);


import 'dart:convert';

class PdfResponse {
    PdfResponse({
        required this.nombrePdf,
        required this.size,
        required this.path,
        required this.url,
    });

    String? nombrePdf;
    int? size;
    String? path;
    String? url;

    factory PdfResponse.fromJson(String str) => PdfResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PdfResponse.fromMap(Map<String, dynamic> json) => PdfResponse(
        nombrePdf: json["nombrePdf"],
        size: json["size"],
        path: json["path"],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "nombrePdf": nombrePdf,
        "size": size,
        "path": path,
        "url": url,
    };
}
