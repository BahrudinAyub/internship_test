import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class UsernameController extends GetxController {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref().child('Username');

  Future<bool> isUsernameExists(String name) async {
    try {
      final snapshot = await _databaseReference.orderByChild('name').equalTo(name).once();
      return snapshot.snapshot.value != null;
    } catch (e) {
      print('Failed to check existence of username: $e');
      return false;
    }
  }

  Future<bool> addUsername(String name) async {
    try {
      if (await isUsernameExists(name)) {
        print('Username already exists');
        return false; // Username already exists
      }

      // Gets the last unique ID
      final snapshot = await _databaseReference.orderByKey().limitToLast(1).once();
      int lastId = 0;
      if (snapshot.snapshot.value != null) {
        final lastKey = (snapshot.snapshot.value as Map).keys.first;
        lastId = int.parse(lastKey);
      }

      // Unique ID next
      final newId = lastId + 1;

      // Menyimpan data ke Realtime Database
      await _databaseReference.child(newId.toString()).set({'name': name});
      print('Username added successfully');
      return true; // Successfully added username
    } catch (e) {
      print('Failed to add username: $e');
      return false; // Failed to add username
    }
  }
}
