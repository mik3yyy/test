import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/attachment/attachment_image_widget.dart';

class ImageAttachment extends StatelessWidget {
  final String attachmentUrl;
  final Function()? onPressed;
  final double height;
  final double width;
  final bool isSender;
  const ImageAttachment(
      {super.key,
      required this.attachmentUrl,
      this.onPressed,
      this.isSender = true,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              // <-- SEE HERE
              //title: const Text("Image"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    DialogAttachment(
                      image: attachmentUrl,
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Close',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 17.sp,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w500,
                          height: 1.5)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                if (!isSender) ...[
                  TextButton(
                    child: Text('Download',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 17.sp,
                            letterSpacing: 0.2,
                            fontWeight: FontWeight.w700,
                            height: 1.5)),
                    onPressed: onPressed,
                  ),
                ]
              ],
            );
          },
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Colors.grey.shade300,
          height: height,
          width: width,
          child: CachedNetworkImage(
            imageUrl: attachmentUrl,
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
      ),
    );
  }
}
