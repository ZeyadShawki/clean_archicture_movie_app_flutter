import 'package:movies_app_clean_arch/core/network/error_message_model.dart';

class ServerException implements Exception {
  final ErrorMessageModel errorMessageModel;
  ServerException({required this.errorMessageModel});
}

class LocalServerException implements Exception {
  final ErrorMessageModel errorMessageModel;
  LocalServerException({required this.errorMessageModel});
}