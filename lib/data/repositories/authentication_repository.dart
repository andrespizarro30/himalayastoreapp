
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/sign_up_model.dart';
import '../../utils/app_constants.dart';


class AuthenticationRepo{

  FirebaseAuth firebaseAuth;

  AuthenticationRepo({
    required this.firebaseAuth,
  });

  Future<UserCredential> signUpWithEmailAndPassword(SignUpBody signUpBody)async{

    try{
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: signUpBody.email!, password: signUpBody.password!);
      await userCredential.user!.updateDisplayName("${signUpBody.name};${signUpBody.phone};${signUpBody.userType}");
      await firebaseAuth.signOut();
      return userCredential;
    }on FirebaseException catch(e){
      throw Exception(e.code);
    }

  }

  Future<UserCredential> signInWithEmailAndPassword(SignUpBody signUpBody)async{

    try{
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: signUpBody.email!, password: signUpBody.password!);
      return userCredential;
    }on FirebaseException catch(e){
      throw Exception(e.code);
    }

  }

  Future<FirebaseAuth> getProfileData() async{

    return firebaseAuth;

  }

  Future<bool> verifyCurrentUser() async{
    if(firebaseAuth.currentUser != null){
      return true;
    }else{
      return false;
    }
  }

  Future<void> signOut() async{
    return await firebaseAuth.signOut();
  }

}