import 'package:flutter/material.dart';
import 'package:vdo_chit_app/locator.dart';
import 'package:vdo_chit_app/ui/preference_model.dart';

import '../core/enums_and_variables/info_state.dart';
import '../core/shared/ui/color_scheme/theme.dart';
import '../core/shared/ui/language/language.dart';


class BaseModel extends ChangeNotifier{
   ViewState _state;

   PreferenceModel preference = locator<PreferenceModel>();

   ViewState get state => _state;
   CustomColorScheme get theme => preference.theme;
   AppLanguage get language => preference.language;
   
   void setState(ViewState state){
      this._state = state;
      notifyListeners();
   }

   void setTamilLanguage(){
      preference.setTamilLanguage();
      notifyListeners();
   }

   void setEnglishLanguage(){
      preference.setEnglishLanguage();
      notifyListeners();
   }

   void setRegularTheme(){
      preference.setRegularTheme();
      notifyListeners();
   }

   void setDarkTheme(){
      preference.setDarkTheme();
      notifyListeners();
   }
}