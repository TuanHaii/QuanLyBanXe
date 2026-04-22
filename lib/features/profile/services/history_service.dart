import '../../../shared/services/api_service.dart';
import '../models/history_item_model.dart';

class HistoryService {
  final ApiService apiService;

  HistoryService({required this.apiService});

  Future<List<HistoryItemModel>> fetchHistory({String? query}) async {
    final response = await apiService.get(
      '/history',
      queryParameters: {
        if (query != null && query.trim().isNotEmpty) 'query': query.trim(),
      },
    );

    final body = response.data;
    if (body is! Map<String, dynamic>) {
      throw Exception('Invalid response from history service');
    }

    final items = body['data'] as List<dynamic>? ?? const [];
    return items
        .whereType<Map<String, dynamic>>()
        .map(HistoryItemModel.fromJson)
        .toList(growable: false);
  }
}
