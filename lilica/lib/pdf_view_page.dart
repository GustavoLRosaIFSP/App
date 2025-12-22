import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewPage extends StatefulWidget {
  final String assetPath;
  const PdfViewPage({super.key, required this.assetPath});

  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  String? localPdfPath;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    final byteData = await rootBundle.load(widget.assetPath);
    final tempDir = await getTemporaryDirectory();
    final tempFile = File("${tempDir.path}/${widget.assetPath.split('/').last}");

    await tempFile.writeAsBytes(byteData.buffer.asUint8List());
    setState(() => localPdfPath = tempFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade300,
        title: const Text("Visualizador PDF"),
      ),
      body: localPdfPath == null
          ? const Center(child: CircularProgressIndicator())
          : PDFView(filePath: localPdfPath!),
    );
  }
}
