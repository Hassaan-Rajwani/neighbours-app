import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'helper_api.g.dart';

@RestApi()
abstract class HelperApiService {
  factory HelperApiService(Dio dio) = _HelperApiService;

//Count

  @GET('/helper/job/count/{jobStatus}')
  Future<HttpResponse<String>> getJobCount({
    @Header('Authorization') required String authToken,
    @Path() required String jobStatus,
  });

//Jobs

  @GET('/helper/job/count/{jobId}')
  Future<HttpResponse<String>> getJob({
    @Header('Authorization') required String authToken,
    @Path() required String jobId,
  });

  @GET(
    '/helper/job/info/{status}?rating={rating}&size={size}&order={order}&pickup_type={pickupType}&distance={distance}',
  )
  Future<HttpResponse<String>> getAllJobs({
    @Header('Authorization') required String authToken,
    @Path() required String status,
    @Path() int? rating,
    @Path() String? size,
    @Path() String? order,
    @Path() String? pickupType,
    @Path() double? distance,
  });

//Bid

  @POST('/helper/job/bid/{bidId}')
  Future<HttpResponse<String>> postCreateBid({
    @Header('Authorization') required String authToken,
    @Body() required Map<String, dynamic> body,
    @Path() required String bidId,
  });

  @POST('/helper/job/reject/{rejectId}')
  Future<HttpResponse<String>> postRejectJob({
    @Header('Authorization') required String authToken,
    @Path() required String rejectId,
  });

//Package

  @POST('/helper/job/{jobId}/package')
  Future<HttpResponse<String>> postCreatePackage({
    @Header('Authorization') required String authToken,
    @Body() required Map<String, dynamic> body,
    @Path() required String jobId,
  });

  @GET('/helper/job/{jobId}/packages')
  Future<HttpResponse<String>> getPackage({
    @Header('Authorization') required String authToken,
    @Path() required String jobId,
  });

//Stripe

  @POST('/account/login-link')
  Future<HttpResponse<String>> postStripeLogin({
    @Header('Authorization') required String authToken,
    @Body() required Map<String, dynamic> body,
  });

  // Get All Helpers
  @GET('/helper/all?distance={miles}&rating={rating}')
  Future<HttpResponse<String>> getAllHelper({
    @Header('Authorization') required String authToken,
    @Path() required int miles,
    @Path() required int rating,
  });
}
