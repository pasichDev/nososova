
import 'package:nososova/models/app/responses/response.dart';
import 'package:nososova/models/seed.dart';

class ResponseNode<T> extends Response<T> {
  Seed seed;

  ResponseNode({
    T? value,
    Seed? seed,
    String? errors,
  }) : seed = seed ?? Seed(),
        super(value: value, errors: errors);

  ResponseNode copyWith({
    T? value,
    Seed? seed,
    String? errors,
  }) {
    return ResponseNode(
      value: value ?? this.value,
      seed: seed ?? this.seed,
      errors: errors ?? this.errors,
    );
  }
}


