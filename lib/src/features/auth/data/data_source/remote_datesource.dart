import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer' as dev;

/// Service class for handling external API calls
class RemoteDataSource   {
  /// Singleton instance of RemoteDataSource
  static final RemoteDataSource instance = RemoteDataSource._internal();

  /// Dio client for making HTTP requests
  late final Dio _dio;

  /// Private constructor for singleton pattern
  RemoteDataSource._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: dotenv.env['NEXT_PUBLIC_API_URL']!,
      headers: {
        'Content-Type': 'application/json',
        'API-Token': dotenv.env['API_TOKEN']!,
      },
    ));

    // Add logging interceptor
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (object) => dev.log(object.toString(), name: 'ApiService'),
    ));
  }

  /// Factory constructor that returns the singleton instance
  factory RemoteDataSource() => instance;

  /// Searches for customers in the external system
  ///
  /// Parameters:
  /// - [firstName]: Optional first name to search for
  /// - [lastName]: Optional last name to search for
  /// - [email]: Optional email to search for
  ///
  /// Returns a List of customer data if found
  ///
  /// Throws [DioException] if the request fails
  Future<List<Map<String, dynamic>>> searchCustomers({
    String? firstName,
    String? lastName,
    String? email,
  }) async {
    try {
      final response = await _dio.post(
        '/get_customers',
        data: {
          'customer_number': null,
          'firstname': firstName,
          'lastname': lastName,
          'companyname': null,
          'street': null,
          'housenumber': null,
          'postal_code': null,
          'city': null,
          'external_customer_number': null,
        },
      );

      if (response.data['status'] == 600) {
        throw DioException(
          requestOptions: response.requestOptions,
          error: 'At least one search field must be set',
          type: DioExceptionType.badResponse,
          response: response,
        );
      }

      if (response.data['status'] != 1) {
        throw DioException(
          requestOptions: response.requestOptions,
          error: 'API request failed',
          type: DioExceptionType.badResponse,
          response: response,
        );
      }

      final customers = List<Map<String, dynamic>>.from(response.data['data']);

      // If email is provided, filter results by email
      if (email != null) {
        return customers
            .where((customer) => customer['email'] == email)
            .toList();
      }

      return customers;
    } catch (e) {
      dev.log('Error in searchCustomers: ${e.toString()}',
          name: 'ApiService', error: e);
      rethrow;
    }
  }
}
