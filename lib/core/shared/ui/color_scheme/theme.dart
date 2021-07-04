import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class CustomColorScheme{
   Color primary;
   Color secondary;
   Color background;

   Color cardShadow;
   
   Color white;
   Color black;

   Color textPrimary;
   Color inputText;
   Color inputTextHint;

   // Color textSecondary();
} 

class RegularTheme implements CustomColorScheme{
   Color primary = Color(0xFF2781E7);
   Color secondary = Color(0x000000).withAlpha(125);
   Color background = Colors.white;

   Color cardShadow = Colors.black26;
   
   Color white = Color(0xFFFFFFFF);
   Color black = Color(0xFF000000);

   Color textPrimary = Color(0xFF2F69DE);
   Color inputText = Color(0xFF000000);
   Color inputTextHint = Color(0xFF000000).withAlpha(125);
}

class DarkTheme implements CustomColorScheme{
   Color primary = Color(0xFF112233);
   Color secondary = Color(0xFFE35A5A);
   Color background = Colors.grey[600];

   Color cardShadow = Colors.black26;

   Color white = Color(0xFFFFFFFF);
   Color black = Color(0xFF000000);

   Color textPrimary = Color(0xFF2F69DE);
   Color inputText = Color(0xFF000000);
   Color inputTextHint = Color(0xFF000000).withAlpha(125);
}