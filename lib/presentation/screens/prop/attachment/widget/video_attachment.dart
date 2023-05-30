import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoAttachment extends StatefulHookConsumerWidget {
  final String attachmentUrl;
  final Function()? onPressed;
  const VideoAttachment(
      {super.key, required this.attachmentUrl, this.onPressed});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VideoAttachmentState();
}

class _VideoAttachmentState extends ConsumerState<VideoAttachment> {
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.attachmentUrl)
      ..initialize();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Stack(
        children: [
          FittedBox(
            fit: BoxFit.cover,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5)),
              child: VideoPlayer(_videoPlayerController),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.play_circle_filled_outlined),
          )
        ],
      ),
    );
  }
}
