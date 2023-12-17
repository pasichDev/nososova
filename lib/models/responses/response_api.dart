import 'package:nososova/models/responses/response.dart';
import 'package:nososova/models/seed.dart';

class ResponseApi<T> extends Response<T> {
  ResponseApi({
    T? value,
    Seed? seed,
    String? errors,
  }) : super(value: value, errors: errors);

  ResponseApi copyWith({
    T? value,
    String? errors,
  }) {
    return ResponseApi(
      value: value ?? this.value,
      errors: errors ?? this.errors,
    );
  }
}
