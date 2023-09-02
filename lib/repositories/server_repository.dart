import 'package:nososova/services/server_service.dart';

class ServerRepository {
  final ServerService serverService;

  ServerRepository(this.serverService);
/*
  Future<List<ServerData>> fetchServerData() async {
    // Використовуйте serverService для отримання даних з сервера
    final serverData = await serverService.fetchDataFromServer();
    return serverData;
  }

  */
}
