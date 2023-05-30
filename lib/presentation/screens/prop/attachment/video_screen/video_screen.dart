import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/home/home.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/download_file.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulHookConsumerWidget {
  final String attachmentUrl;
  final bool isSender;
  const VideoScreen(
      {super.key, required this.attachmentUrl, this.isSender = true});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoScreenState();
}

class _VideoScreenState extends ConsumerState<VideoScreen> {
  late VideoPlayerController _videoPlayerController;
  bool isLoading = true;
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.attachmentUrl)
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.

        _videoPlayerController.play();
        _videoPlayerController.setLooping(false);
        _videoPlayerController.setVolume(4.0);
        isLoading = false;
        // videoListner();
        setState(() {});

        // Ensure the first frame is shown after the video is initialized.
      });
    {}

    super.initState();
  }

  Future<String> getDownloadFolderPath() async {
    return await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
  }

  Future<bool> getStoragePremission() async {
    return await Permission.storage.request().isGranted;
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final downloadAttachment = ref.watch(downloadAttachmentProvider);
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
                onPressed: () async {
                  if (await getStoragePremission()) {
                    ref
                        .read(downloadAttachmentProvider.notifier)
                        .downloadAttachment(widget.attachmentUrl, "mp4");
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
      body: Column(
        children: [
          InnerPageLoadingIndicator(loadingStream: isLoading),
          Space(70.h),
          Center(
            child: _videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  )
                : Container(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _videoPlayerController.value.isPlaying
                ? _videoPlayerController.pause()
                : _videoPlayerController.play();
          });
        },
        child: Icon(
          _videoPlayerController.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow,
        ),
      ),
    );
  }
}
