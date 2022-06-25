import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/components/app%20text%20theme/app_text_theme.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';
import 'package:kayndrexsphere_mobile/presentation/route/navigator.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/auth/create_acount/choose_account.dart';
import 'package:kayndrexsphere_mobile/presentation/utils/widget_spacer.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<OnBoardingScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final double height = 600.h;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 98.h, top: 39.h),
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider(
                items: [
                  //Image One
                  ImageWidget(
                    language: "Change Language?",
                    height: height,
                    image: AppImage.image1,
                    text1: "Welcome!",
                    text: "",
                  ),
                  //Image Two
                  ImageWidget(
                    language: "",
                    height: height,
                    image: AppImage.image2,
                    text1: "Invest Easily",
                    text: "",
                  ),

                  //Image Three
                  ImageWidget(
                    language: "",
                    height: height,
                    image: AppImage.image3,
                    text1: "Secure Pay",
                    text: "",
                  ),
                ],
                // items: imageSliders,
                carouselController: _controller,
                options: CarouselOptions(
                    height: height,
                    viewportFraction: 1.0,
                    autoPlay: true,
                    enlargeCenterPage: false,
                    autoPlayInterval: const Duration(seconds: 7),
                    // autoPlayInterval: Duration(milliseconds: 100),
                    // autoPlayAnimationDuration: Duration(milliseconds: 800),
                    // aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map(
                      (entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 12.w,
                            height: 12.h,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.appColor),
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.transparent
                                        : AppColors.appColor)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.1)),
                            // .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                _current == 1 || _current == 0 ? Space(150.h) : Space(56.w),
                _current == 2
                    ? GestureDetector(
                        onTap: () => context.navigate(const ChooseAccount()),
                        child: Text(
                          "Continue",
                          style: AppText.label(context, AppColors.appColor),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : const Text(""),
                Space(40.w),
              ],
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget(
      {Key? key,
      required this.height,
      required this.image,
      required this.text,
      required this.text1,
      required this.language})
      : super(key: key);

  final double height;
  final String image;
  final String text1;
  final String text;
  final String language;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 9.w, right: 29.w),
            child: Row(
              children: [
                Text(
                  language,
                  style: AppText.body3(context, AppColors.appColor),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                InkWell(
                  onTap: () => context.navigate(const ChooseAccount()),
                  child: Text(
                    "Skip",
                    style: AppText.body3(context, AppColors.appColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Space(130.h),
          Image(image: AssetImage(image)),
          Space(50.h),
          Center(
            child: Text(
              text1,
              style: AppText.body3(context, AppColors.appColor),
              textAlign: TextAlign.center,
            ),
          ),
          Space(5.h),
          Padding(
            padding: EdgeInsets.only(left: 38.w, right: 38.w),
            child: Text(
              text,
              style: AppText.label(context, AppColors.appColor),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

final List<String> imgList = [
  AppImage.image1,
  AppImage.image2,
  AppImage.image3,
];
