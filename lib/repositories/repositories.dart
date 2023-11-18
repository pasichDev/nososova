import 'package:nososova/repositories/livecoinwatch_repository.dart';
import 'package:nososova/repositories/server_repository.dart';
import 'package:nososova/repositories/shared_repository.dart';
import 'package:nososova/utils/noso/nosocore.dart';

import 'file_repository.dart';
import 'local_repository.dart';

class Repositories {
  final LocalRepository localRepository;
  final ServerRepository serverRepository;
  final SharedRepository sharedRepository;
  final FileRepository fileRepository;
  final NosoCore nosoCore;
  final LiveCoinWatchRepository liveCoinWatchRepository;

  Repositories({
    required this.localRepository,
    required this.serverRepository,
    required this.sharedRepository,
    required this.fileRepository,
    required this.nosoCore,
    required this.liveCoinWatchRepository,
  });
}
