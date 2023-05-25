import 'package:cached_network_image/cached_network_image.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/dialog_res.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/download_file.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:video_player/video_player.dart';

class ViewAttachment extends StatefulHookConsumerWidget {
  final List<Attachment>? file;
  final double height;
  final double width;
  const ViewAttachment(
      {super.key, required this.file, this.height = 60, this.width = 60});

  @override
  ConsumerState<ViewAttachment> createState() => _ViewAttachmentState();
}

class _ViewAttachmentState extends ConsumerState<ViewAttachment> {
  String isSelected = "";
  VideoPlayerController? _videoPlayerController;
  Future<String> getDownloadFolderPath() async {
    return await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
  }

  Future<bool> getStoragePremission() async {
    return await Permission.storage.request().isGranted;
  }

  @override
  Widget build(BuildContext context) {
    final download = ref.watch(downloadAttachmentProvider);
    return Column(
        children: List.generate(widget.file!.length, (index) {
      final attachments = widget.file![index];
      if (attachments.url == null || attachments.url!.isEmpty) {
        return const SizedBox.shrink();
      } else if (attachments.url!.contains("mp4")) {
        _videoPlayerController = VideoPlayerController.network(attachments.url!)
          ..initialize();

        return Row(
          children: [
            FittedBox(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5)),
                child: VideoPlayer(_videoPlayerController!),
              ),
            ),
            if (isSelected == attachments.url && download is Loading) ...[
              const SizedBox(
                  height: 20, width: 20, child: CircularProgressIndicator()),
              Space(20.w)
            ] else ...[
              IconButton(
                  color: Colors.black,
                  onPressed: () async {
                    if (await getStoragePremission()) {
                      setState(() => isSelected = attachments.url!);
                      ref
                          .read(downloadAttachmentProvider.notifier)
                          .downloadAttachment(
                              attachments.url!, attachments.fileType!);
                    }
                  },
                  icon: const Icon(Icons.download))
            ],
          ],
        );
      } else if (attachments.url!.contains("pdf")) {
        return Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                color: Colors.grey.shade300,
                height: widget.height,
                width: widget.width,
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: SfPdfViewer.network(
                    attachments.url ?? "",
                  ),
                ),
              ),
            ),
            if (isSelected == attachments.url && download is Loading) ...[
              const SizedBox(
                  height: 20, width: 20, child: CircularProgressIndicator()),
              Space(20.w)
            ] else ...[
              IconButton(
                  color: Colors.black,
                  onPressed: () async {
                    if (await getStoragePremission()) {
                      setState(() => isSelected = attachments.url!);
                      ref
                          .read(downloadAttachmentProvider.notifier)
                          .downloadAttachment(
                              attachments.url!, attachments.fileType!);
                    }
                  },
                  icon: const Icon(Icons.download))
            ],
          ],
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            color: Colors.grey.shade300,
            height: widget.height,
            width: widget.width,
            child: CachedNetworkImage(
              imageUrl: attachments.url!,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  SizedBox(
                      height: 50,
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      )),
              errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade200,
                  padding: const EdgeInsets.all(30),
                  child: const CircularProgressIndicator()),
            ),
          ),
        );
      }
    }));
  }
}

class SendersAttachment extends StatefulHookConsumerWidget {
  final List<Attachment>? file;
  final double height;
  final double width;
  const SendersAttachment(
      {super.key, required this.file, this.height = 60, this.width = 60});

  @override
  ConsumerState<SendersAttachment> createState() => _SendersAttachmentState();
}

class _SendersAttachmentState extends ConsumerState<SendersAttachment> {
  VideoPlayerController? _videoPlayerController;
  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(widget.file!.length, (index) {
      final attachments = widget.file![index];
      if (attachments.url == null || attachments.url!.isEmpty) {
        return const SizedBox.shrink();
      } else if (attachments.url!.contains("mp4")) {
        _videoPlayerController = VideoPlayerController.network(attachments.url!)
          ..initialize();

        return FittedBox(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(5)),
            child: VideoPlayer(_videoPlayerController!),
          ),
        );
      } else if (attachments.url!.contains("pdf")) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            color: Colors.grey.shade300,
            height: widget.height,
            width: widget.width,
            child: SizedBox(
              height: 80,
              width: 80,
              child: SfPdfViewer.network(
                attachments.url ?? "",
              ),
            ),
          ),
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            color: Colors.grey.shade300,
            height: widget.height,
            width: widget.width,
            child: CachedNetworkImage(
              imageUrl: attachments.url!,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  SizedBox(
                      height: 50,
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      )),
              errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade200,
                  padding: const EdgeInsets.all(30),
                  child: const CircularProgressIndicator()),
            ),
          ),
        );
      }
    }));
  }
}
