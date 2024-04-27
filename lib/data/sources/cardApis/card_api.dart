import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'card_api.g.dart';

@RestApi()
abstract class CardApiService {
  factory CardApiService(Dio dio) = _CardApiService;

  @GET('/user/card/intent')
  Future<HttpResponse<String>> addCard({
    @Header('Authorization') required String authToken,
  });

  @GET('/user/cards')
  Future<HttpResponse<String>> getCards({
    @Header('Authorization') required String authToken,
  });

  @PUT('/user/card/{id}')
  Future<HttpResponse<String>> updateCard({
    @Header('Authorization') required String authToken,
    @Path() required String id,
  });

  @DELETE('/user/card/{id}')
  Future<HttpResponse<String>> deleteCard({
    @Header('Authorization') required String authToken,
    @Path() required String id,
  });
}
