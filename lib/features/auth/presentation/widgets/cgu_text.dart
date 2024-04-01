import 'package:descolar_front/core/components/app_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CGUText extends StatelessWidget {
  const CGUText({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBars.backAppBar(context),
      body: SfPdfViewer.asset('assets/documents/CGU.pdf'),
    );
  }
}
