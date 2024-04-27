abstract class HelpersBidRepository {
  Future<String?> postCreateBid(
    String token,
    Map<String, dynamic> body,
    String bidId,
  );
  Future<String?> rejectJob(String token, String jobId);
}
