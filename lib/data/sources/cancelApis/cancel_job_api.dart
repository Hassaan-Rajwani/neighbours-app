import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'cancel_job_api.g.dart';

@RestApi()
abstract class CancelJobApiService {
  factory CancelJobApiService(Dio dio) = _CancelJobApiService;

  @POST('/job/{jobid}/cancel')
  Future<HttpResponse<String>> postCancelJob({
    @Header('Authorization') required String authToken,
    @Body() required Map<String, dynamic> body,
    @Path() required String jobid,
  });
}
