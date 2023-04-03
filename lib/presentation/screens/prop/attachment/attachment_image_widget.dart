import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ViewAttachment extends StatelessWidget {
  final String? imageUrl;
  final double height;
  final double width;
  const ViewAttachment(
      {super.key, required this.imageUrl, this.height = 60, this.width = 60});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: Colors.grey.shade300,
        height: height,
        width: width,
        child: (imageUrl == null || imageUrl!.isEmpty)
            ? const SizedBox.shrink()
            : CachedNetworkImage(
                imageUrl: imageUrl.toString(),
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                    color: Colors.grey.shade200,
                    child: const CircularProgressIndicator()),
                errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade200,
                    child: const CircularProgressIndicator()),
              ),
      ),
    );
  }
}

class SendersAttachment extends StatelessWidget {
  final String? imageUrl;
  final double height;
  final double width;
  const SendersAttachment(
      {super.key, required this.imageUrl, this.height = 60, this.width = 60});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: Colors.grey.shade300,
        height: height,
        width: width,
        child: (imageUrl == null || imageUrl!.isEmpty)
            ? const SizedBox.shrink()
            : CachedNetworkImage(
                imageUrl: imageUrl.toString(),
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
                    child: const CircularProgressIndicator()),
              ),
      ),
    );
  }
}
