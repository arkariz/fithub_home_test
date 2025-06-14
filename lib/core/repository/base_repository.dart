import 'package:fithub_home_test/core/exceptions/exception.dart';

class BaseRepository {
  Future<T> executeProcess<T>({
    required Future<T> Function() apiProcess,
    Future<void> Function(T data)? saveToLocal,
    Future<T?> Function()? localProcess,
    bool isLocalFirst = false,
    bool forceRefresh = false,
  }) async {
    if (isLocalFirst && !forceRefresh && localProcess != null) {
      final localResult = await localProcess();
      if (localResult != null) return localResult;
    }

    try {
      final apiResult = await apiProcess();
      if (saveToLocal != null) {
        await saveToLocal(apiResult);
      }
      return apiResult;
    } on NoInternetConnectionException {
      if (localProcess == null) rethrow;
      
      final localResult = await localProcess();
      if (localResult == null) rethrow;
      return localResult;
    }
  }
}