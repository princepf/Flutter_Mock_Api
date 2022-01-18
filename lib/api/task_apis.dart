import 'package:http/http.dart' as http;

class TaskApi {
  static String baseUrl = 'https://61aeff882cdd9000174076ca.mockapi.io';

  static getTaskList() async {
    return await http.get(Uri.parse('$baseUrl/name'));
  }

  static addTask({required String? name, required String? url}) async {
    return await http.post(
      Uri.parse('$baseUrl/name'),
      body: {"name": "$name", "avatar": "$url"},
    );
  }

  static updateTask({
    required String? id,
    required String? name,
    required String? url,
  }) async {
    return await http.put(
      Uri.parse('$baseUrl/name/$id'),
      body: {"name": "$name", "avatar": "$url"},
    );
  }

  static deleteTask({required String? id}) async {
    return await http.delete(
      Uri.parse('$baseUrl/name/$id'),
    );
  }
}
