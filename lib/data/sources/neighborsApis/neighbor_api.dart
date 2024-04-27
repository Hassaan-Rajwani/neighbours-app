import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'neighbor_api.g.dart';

@RestApi()
abstract class NeighborApiService {
  factory NeighborApiService(Dio dio) = _NeighborApiService;

//Favourite

  @GET('/user/favorites')
  Future<HttpResponse<String>> getFavouriteList({
    @Header('Authorization') required String authToken,
  });

  @POST('/user/favorites')
  Future<HttpResponse<String>> postFavourite({
    @Header('Authorization') required String authToken,
    @Body() required Map<String, dynamic> body,
  });

  @DELETE('/user/favorites/{id}')
  Future<HttpResponse<String>> deleteFavouriteUser({
    @Header('Authorization') required String authToken,
    @Path() required String id,
  });

  //Addresses

  @GET('/user/address')
  Future<HttpResponse<String>> getUserAddress({
    @Header('Authorization') required String authToken,
  });

  @POST('/user/address')
  Future<HttpResponse<String>> postAddAddress({
    @Header('Authorization') required String authToken,
    @Body() required Map<String, dynamic> body,
  });

  @PUT('/user/address/{id}')
  Future<HttpResponse<String>> putEditAddress({
    @Header('Authorization') required String authToken,
    @Body() required Map<String, dynamic> body,
    @Path() required String id,
  });

  @PUT('/user/address/{id}/active')
  Future<HttpResponse<String>> putSetAddress({
    @Header('Authorization') required String authToken,
    @Path() required String id,
  });

  @DELETE('/user/address/{id}')
  Future<HttpResponse<String>> deleteAddress({
    @Header('Authorization') required String authToken,
    @Path() required String id,
  });

  //Jobs

  @GET(
    '/neighbour/job/active?rating={rating}&size={size}&order={order}&pickup_type={pickupType}&distance={distance}',
  )
  Future<HttpResponse<String>> getActiveJobs({
    @Header('Authorization') required String authToken,
    @Path() int? rating,
    @Path() String? size,
    @Path() String? order,
    @Path() String? pickupType,
    @Path() double? distance,
  });

  @GET('/user/{id}/history?neighbr={isNeighbr}')
  Future<HttpResponse<String>> getJobHistory({
    @Header('Authorization') required String authToken,
    @Path() required String id,
    @Path() required bool isNeighbr,
  });

  @GET('/user/{id}/review?neighbr={isNeighbr}')
  Future<HttpResponse<String>> getUserReviews({
    @Header('Authorization') required String authToken,
    @Path() required String id,
    @Path() required bool isNeighbr,
  });

  @GET('/neighbour/job/pending')
  Future<HttpResponse<String>> getPendingJobs({
    @Header('Authorization') required String authToken,
  });

  @GET('/neighbour/job/closed')
  Future<HttpResponse<String>> getClosedJobs({
    @Header('Authorization') required String authToken,
  });

  @POST('/neighbour/job')
  Future<HttpResponse<String>> postCreateJob({
    @Header('Authorization') required String authToken,
    @Body() required Map<String, dynamic> body,
  });

  @PUT('/neighbour/job/{jobId}')
  Future<HttpResponse<String>> editJob({
    @Header('Authorization') required String authToken,
    @Path() required String jobId,
    @Body() required Map<String, dynamic> body,
  });

  @POST('/neighbour/job/{jobId}/close')
  Future<HttpResponse<String>> postClosedJob({
    @Header('Authorization') required String authToken,
    @Path() required String jobId,
  });

  @GET('/{name}/job/{jobId}')
  Future<HttpResponse<String>> getJobById({
    @Header('Authorization') required String authToken,
    @Path() required String jobId,
    @Path() required String name,
  });

  @POST('/neighbour/job/{jobId}/complete')
  Future<HttpResponse<String>> postCreateReview({
    @Header('Authorization') required String authToken,
    @Body() required Map<String, dynamic> body,
    @Path() required String jobId,
  });

  @POST('/job/{jobId}/review?neighbr={isNeighbr}')
  Future<HttpResponse<String>> cancelReview({
    @Header('Authorization') required String authToken,
    @Body() required Map<String, dynamic> body,
    @Path() required String jobId,
    @Path() required bool isNeighbr,
  });

  //Bid

  @GET('/neighbour/job/{jobId}/bids')
  Future<HttpResponse<String>> getBid({
    @Header('Authorization') required String authToken,
    @Path() required String jobId,
  });

  @POST('/neighbour/job/{jobId}/bid/{bidId}/accept')
  Future<HttpResponse<String>> postAcceptBid({
    @Header('Authorization') required String authToken,
    @Path() required String jobId,
    @Path() required String bidId,
  });

  @POST('/neighbour/job/{jobId}/bid/{bidId}/reject')
  Future<HttpResponse<String>> postRejectBid({
    @Header('Authorization') required String authToken,
    @Path() required String jobId,
    @Path() required String bidId,
  });

  // Package
  @GET('/neighbour/job/{jobId}/packages')
  Future<HttpResponse<String>> getNeighborsPackages({
    @Header('Authorization') required String authToken,
    @Path() required String jobId,
  });

  @POST('/neighbour/job/{jobId}/package/{packageId}/confirm')
  Future<HttpResponse<String>> confirmPackage({
    @Header('Authorization') required String authToken,
    @Path() required String jobId,
    @Path() required String packageId,
  });

  @POST('/tip-helper')
  Future<HttpResponse<String>> giveTip({
    @Header('Authorization') required String authToken,
    @Body() required Map<String, dynamic> body,
  });

  // CHAT APIS
  @GET('/user/chatrooms')
  Future<HttpResponse<String>> getChatRooms({
    @Header('Authorization') required String authToken,
  });

  @GET('/user/messages/{chatRoomId}')
  Future<HttpResponse<String>> getChatMessages({
    @Header('Authorization') required String authToken,
    @Path() required String chatRoomId,
  });

  // NOTIFICATION APIS
  @GET('/notifications?neighbr={isNeighbr}')
  Future<HttpResponse<String>> getNotificationList({
    @Header('Authorization') required String authToken,
    @Path() required bool isNeighbr,
  });

  @PATCH('/notifications/{notificationId}?neighbr={isNeighbr}')
  Future<HttpResponse<String>> markAsReadNotification({
    @Header('Authorization') required String authToken,
    @Path() required bool isNeighbr,
    @Path() required String notificationId,
  });

  @DELETE('/notifications/{notificationId}?neighbr={isNeighbr}')
  Future<HttpResponse<String>> deleteNotification({
    @Header('Authorization') required String authToken,
    @Path() required bool isNeighbr,
    @Path() required String notificationId,
  });
}
