import 'package:nososova/models/responses/response.dart';
import 'package:nososova/models/seed.dart';

class ResponseApi<T> extends Response<T> {
  ResponseApi({
    T? value,
    Seed? seed,
    String? errors,
    int? errorCode,
  }) : super(value: value, errors: errors);

  ResponseApi copyWith({
    T? value,
    String? errors,
    int? errorCode,
  }) {
    return ResponseApi(
      value: value ?? this.value,
      errors: errors ?? this.errors,
      errorCode: errorCode ?? 0,
    );
  }
}
