import 'package:hive/hive.dart';
import 'package:chat_app_django_flutter/models/user.dart';

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0; // Unique identifier for the type

  @override
  User read(BinaryReader reader) {
    // Implement reading from Hive box
    return User(
      name: reader.read(),
      username: reader.read(),
      thumbnail: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    // Implement writing to Hive box
    writer.write(obj.name);
    writer.write(obj.username);
    writer.write(obj.thumbnail);
  }
}
