import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rentware/models/Product.dart';

const String USER_COLLECTION = 'users';
const String PRODUCT_COLLECTION = 'products';
const String DEFAULT_PROFILE_PIC =
    'https://firebasestorage.googleapis.com/v0/b/rentware-e468b.appspot.com/o/profile_images%2FDefault-Profile-Picture.png?alt=media&token=113243b7-0dde-45d6-afae-42e5c5c8dc59';

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Map? currentUser;
  String? _currentUserId;

  FirebaseService();

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (_userCredential.user != null) {
        currentUser = await getUserData(uid: _userCredential.user!.uid);
        _currentUserId = _userCredential.user!.uid;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map> getUserData({required String uid}) async {
    DocumentSnapshot _doc =
        await _db.collection(USER_COLLECTION).doc(uid).get();
    return _doc.data() as Map;
  }

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential _userCredintial =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String _userId = _userCredintial.user!.uid;
      await _db.collection(USER_COLLECTION).doc(_userId).set({
        "name": name,
        "email": email,
        "image": DEFAULT_PROFILE_PIC,
      });
      return true;
    } catch (e) {
      return false;
      print(e);
    }
  }

  Stream<QuerySnapshot> getProducts() {
    return _db.collection(PRODUCT_COLLECTION).snapshots();
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  // Adding an item to the favorite list
  Future<void> addFavoriteItem(String itemId) async {
    await _db.collection(USER_COLLECTION).doc(_currentUserId).update({
      'favoriteProducts': FieldValue.arrayUnion([itemId])
    });
  }

  // Deleting an item from the favorite list
  Future<void> removeFavoriteItem(String itemId) async {
    await _db.collection(USER_COLLECTION).doc(_currentUserId).update({
      'favoriteProducts': FieldValue.arrayRemove([itemId])
    });
  }

  // Retrieving favorite items
  Stream<List<Product>> getFavoriteItems() {
    return _db
        .collection(USER_COLLECTION)
        .doc(_currentUserId)
        .snapshots()
        .map((snapshot) {
      List<dynamic> favoriteItemIds =
          snapshot.data()?['favoriteProducts'] ?? [];
      return favoriteItemIds;
    }).asyncMap((favoriteItemIds) async {
      List<Product> favoriteItems = [];

      for (var itemId in favoriteItemIds) {
        var productDoc =
            await _db.collection(PRODUCT_COLLECTION).doc(itemId).get();
        favoriteItems
            .add(Product.fromMap(productDoc.data() as Map<String, dynamic>));
      }

      return favoriteItems;
    });
  }
}
