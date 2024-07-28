import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import './redis/my_redis.dart';
import './clienteHeadler/cliente_headler.dart';

void main() {
  final app = App();
  app();
}

class App {
  final MyRedis myRedis = MyRedis();
  final ClienteHandler clienteHandler;

  App() : clienteHandler = ClienteHandler(MyRedis());

  Handler get router {
    final router = Router()
      ..get('/clientes', clienteHandler.getClientes)
      ..get('/clientes/<id>', clienteHandler.getClienteById)
      ..post('/clientes', clienteHandler.postClientes)
      ..put('/clientes/<id>', clienteHandler.putClientes)
      ..delete('/clientes/<id>', clienteHandler.deleteClientes);

    return Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(handleErrors())
        .addHandler(router.call);
  }

  Future<void> call() async {
    final ip = InternetAddress.anyIPv4;
    final port = int.parse(Platform.environment['PORT'] ?? '8080');
    final server = await serve(router, ip, port);
    print('Server listening on port ${server.port}');
  }

  Middleware handleErrors() {
    return (innerHandler) {
      return (request) async {
        try {
          return await innerHandler(request);
        } catch (e, stackTrace) {
          print('Erro não tratado: $e\n$stackTrace');
          return Response.internalServerError(
              body: 'Erro interno do servidor. Tente novamente mais tarde.');
        }
      };
    };
  }
}
