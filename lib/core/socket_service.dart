import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;

  IO.Socket? _socket;
  final _storage = FlutterSecureStorage();
  bool _isInitialized = false;

  SocketService._internal();

  Future<void> initSocket() async {
    if (_isInitialized) return;

    try {
      String token = await _storage.read(key: 'token') ?? '';
      _socket = IO.io(
        'http://10.0.2.2:3000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({'Authorization': 'Bearer $token'})
            .build(),
      );

      _socket?.connect();
      _socket?.onConnect((_) {
        print('Socket connected : ${_socket?.id}');
        _isInitialized = true;
      });

      _socket?.onConnectError((error) {
        print('Socket connection error: $error');
        _isInitialized = false;
      });

      _socket?.onDisconnect((_) {
        print('Socket disconnected');
        _isInitialized = false;
      });
    } catch (e) {
      print('Error initializing socket: $e');
    }
  }

  IO.Socket get socket {
    if (_socket == null) {
      throw StateError('Socket not initialized. Call initSocket() first.');
    }
    return _socket!;
  }

  bool get isConnected => _socket?.connected ?? false;

  void reconnect() {
    _socket?.connect();
  }

  void disconnect() {
    _socket?.disconnect();
  }
}