abstract class ApiRepository {
  Future<Map<String, dynamic>> login();
  Future<Map<String, dynamic>> googleLogin();
  Future<Map<String, dynamic>> forgotPassword();
  Future<Map<String, dynamic>> signUp();
  Future<Map<String, dynamic>> getCategory();
  Future<Map<String, dynamic>> getClassListByCategory();
  Future<Map<String, dynamic>> getClassDetail();
  Future<Map<String, dynamic>> getChapterVideo();
  Future<Map<String, dynamic>> getSubject();
  Future<Map<String, dynamic>> getNotesContentPdf();
  Future<Map<String, dynamic>> getTestPaperContentPdf();
  Future<Map<String, dynamic>> getQuizContent();
  Future<Map<String, dynamic>> postFeedback();
  Future<Map<String, dynamic>> getFeedbackList();
  Future<Map<String, dynamic>> getOrganization();
  Future<Map<String, dynamic>> getUserSubscription();
  Future<Map<String, dynamic>> getSubscriptionPlan();
  Future<Map<String, dynamic>> purchasePlan();
  Future<Map<String, dynamic>> userLogout();
  Future<Map<String, dynamic>> favoriteVideo();
  Future<Map<String, dynamic>> addFavoriteVideo();
  Future<Map<String, dynamic>> removeFavoriteVideo();
  Future<Map<String, dynamic>> tokenSave();
  Future<Map<String, dynamic>> getSearchList();
  Future<Map<String, dynamic>> quizDetail();
  Future<Map<String, dynamic>> notificationList();
}
