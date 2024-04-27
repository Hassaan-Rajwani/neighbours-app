import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'dispute_api.g.dart';

@RestApi()
abstract class DisputeApiService {
  factory DisputeApiService(Dio dio) = _DisputeApiService;

  @POST('/job/{jobid}/dispute')
  Future<HttpResponse<String>> postCreateDispute({
    @Header('Authorization') required String authToken,
    @Body() required Map<String, dynamic> body,
    @Path() required String jobid,
  });
}
