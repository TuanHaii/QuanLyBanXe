import '../../../shared/services/api_service.dart';
import '../models/quick_action_models.dart';

class SupportService {
  final ApiService apiService;

  SupportService({required this.apiService});

  Future<List<SupportItemModel>> fetchSupportItems() async {
    final response = await apiService.get('/support');
    final body = response.data;

    if (body is! Map<String, dynamic>) {
      throw Exception('Invalid response from support service');
    }

    // Backend returns { success: true, data: [...] }
    // data is directly the list of support items
    final items = body['data'] as List<dynamic>? ?? const [];
    return items
        .whereType<Map<String, dynamic>>()
        .map(SupportItemModel.fromJson)
        .toList(growable: false);
  }

  Future<SupportContactSubmissionModel> sendContact({
    required String name,
    required String email,
    required String message,
  }) async {
    final response = await apiService.post(
      '/support/contact',
      data: {
        'name': name.trim(),
        'email': email.trim(),
        'message': message.trim(),
      },
    );

    final body = response.data;
    if (body is! Map<String, dynamic>) {
      throw Exception('Invalid response from support contact');
    }

    // Backend returns { success: true, data: { id, name, email, ... } }
    final item = body['data'];
    if (item is! Map<String, dynamic>) {
      throw Exception('Support contact response not found');
    }

    return SupportContactSubmissionModel.fromJson(item);
  }

  Future<List<SupportContactSubmissionModel>> fetchMyRequests() async {
    final response = await apiService.get('/support/requests');
    final body = response.data;

    if (body is! Map<String, dynamic>) {
      throw Exception('Invalid response from support requests');
    }

    // Backend returns { success: true, data: [...] }
    final items = body['data'] as List<dynamic>? ?? const [];
    return items
        .whereType<Map<String, dynamic>>()
        .map(SupportContactSubmissionModel.fromJson)
        .toList(growable: false);
  }
}