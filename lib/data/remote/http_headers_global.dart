import 'package:http/http.dart' as http;

class HttpHeadersGlobal {
  static Future<http.Response> headerGetHttpWithToken(token, url) async {
    http.Response req = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $token',
      },
    );
    return req;
  }

  static Future<http.Response> headerPostHttpWithToken(token, url, body) async {
    http.Response req = await http.post(Uri.parse(url),
        headers: <String, String>{
          "Content-Type": 'application/json',
          "Authorization": 'Bearer $token',
        },
        body: body);
    return req;
  }
  static Future<http.Response> headerPostHttp(url, body) async {
    http.Response req = await http.post(Uri.parse(url),
        headers: <String, String>{
          "Content-Type": 'application/json',
        },
        body: body);
    return req;
  }
  static Future<http.Response> headerDeleteHttpWithToken(token, url) async {
    http.Response req = await http.delete(Uri.parse(url),
        headers: <String, String>{
          "Content-Type": 'application/json',
          "Authorization": 'Bearer $token',
        },);
    return req;
  }
  static Future<http.StreamedResponse> headerPostHttpWithTokenMultipart(String token,String url,String body,List<Map<String, String>>files) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['data'] = body;
    for(int i=0;i<files.length;i++){
      request.files.add(await http.MultipartFile.fromPath(
        files[i]["name"]!,
        files[i]["path"]!,
      ));
    }
    var response = await request.send();
    return response;
  }
  static Future<http.StreamedResponse> headerPuttHttpWithTokenMultipart(String token,String url,String body,List<Map<String, String>>files) async {
    var request = http.MultipartRequest('PUT', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['data'] = body;
    for(int i=0;i<files.length;i++){
      request.files.add(await http.MultipartFile.fromPath(
        files[i]["name"]!,
        files[i]["path"]!,
      ));
    }
    var response = await request.send();
    return response;
  }
}
