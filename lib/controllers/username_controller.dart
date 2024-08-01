import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsernameController extends GetxController {
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('Username');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> isUsernameExists(String name) async {
    try {
      final querySnapshot = await _collectionReference.where('name', isEqualTo: name).get();
      return querySnapshot.docs.isNotEmpty;
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

      // Get current user ID
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        print('User is not authenticated');
        return false;
      }

      // Create a new unique ID
      final newDocRef = _collectionReference.doc();
      final newId = newDocRef.id;

      // Save data to Firestore
      await newDocRef.set({
        'name': name,
        'id': newId,
        'userId': userId, // Save user ID who added this username
      });

      print('Username added successfully');
      return true; // Successfully added username
    } catch (e) {
      print('Failed to add username: $e');
      return false; // Failed to add username
    }
  }
}
