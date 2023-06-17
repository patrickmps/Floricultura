import 'package:mysql1/mysql1.dart';
import 'package:web_api/env/env.dart';
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
          host: Env.dbHost,
          port: int.parse(Env.dbPort),
          db: Env.dbSchema,
          user: Env.dbUser,
          password: Env.dbPassword,
        ),
      );

  @override
  execQuery(sql, [List? params]) async {
    var connection = await this.connection;
    return await connection.query(sql, params);
  }
}
