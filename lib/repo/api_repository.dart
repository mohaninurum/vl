abstract class ApiRepository {
  Future<Map<String, dynamic>> login();
  Future<Map<String, dynamic>> googleLogin();
  Future<Map<String, dynamic>> forgotPassword();
  Future<Map<String, dynamic>> signUp();
  Future<Map<String, dynamic>> getCategory();
  Future<Map<String, dynamic>> getClassListByCategory();
}
