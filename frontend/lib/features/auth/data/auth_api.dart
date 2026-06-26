import '../../../core/network/api_client.dart';

class AuthApi {
  AuthApi(this.client);

  final ApiClient client;

  Future<Map<String, dynamic>> login(Map<String, dynamic> payload) async {
    final response = await client.dio.post('/auth/login', data: payload);
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> signup(Map<String, dynamic> payload) async {
    final response = await client.dio.post('/auth/signup', data: payload);
    return Map<String, dynamic>.from(response.data as Map);
  }

  Future<Map<String, dynamic>> me() async {
    final response = await client.dio.get('/auth/me');
    return Map<String, dynamic>.from(response.data as Map);
  }
}
