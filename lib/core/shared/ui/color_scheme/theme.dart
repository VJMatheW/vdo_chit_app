import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class CustomColorScheme{
   Color primary;
   Color secondary;
   Color background;
   // Color textPrimary();
   // Color textSecondary();
} 

class RegularTheme implements CustomColorScheme{
   Color primary = Color(0xFFD62020);
   Color secondary = Color(0xFFE35A5A);
   Color background = Colors.yellow;
}

class DarkTheme implements CustomColorScheme{
   Color primary = Color(0xFF112233);
   Color secondary = Color(0xFFE35A5A);
   Color background = Colors.grey[600];
}