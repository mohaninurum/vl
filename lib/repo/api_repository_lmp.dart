import 'package:http/http.dart' as http;
import 'package:visual_learning/constant/api_url/ApiUrls.dart';

import 'api_repository.dart';
import 'api_service.dart';

class ApiRepositoryImpl implements ApiRepository {
  final http.Client _client;
  final String _baseUrl = 'https://jsonplaceholder.typicode.com/todos/1';

  ApiRepositoryImpl({http.Client? client}) : _client = client ?? http.Client();

  @override
  Future<Map<String, dynamic>> login({body}) {
    final response = ApiService().post(ApiUrls.loginUrl, body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> googleLogin({body}) {
    final response = ApiService().post(ApiUrls.googleLoginUrl, body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> forgotPassword({body}) {
    final response = ApiService().post(ApiUrls.forgotPasswordUrl, body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> signUp({body}) {
    final response = ApiService().post(ApiUrls.registerUrl, body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> getCategory({body}) {
    final response = ApiService().get(ApiUrls.categoryUrl, body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> getClassListByCategory({body}) {
    final response = ApiService().get(ApiUrls.classListBycategoryUrl, body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> getClassDetail({id, body}) {
    final response = ApiService().get("${ApiUrls.classDetailUrl}$id", body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> getChapterVideo({userID, id, body}) {
    final response = ApiService().get("${ApiUrls.videoChaperUrl}$id?user_id=$userID", body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> getSubject({id, body}) {
    final response = ApiService().get("${ApiUrls.classDetailUrl}$id", body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> getNotesContentPdf({id, body}) {
    final response = ApiService().get("${ApiUrls.getNotesPdfUrl}$id", body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> getTestPaperContentPdf({id, body}) {
    final response = ApiService().get("${ApiUrls.getTestPaperPdfUrl}$id", body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> getQuizContent({id, body}) {
    final response = ApiService().get("${ApiUrls.getQuizfUrl}$id", body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> postFeedback({body}) {
    final response = ApiService().post(ApiUrls.postFeedbackUrl, body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> getFeedbackList({body}) {
    final response = ApiService().get(ApiUrls.getFeedbackListUrl, body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> getOrganization({body}) {
    final response = ApiService().get(ApiUrls.getOrganizationtUrl, body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> getUserSubscription({id, body}) {
    final response = ApiService().get("${ApiUrls.getUserSubcriptionUrl}$id", body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> getSubscriptionPlan({body}) {
    final response = ApiService().get(ApiUrls.getSubscriptionPlanUrl, body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> purchasePlan({body}) {
    final response = ApiService().post(ApiUrls.PurchasePlanUrl, body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> userLogout({body}) {
    final response = ApiService().post(ApiUrls.usersLogoutUrl, body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> favoriteVideo({id, body}) {
    final response = ApiService().get("${ApiUrls.favouriteVideoUrl}$id", body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> addFavoriteVideo({body}) {
    final response = ApiService().post(ApiUrls.favouriteUrl, body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> removeFavoriteVideo({body}) {
    final response = ApiService().post(ApiUrls.removeFavouriteUrl, body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> tokenSave({body}) {
    final response = ApiService().post(ApiUrls.usersFcmTokenUserUrl, body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> getSearchList({body}) {
    final response = ApiService().post(ApiUrls.searchListUrl, body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> quizDetail({id, body}) {
    final response = ApiService().get("${ApiUrls.quizDetailUrl}$id", body);
    return response;
  }

  @override
  Future<Map<String, dynamic>> notificationList({id, body}) {
    final response = ApiService().get(ApiUrls.notificationListUrl, body);
    return response;
  }
}
