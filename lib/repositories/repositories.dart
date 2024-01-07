import 'package:noso_dart/noso.dart';
import 'package:nososova/repositories/network_repository.dart';
import 'package:nososova/repositories/shared_repository.dart';

import 'file_repository.dart';
import 'local_repository.dart';

class Repositories {
  final LocalRepository localRepository;
  final NetworkRepository networkRepository;
  final SharedRepository sharedRepository;
  final FileRepository fileRepository;
  final Noso nosoCore;

  Repositories({
    required this.localRepository,
    required this.networkRepository,
    required this.sharedRepository,
    required this.fileRepository,
    required this.nosoCore,
  });
}
