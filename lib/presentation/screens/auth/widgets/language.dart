import 'package:flutter/material.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/languages.dart';

Language _selectedDialogLanguage = Languages.korean;

// It's sample code of Dialog Item.
Widget _buildDialogItem(Language language) => Row(
      children: <Widget>[
        Text(language.name),
        const SizedBox(width: 8.0),
        Flexible(child: Text("(${language.isoCode})"))
      ],
    );

void openLanguagePickerDialog(context, TextEditingController controller) =>
    showDialog(
      context: context,
      builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: LanguagePickerDialog(
              titlePadding: const EdgeInsets.all(8.0),
              searchCursorColor: Colors.pinkAccent,
              searchInputDecoration:
                  const InputDecoration(hintText: 'Search...'),
              isSearchable: true,
              title: const Text('Select your language'),
              onValuePicked: (Language language) {
                NotificationListener;
                _selectedDialogLanguage = language;
                controller.text = _selectedDialogLanguage.name;
                print(_selectedDialogLanguage.name);
                print(_selectedDialogLanguage.isoCode);
              },
              itemBuilder: _buildDialogItem)),
    );
