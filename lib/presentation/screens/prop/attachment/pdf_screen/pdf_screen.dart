import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/download_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatefulHookConsumerWidget {
  final String attachmentUrl;
  final bool isSender;

  const PdfScreen(
      {required this.attachmentUrl, this.isSender = false, Key? key})
      : super(key: key);

  @override
  ConsumerState<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends ConsumerState<PdfScreen> {
  bool pdfLoading = true;
  Future<String> getDownloadFolderPath() async {
    return await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
  }

  Future<bool> getStoragePremission() async {
    return await Permission.storage.request().isGranted;
  }

  @override
  Widget build(BuildContext context) {
    final downloadAttachment = ref.watch(downloadAttachmentProvider);

    ref.listen<RequestState>(downloadAttachmentProvider, (_, value) {
      if (value is Success<String>) {}
      if (value is Error) {}
    });
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.grey.shade100,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            if (!widget.isSender) ...[
              IconButton(
                  onPressed: pdfLoading
                      ? null
                      : () async {
                          if (await getStoragePremission()) {
                            ref
                                .read(downloadAttachmentProvider.notifier)
                                .downloadAttachment(
                                    widget.attachmentUrl, "pdf");
                          }
                        },
                  icon: downloadAttachment is Loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                      : const Icon(
                          Icons.download,
                          color: Colors.black,
                        ))
            ]
          ],
        ),
        body: SafeArea(
          child: SizedBox(
              child: SfPdfViewer.network(
            widget.attachmentUrl,
            canShowScrollHead: false,
            canShowScrollStatus: false,
            onDocumentLoaded: (details) {
              setState(() => pdfLoading = false);
            },
          )),
        ));
  }
}
