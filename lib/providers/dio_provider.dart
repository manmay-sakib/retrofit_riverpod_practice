import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit_riverpod_practice/api/api_service.dart';

final dioProvider = Provider(
  (ref) => Dio(
    BaseOptions(contentType: "application/json"),
  ),
);

final apiClientProvider = Provider(
  (ref) => ApiClient(
    ref.watch(dioProvider),
  ),
);
