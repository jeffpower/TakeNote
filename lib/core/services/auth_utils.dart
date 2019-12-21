import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthUtils {
  final Firestore _db = Firestore.instance;
  final String path = "notes";
  CollectionReference ref;
  FirebaseAuth _auth;
  FirebaseUser _user;

  Future<QuerySnapshot> getDataCollection() {
    ref = _db.collection(path);
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    ref = _db.collection(path);
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    ref = _db.collection(path);
    return ref.document(id).get();
  }

  Future<void> removeDocument(String id) {
    ref = _db.collection(path);
    return ref.document(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    ref = _db.collection(path);
    return ref.add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    ref = _db.collection(path);
    return ref.document(id).updateData(data);
  }

  Future<FirebaseUser> loginUser(String email, String password) async{
    _auth = FirebaseAuth.instance;
    _auth.signInWithEmailAndPassword(
      email: email, password: password
    ).then((response) {
      _user = response.user;
    });

    return _user;
  }

  Future<FirebaseUser> registerUser(String email, String password) async {
    _auth = FirebaseAuth.instance;
    _auth.createUserWithEmailAndPassword(email: email, password: password)
      .then((response) {
        _user = response.user;
      });

      return _user;
  }
}