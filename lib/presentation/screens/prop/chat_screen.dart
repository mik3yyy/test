// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:io' show File, Platform;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kayndrexsphere_mobile/Data/controller/controller/generic_state_notifier.dart';
import 'package:kayndrexsphere_mobile/Data/model/Dialog/all_dialog.dart';
import 'package:kayndrexsphere_mobile/Data/model/auth/res/new_sign_in_res.dart';
import 'package:kayndrexsphere_mobile/presentation/components/AppSnackBar/snackbar/app_snackbar_view.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/components/extension/string_extension.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/attachment/attachment_image_widget.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/attachment/pick_attachment.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/models/chat_model.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/models/my_event.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/download_file.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/send_message.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/vm/stream_messages.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/settings/profile/user_profile/user_profile_db.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:video_player/video_player.dart';
import '../../components/app text theme/app_text_theme.dart';

class ChatScreen extends StatefulHookConsumerWidget {
  final Datum datum;
  const ChatScreen({Key? key, required this.datum}) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  VideoPlayerController? _videoPlayerController;
  ScrollController scrollController = ScrollController();
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  dynamic eventVal = "";
  String uuid = "";
  String start = "";
  int isSelected = 0;
  List<ChatModel> receivedMsgs = [];

  // void _scrollToBottom() {
  //   if (scrollController.hasClients) {
  //     scrollController.jumpTo(scrollController.position.maxScrollExtent);
  //   }
  // }

  void initialize() async {
    try {
      await pusher.init(
          apiKey: "325615ce327a7a9931ed",
          cluster: "eu",
          logToConsole: true,
          onEvent: onEvent);
      await pusher.subscribe(
        channelName: 'message_${widget.datum.dialog?.uuid}',
        onSubscriptionSucceeded: (val) {},
      );

      await pusher.connect();
    } catch (e) {}
  }

  void onEvent(PusherEvent event) async {
    try {
      eventVal = event.data;
      if (Platform.isAndroid) {
        if (event.data.isEmpty) {
          return;
        } else {
          var resmap = json.decode(event.data);

          var res = MyEvent.fromJson(resmap);
          ref.read(localMsgProvider.notifier).addFromPusher(res);
        }
      } else {
        if (event.data == "{}") {
          return;
        } else {
          var resmap = json.decode(event.data);

          var res = MyEvent.fromJson(resmap);

          ref.read(localMsgProvider.notifier).addFromPusher(res);
        }
      }
    } catch (e) {
      if (mounted) {
        throw e.toString();
      }
    }
  }

  Future<String> getDownloadFolderPath() async {
    return await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
  }

  Future<bool> getStoragePremission() async {
    return await Permission.storage.request().isGranted;
  }

