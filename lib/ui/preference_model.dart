import 'package:flutter/material.dart';

import '../core/shared/ui/color_scheme/theme.dart';
import '../core/shared/ui/language/language.dart';

class PreferenceModel extends ChangeNotifier {
   CustomColorScheme _theme;
   AppLanguage _language;

   PreferenceModel(){
      _theme = RegularTheme();
      _language = English();
   }

   CustomColorScheme get theme => _theme;
   AppLanguage get language => _language;

   void setTamilLanguage(){
      _language = Tamil();
   }

   void setEnglishLanguage(){
      _language = English();
   }

   void setRegularTheme(){
      _theme = new RegularTheme();
      notifyListeners();
   }

   void setDarkTheme(){
      _theme = new DarkTheme();
      notifyListeners();
   }
}