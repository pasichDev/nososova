import 'package:flutter/material.dart';

import '../style/text_style.dart';

class AppTextFiledDecoration {

  static defaultDecoration(String textHidden){
    return InputDecoration(
      filled: true,
      hintText: textHidden,
      hintStyle: AppTextStyles.textFieldHiddenStyle,
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
      fillColor: Colors.transparent,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
    );
  }
}