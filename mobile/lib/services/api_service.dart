import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/transaction.dart';

class ApiService {
  final String apiUrl = 'http://localhost:3000/transactions';

  Future<List<Transaction>> fetchTransactions() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Transaction.fromJson(data)).toList();
    } else {
      throw Exception('Erro ao carregar transações');
    }
  }

  Future<void> createTransaction(Transaction transaction) async {
    await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(transaction.toJson()),
    );
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await http.put(
      Uri.parse('$apiUrl/${transaction.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(transaction.toJson()),
    );
  }

  Future<void> deleteTransaction(String id) async {
    await http.delete(Uri.parse('$apiUrl/$id'));
  }
}
