import '../../locator.dart';
import '../shared/services/http_service.dart';

export 'chit_dataaccess.dart';
export 'chit_template_dataaccess.dart';

class BaseDataAccess{
   final HttpService _httpClient = locator<HttpService>();

   HttpService get httpClient => _httpClient;

   void handleResponseCode(HttpResponse response, int expectedStatusCode){
      if(response.statusCode != expectedStatusCode){
         throw Exception({ "errorCode": response.statusCode, "error": response.body['data']['error'] });
      }
   }
}