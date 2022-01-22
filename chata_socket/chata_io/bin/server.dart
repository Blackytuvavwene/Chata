import 'dart:convert';
import 'dart:io';
import 'package:socket_io/socket_io.dart';

void main(List<String> args) async {
  var io = Server();
  var nsp = io.of('/some');
  nsp.on('connection', (client) {
    print('connection /some');
    client.on('msg', (data) {
      print('data from /some => $data');
      client.emit('fromServer', "ok 2");
    });
  });
  var clients = {};
  io.on('connection', (client) {
    print('${client.id} connection');

    print('connection default namespace');
    client.on('login', (data) {
      print(' $data');
      clients[data] = client;
      //print(clients.toString());
      client.emit('fromServer', "ok");
    });

    print(clients);
  });
  io.listen(3000);
  print('server listen on $io');
}
