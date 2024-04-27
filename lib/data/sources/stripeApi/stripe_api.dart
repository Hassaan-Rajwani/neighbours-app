import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'stripe_api.g.dart';

@RestApi()
abstract class StripeApiService {
  factory StripeApiService(Dio dio) = _StripeApiService;

  @POST('/account/login-link')
  Future<HttpResponse<String>> accountLogin({
    @Header('Authorization') required String authToken,
  });
}
