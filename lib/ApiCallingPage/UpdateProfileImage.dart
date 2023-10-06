
import 'package:http/http.dart' as http;
import 'package:wherenxnew1/ApiImplement/ApiUrl.dart';

class UpdateProfileImage{

  Future<http.StreamedResponse?> updateImageProfile(String userId,file) async {

    http.StreamedResponse? response;

    // try{
    //
    //   response = await http.post(Uri.parse(ApiUrl.update_user_profile_photo),
    //       headers: <String,String>{
    //         'Content-Type': 'application/json; charset=UTF-8',
    //       },
    //       body: jsonEncode(<String,dynamic>{
    //
    //         'user_id' : userId,'photo' : file
    //
    //       }));
    //
    // }catch(e){
    //   e.toString();
    //   print(e);
    // }
    //
    // return response;

    try{

      var request = http.MultipartRequest('POST', Uri.parse(ApiUrl.update_user_profile_photo));
      request.fields.addAll({'user_id': userId});
      request.files.add(await http.MultipartFile.fromPath('photo', file));
      response = await request.send();
      //response = await request.send();

    }catch(e){

      e.toString();
        print(e);

    }
    return response;
  }

}