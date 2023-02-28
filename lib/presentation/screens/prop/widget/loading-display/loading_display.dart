import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ContactLoading extends StatelessWidget {
  const ContactLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SizedBox(
        height: 500,
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 60),
          scrollDirection: Axis.vertical,
          itemCount: 4,
          itemBuilder: (context, index) {
            return const SkeletonAvatar(
              style: SkeletonAvatarStyle(width: double.infinity, height: 70),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 20);
          },
        ),
      ),
    );
  }
}
