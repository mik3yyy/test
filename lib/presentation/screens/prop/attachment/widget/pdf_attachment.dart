import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfAttachment extends StatelessWidget {
  final String attachmentUrl;
  final Function()? onPressed;
  final double height;
  final double width;

  const PdfAttachment({
    Key? key,
    required this.attachmentUrl,
    this.onPressed,
    required this.height,
    required this.width,
  }) : super(key: key);
  // const PdfAttachment(
  //     {super.key,
  //     required this.attachmentUrl,
  //     this.onPressed,
  //     required this.height,
  //     required this.width});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: Colors.grey.shade300,
        height: height,
        width: width,
        child: Stack(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: SfPdfViewer.network(attachmentUrl,
                  canShowPaginationDialog: false,
                  enableDoubleTapZooming: false),
            ),
            InkWell(
              onTap: onPressed,
              child: Container(
                height: height,
                width: width,
                color: Colors.grey.withOpacity(0.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
