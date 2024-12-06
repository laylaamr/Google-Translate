import 'dart:convert';

import 'package:dio/dio.dart';

class TranslationApi{
 late Dio dio;
  String baseUrl ='https://free-google-translator.p.rapidapi.com/external-api/free-google-translator?from=en&to=es&query=Thank%20you%20for%20choosing%20me!';
  String apiKey='0ee011003dmsh11f1e68bb377c92p11d9a0jsne667d2a39ca2';
  TranslationApi(this.dio);
 Future<String?> translate(String text , String toLang , String fromLang) async{
   final url =
       '$baseUrl?from=$fromLang&to=$toLang&query=${Uri.encodeComponent(text)}';
   final headers = {
     'x-rapidapi-key': apiKey,
     'x-rapidapi-host': 'free-google-translator.p.rapidapi.com',
     'Content-Type': 'application/json',
   };
   final payload = {'translate': text};
 try {
   final response = await dio.post(
     url,
     options: Options(headers: headers),
     data: json.encode(payload),
   );
   if(response.statusCode == 200){
     final jsonData = response.data;
     return jsonData['translation'] ?? "No translation available";
   } else {
     print(
         'API response error: ${response.statusCode} - ${response.data}');
     return null;
   }
 }catch (e) {
   print('API call error: $e');
   return null;
 }
}


}
