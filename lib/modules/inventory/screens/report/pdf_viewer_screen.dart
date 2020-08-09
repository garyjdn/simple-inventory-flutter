import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class PdfViewerPage extends StatelessWidget {
  static const routeName = '/pdf-viewer';

  const PdfViewerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String path = ModalRoute.of(context).settings.arguments;
    return PDFViewerScaffold(
      path: path,
    );
  }
}