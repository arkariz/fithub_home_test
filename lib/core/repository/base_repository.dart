import 'package:fithub_home_test/core/exceptions/exception.dart';

class BaseRepository {
  Future<T> executeProcess<T>({
    required Future<T> Function() apiProcess,
    required Future<T?> Function() localProcess,
    Future<void> Function(T data)? saveToLocal,
    bool isLoadCacheOnly = false,
  }) async {
    final localResult = await localProcess();
    if (isLoadCacheOnly && localResult != null) return localResult;

    try {
      final apiResult = await apiProcess();
      if (saveToLocal == null) return apiResult;

      if (apiResult != localResult) {
        saveToLocal(apiResult);
      }
      return apiResult;
    } on NoInternetConnectionException {
      if (localResult == null) rethrow;
      return localResult;
    }
  }
}