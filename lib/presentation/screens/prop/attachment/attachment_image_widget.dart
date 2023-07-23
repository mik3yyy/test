import 'package:cached_network_image/cached_network_image.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/dialog_res.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/widgets/bottomNav/persistent_tab_view.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/attachment/pdf_screen/pdf_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/attachment/video_screen/video_screen.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/attachment/widget/image_attachement.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/attachment/widget/pdf_attachment.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/attachment/widget/video_attachment.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/download_file.dart';
import 'package:permission_handler/permission_handler.dart';

class ViewAttachment extends StatefulHookConsumerWidget {
  final List<Attachment>? file;
  final double height;
  final double width;

  const ViewAttachment({
    required this.file,
    this.height = 60,
    this.width = 60,
    Key? key,
  }) : super(key: key);
  // const ViewAttachment(
  //     {super.key, required this.file, this.height = 60, this.width = 60});

  @override
  ConsumerState<ViewAttachment> createState() => _ViewAttachmentState();
}

class _ViewAttachmentState extends ConsumerState<ViewAttachment> {
  String isSelected = "";
  Future<String> getDownloadFolderPath() async {
    return await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
  }

  Future<bool> getStoragePremission() async {
    return await Permission.storage.request().isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(widget.file!.length, (index) {
      final attachments = widget.file![index];
      if (attachments.url == null || attachments.url!.isEmpty) {
        return const SizedBox.shrink();
      } else if (attachments.url!.contains("mp4")) {
        return VideoAttachment(
          attachmentUrl: attachments.url!,
          onPressed: () {
            pushNewScreen(context,
                screen: VideoScreen(
                  attachmentUrl: attachments.url!,
                  isSender: false,
                ),
                pageTransitionAnimation: PageTransitionAnimation.cupertino);
          },
        );
      } else if (attachments.url!.contains("pdf")) {
        return PdfAttachment(
          attachmentUrl: attachments.url!,
          height: widget.height,
          width: widget.width,
          onPressed: () {
            pushNewScreen(context,
                screen: PdfScreen(
                  attachmentUrl: attachments.url!,
                  isSender: false,
                ),
                pageTransitionAnimation: PageTransitionAnimation.cupertino);
          },
        );
      } else {
        return ImageAttachment(
          attachmentUrl: attachments.url!,
          height: widget.height,
          width: widget.width,
          isSender: false,
          onPressed: () async {
            Navigator.of(context).pop();
            if (await getStoragePremission()) {
              setState(() => isSelected = attachments.url!);
              ref
                  .read(downloadAttachmentProvider.notifier)
                  .downloadAttachment(attachments.url!, attachments.fileType!);
            }
          },
        );
      }
    }));
  }
}

class SendersAttachment extends StatefulHookConsumerWidget {
  final List<Attachment>? file;
  final double height;
  final double width;
  const SendersAttachment({
    required this.file,
    this.height = 60,
    this.width = 60,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SendersAttachment> createState() => _SendersAttachmentState();
}

class _SendersAttachmentState extends ConsumerState<SendersAttachment> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(widget.file!.length, (index) {
      final attachments = widget.file![index];
      if (attachments.url == null || attachments.url!.isEmpty) {
        return const SizedBox.shrink();
      } else if (attachments.url!.contains("mp4")) {
        return VideoAttachment(
          attachmentUrl: attachments.url!,
          onPressed: () {
            pushNewScreen(context,
                screen: VideoScreen(attachmentUrl: attachments.url!),
                pageTransitionAnimation: PageTransitionAnimation.cupertino);
          },
        );
      } else if (attachments.url!.contains("pdf")) {
        return PdfAttachment(
          attachmentUrl: attachments.url!,
          height: widget.height,
          width: widget.width,
          onPressed: () {
            pushNewScreen(context,
                screen: PdfScreen(attachmentUrl: attachments.url!),
                pageTransitionAnimation: PageTransitionAnimation.cupertino);
          },
        );
      } else {
        return ImageAttachment(
          attachmentUrl: attachments.url!,
          height: widget.height,
          width: widget.width,
          onPressed: () async {
            Navigator.of(context).pop();
          },
          isSender: false,
        );
      }
    }));
  }
}

class DialogAttachment extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  const DialogAttachment({
    required this.image,
    this.height = 60,
    this.width = 60,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return image.isEmpty
        ? const SizedBox.shrink()
        : Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey.shade300,
            ),
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Container(
                      padding: const EdgeInsets.all(100),
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress)),
              errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade200,
                  padding: const EdgeInsets.all(30),
                  child: const CircularProgressIndicator()),
            ),
          );
  }
}
