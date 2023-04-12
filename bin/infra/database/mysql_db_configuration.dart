import 'package:mysql1/mysql1.dart';
import '../../utils/custom_env.dart';
import 'db_configuration.dart';

class MySqlDBConfiguration implements DBConfiguration {
  MySqlConnection? _connection;

  @override
  Future<MySqlConnection> get connection async {
    _connection ??= await createConnection();
    if (_connection == null) {
      throw Exception('[ERROR/DB] -> Failed Create Connection');
    }

    return _connection!;
  }

  @override
  Future<MySqlConnection> createConnection() async =>
      await MySqlConnection.connect(
        ConnectionSettings(
          host: await CustomEnv.get<String>(key: 'DB_HOST'),
          port: await CustomEnv.get<int>(key: 'DB_PORT'),
          db: await CustomEnv.get<String>(key: 'DB_SCHEMA'),
          user: await CustomEnv.get<String>(key: 'DB_USER'),
          password: await CustomEnv.get<String>(key: 'DB_PASSWORD'),
        ),
      );

  @override
  execQuery(sql, [List? params]) async {
    var connection = await this.connection;
    return await connection.query(sql, params);
  }
}
