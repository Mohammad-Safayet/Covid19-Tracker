import 'package:http/http.dart' as http;

class Https {
  var countryUri = Uri.http('corona.lmao.ninja', "/v2/countries");
  var worldUri = Uri.http('corona.lmao.ninja', "/v2/all");
  var statUri = Uri.http('corona.lmao.ninja', "/v2/historical");
  var proviceUri = Uri.http('corona.lmao.ninja', "/v2/jhucsse");
  
  http.Client client = http.Client();
}
