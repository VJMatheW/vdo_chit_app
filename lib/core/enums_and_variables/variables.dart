import 'package:flutter/foundation.dart' as Foundation;

class Vars {
   static const String API_HOST = Foundation.kReleaseMode 
                     ? "http://staging.vdoservices.in/chitapp/api"
                     : "http://192.168.1.28:3000/api" ;
}
