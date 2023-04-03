import 'package:flutter/material.dart';
import 'package:kayndrexsphere_mobile/presentation/components/color/value.dart';

class SearchBox extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onTextEntered;
  const SearchBox({Key? key, this.hintText = "Search", this.onTextEntered})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        cursorColor: Colors.black,
        onChanged: onTextEntered,
        decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            focusColor: AppColors.appBgColor,
            filled: true,
            fillColor: Colors.grey.shade100,
            hintText: hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            prefixIcon: const Icon(
              Icons.search,
              size: 24,
              color: AppColors.appColor,
            )));
  }
}
