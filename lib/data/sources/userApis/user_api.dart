import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApiService {
  factory UserApiService(Dio dio) = _UserApiService;

  @GET('/user/profile')
  Future<HttpResponse<String>> getProfile({
    @Header('Authorization') required String authToken,
  });
  @GET('/user/{id}/profile')
  Future<HttpResponse<String>> getOtherProfile({
    @Header('Authorization') required String authToken,
    @Path() required String id,
  });

  @PUT('/user/profile')
  Future<HttpResponse<String>> updateProfile({
    @Header('Authorization') required String authToken,
    @Body() required Map<String, dynamic> body,
  });
  @PUT('/user/deactivate')
  Future<HttpResponse<String>> deactivateAccount({
    @Header('Authorization') required String authToken,
    @Body() required Map<String, dynamic> body,
  });
  @POST('/user/logout')
  Future<HttpResponse<String>> logout({
    @Header('Authorization') required String authToken,
  });
  @POST('/user/delete')
  Future<HttpResponse<String>> deleteAccount({
    @Header('Authorization') required String authToken,
  });
  @POST('/user/fcm_token')
  Future<HttpResponse<String>> postFcm({
    @Header('Authorization') required String authToken,
    @Body() required Map<String, dynamic> body,
  });
}