  @override
  void initState() {
    start = "start";
    // _scrollToBottom();
    // ref.read(localMsgProvider.notifier).getRemoteList(widget.datum.dialog!.id!);
    Future.delayed(const Duration(milliseconds: 2000), () {
      initialize();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    final savedUser = ref.watch(savedUserProvider);
    // final newMessages = ref.watch(localMsgProvider);
    final sendMessage = ref.watch(sendMessageProvider);
    final serverMsg = ref.watch(serverMsgProvider(widget.datum.dialog!.id!));
    final message = useTextEditingController(text: "");
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    final pickedFile = useState("");

    ref.listen<RequestState>(sendMessageProvider, (_, value) {
      if (value is Success<GenericRes>) {
        ref.invalidate(serverMsgProvider(widget.datum.dialog!.id!));
      }
      if (value is Error) {}
    });
    ref.listen<RequestState>(downloadAttachmentProvider, (_, value) {
      if (value is Success<String>) {
        AppSnackBar.showAppToast(ToastGravity.CENTER,
            message: "File Downloaded");
      }
      if (value is Error) {
        setState(() => isSelected = 0);
      }
    });

    return Scaffold(
        backgroundColor: AppColors.appColor,
        body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                const Space(30),
                Row(
                  children: [
                    const BackButton(
                      color: Colors.white,
                    ),
                    // const Space(30),
                    ChatContactImage(datum: widget.datum),
                    const Space(20),
                    Text(
                      "${widget.datum.privateDialogOtherUser!.firstName!.capitalize().toString()} ${widget.datum.privateDialogOtherUser!.lastName!.capitalize().toString()}",
                      style: AppText.body2Bold(
                        context,
                        AppColors.whiteColor,
                        25.sp,
                      ),
                    )
                    //             )
                  ],
                ),
                const Space(25),
                Flexible(
                    child: Container(
                  width: screenW,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45.r)),
                  ),
                  child: serverMsg.when(
                      data: (data) {
                        if (data.data!.messages!.isEmpty) {
                          return Container(
                            height: screenH,
                            padding:
                                const EdgeInsets.fromLTRB(120, 250, 120, 250),
                            child: Center(
                              child: Text(
                                "Loading Chats",
                                textAlign: TextAlign.center,
                                style: AppText.header2(
                                    context, AppColors.appColor, 17.sp),
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 20),
                            child: ListView.separated(
                              controller: scrollController,
                              padding: const EdgeInsets.only(bottom: 40),
                              itemCount: data.data!.messages!.length,
                              itemBuilder: (context, index) {
                                final message = data.data!.messages![index];
                                DateTime date = message.sentAt!;
                                // String dateCreated =
                                //     DateFormat('dd/MM/yyyy hh:mm a').format(date);
                                String formattedTime =
                                    DateFormat('kk:mm:a').format(date);

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (message.from?.email ==
                                        savedUser.email) ...[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              if (message
                                                  .attachments!.isNotEmpty) ...[
                                                SendersAttachment(
                                                  height: 120,
                                                  width: 120,
                                                  file: message.attachments,
                                                ),
                                              ],
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                constraints: BoxConstraints(
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.6),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(16),
                                                      topRight:
                                                          Radius.circular(16),
                                                      bottomLeft:
                                                          Radius.circular(12),
                                                      bottomRight:
                                                          Radius.circular(0),
                                                    )),
                                                child: Text(
                                                  message.message.toString(),
                                                ),
                                              ),
                                              const Space(10),
                                              Text(formattedTime,
                                                  style: AppText.body2(
                                                      context,
                                                      Colors.grey.shade400,
                                                      12.sp)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ] else ...[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (message
                                                  .attachments!.isNotEmpty) ...[
                                                ViewAttachment(
                                                  height: 120,
                                                  width: 120,
                                                  file: message.attachments,
                                                ),
                                              ],
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                constraints: BoxConstraints(
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.6),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(16),
                                                      topRight:
                                                          Radius.circular(16),
                                                      bottomLeft:
                                                          Radius.circular(0),
                                                      bottomRight:
                                                          Radius.circular(12),
                                                    )),
                                                child: Text(
                                                  message.message.toString(),
                                                ),
                                              ),
                                              const Space(10),
                                              Text(formattedTime,
                                                  style: AppText.body2(
                                                      context,
                                                      Colors.grey.shade400,
                                                      12.sp)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ]
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 20,
                                );
                              },
                            ),
                          );
                        }
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => Container(
                            height: screenH,
                            padding:
                                const EdgeInsets.fromLTRB(120, 250, 120, 250),
                            child: Center(
                              child: Text(
                                "Loading Chats",
                                textAlign: TextAlign.center,
                                style: AppText.header2(
                                    context, AppColors.appColor, 17.sp),
                              ),
                            ),
                          )),
                )),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.white,
                  width: screenW,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (pickedFile.value.isNotEmpty) ...[
                        Space(30.h),
                        if (pickedFile.value.contains("pdf")) ...[
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: SfPdfViewer.file(
                                  File(pickedFile.value),
                                  pageLayoutMode: PdfPageLayoutMode.single,
                                ),
                              ),
                              Positioned(
                                // left: 40,
                                right: -5,
                                top: -10,
                                child: InkWell(
                                  onTap: () {
                                    pickedFile.value = "";
                                  },
                                  child: const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.red,
                                    child: Icon(
                                      Icons.close,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ] else if (pickedFile.value.contains(".mp4")) ...[
                          if (_videoPlayerController != null) ...[
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                FittedBox(
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: VideoPlayer(_videoPlayerController!),
                                  ),
                                ),
                                Positioned(
                                  // left: 40,
                                  right: -5,
                                  top: -10,
                                  child: InkWell(
                                    onTap: () {
                                      pickedFile.value = "";
                                    },
                                    child: const CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.red,
                                      child: Icon(
                                        Icons.close,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ] else ...[
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                color: Colors.grey.shade300,
                                child: Image.file(
                                  File(pickedFile.value),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                // left: 40,
                                right: -5,
                                top: -10,
                                child: InkWell(
                                  onTap: () {
                                    pickedFile.value = "";
                                  },
                                  child: const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.red,
                                    child: Icon(
                                      Icons.close,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ]
                      ],
                      Container(
                        // width: screenW / 2,
                        margin: EdgeInsets.only(bottom: 13.w, top: 10),
                        padding: EdgeInsets.only(left: 13.w, right: 13.w),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(7.r),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  var result = await ref
                                      .read(fileProvider)
                                      .addAttachment();
                                  pickedFile.value = result;
                                  if (pickedFile.value.contains("mp4")) {
                                    final _video = File(pickedFile.value);
                                    if (_video.path.isEmpty) return;
                                    _videoPlayerController =
                                        VideoPlayerController.file(_video)
                                          ..initialize();
                                  }
                                },
                                icon: const Icon(Icons.attach_file)),
                            Flexible(
                              child: TextFormField(
                                controller: message,
                                decoration: const InputDecoration(
                                  hintText: 'Send Message',
                                  border: InputBorder.none,
                                ),
                                onTap: () {
                                  // if (scrollController.hasClients) {
                                  //   // final position =
                                  //   //     scrollController.position.maxScrollExtent;
                                  //   scrollController.animateTo(
                                  //     1800.9090909090909,
                                  //     duration: const Duration(seconds: 1),
                                  //     curve: Curves.easeOut,
                                  //   );
                                  // }
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                if (message.text.isEmpty &&
                                        pickedFile.value.isNotEmpty ||
                                    message.text.isEmpty) {
                                  AppSnackBar.showAppToast(ToastGravity.CENTER,
                                      message: "Add a message");
                                } else {
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  ref
                                      .read(sendMessageProvider.notifier)
                                      .sendMessage(widget.datum.dialog!.id!,
                                          message.text, pickedFile.value);
                                  pickedFile.value = "";
                                  message.clear();
                                }
                              },
                              icon: sendMessage is Loading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Icon(Icons.send),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}

class ChatContactImage extends StatelessWidget {
  final Datum datum;
  const ChatContactImage({Key? key, required this.datum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (datum.privateDialogOtherUser!.profilePicture == null) {
      return SizedBox(
        height: 50,
        width: 50,
        child: Image.asset(
          AppImage.profile,
          scale: 5,
          fit: BoxFit.cover,
        ),
      );
    } else if (datum
        .privateDialogOtherUser!.profilePicture!.imageUrl!.isEmpty) {
      return SizedBox(
        height: 50,
        width: 50,
        child: Image.asset(
          AppImage.profile,
          scale: 5,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return SizedBox(
        height: 40,
        width: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(300.0),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => SizedBox(
              height: 50,
              width: 50,
              child: Image.asset(
                AppImage.profile,
                scale: 5,
                fit: BoxFit.cover,
              ),
            ),
            imageUrl: datum.privateDialogOtherUser!.profilePicture!.imageUrl
                .toString(),
          ),
        ),
      );
    }
  }
}
