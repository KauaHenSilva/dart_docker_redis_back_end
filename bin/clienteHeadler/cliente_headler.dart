import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import '../redis/my_redis.dart';

class ClienteHandler {
  final MyRedis myRedis;

  ClienteHandler(this.myRedis);

  Future<Response> getClientes(Request request) async {
    try {
      final clientes = await myRedis.getRedisData('clientes');
      final clientesList = clientes.isNotEmpty ? json.decode(clientes) : [];

      return createResponse(
        json.encode({'clientes': clientesList}),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      return createResponse(
        'Erro ao obter clientes',
        statusCode: HttpStatus.internalServerError,
      );
    }
  }

  Future<Response> getClienteById(Request request, String id) async {
    try {
      final clientes = await myRedis.getRedisData('clientes');
      final clientesList = clientes.isNotEmpty ? json.decode(clientes) : [];

      final cliente = clientesList.firstWhere(
        (c) => c['id'] == int.parse(id),
        orElse: () => null,
      );

      if (cliente == null) {
        return createResponse(
          'Cliente não encontrado.',
          statusCode: HttpStatus.notFound,
        );
      }

      return createResponse(
        json.encode(cliente),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      return createResponse(
        'Erro ao obter cliente: ${e.toString()}',
        statusCode: HttpStatus.internalServerError,
      );
    }
  }

  Future<Response> postClientes(Request request) async {
    try {
      final body = await request.readAsString();
      final newClient = json.decode(body);

      if (newClient is! Map || !newClient.containsKey('name')) {
        return createResponse(
          'Validação falhou. Certifique-se de que o corpo da requisição é um objeto JSON com a chave "name".',
          statusCode: HttpStatus.badRequest,
        );
      }

      final existingData = await myRedis.getRedisData('clientes');
      List<dynamic> clientes =
          existingData.isEmpty ? [] : json.decode(existingData);

      final hasSameName =
          clientes.any((client) => client['name'] == newClient['name']);
      if (hasSameName) {
        return createResponse(
          'Cliente com o mesmo nome já existe.',
          statusCode: HttpStatus.conflict,
        );
      }

      final id = await myRedis.incrementRedisKey('next_client_id');
      newClient['id'] = id;
      clientes.add(newClient);

      await myRedis.setRedisData('clientes', json.encode(clientes));

      return createResponse(
        json.encode(newClient),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      return createResponse('Erro ao adicionar cliente: ${e.toString()}',
          statusCode: HttpStatus.internalServerError);
    }
  }

  Future<Response> putClientes(Request request, String id) async {
    try {
      final body = await request.readAsString();
      final updatedClient = json.decode(body);

      if (updatedClient is! Map || !updatedClient.containsKey('name')) {
        return createResponse(
            'Invalid client data. Ensure it is a JSON object with a "name" key.',
            statusCode: HttpStatus.badRequest);
      }

      final existingData = await myRedis.getRedisData('clientes');
      List<dynamic> clientes =
          existingData.isEmpty ? [] : json.decode(existingData);

      final index =
          clientes.indexWhere((client) => client['id'] == int.parse(id));
      if (index == -1) {
        return createResponse('Cliente não encontrado.',
            statusCode: HttpStatus.notFound);
      }

      clientes[index]['name'] = updatedClient['name'];

      await myRedis.setRedisData('clientes', json.encode(clientes));

      return createResponse(
        json.encode(clientes[index]),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      return createResponse('Erro ao atualizar cliente: ${e.toString()}',
          statusCode: HttpStatus.internalServerError);
    }
  }

  Future<Response> deleteClientes(Request request, String id) async {
    try {
      final existingData = await myRedis.getRedisData('clientes');
      List<dynamic> clientes =
          existingData.isEmpty ? [] : json.decode(existingData);

      final index =
          clientes.indexWhere((client) => client['id'] == int.parse(id));
      if (index == -1) {
        return createResponse('Cliente não encontrado.',
            statusCode: HttpStatus.notFound);
      }

      clientes.removeAt(index);

      await myRedis.setRedisData('clientes', json.encode(clientes));

      return createResponse('Cliente removido com sucesso.');
    } catch (e) {
      return createResponse('Erro ao remover cliente: ${e.toString()}',
          statusCode: HttpStatus.internalServerError);
    }
  }

  Response createResponse(
    String body, {
    int statusCode = HttpStatus.ok,
    Map<String, String>? headers,
  }) {
    return Response(statusCode, body: body, headers: headers);
  }
}
