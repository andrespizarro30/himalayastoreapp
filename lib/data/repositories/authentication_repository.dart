
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/sign_up_model.dart';
import '../../models/user_model.dart';
import '../../utils/app_constants.dart';
import '../apis/api_client.dart';


class AuthenticationRepo{

  FirebaseAuth firebaseAuth;
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthenticationRepo({
    required this.firebaseAuth,
    required this.apiClient,
    required this.sharedPreferences
  });

  Future<UserCredential> signUpWithEmailAndPassword(SignUpBody signUpBody)async{

    try{
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: signUpBody.email!, password: signUpBody.password!);
      await userCredential.user!.updateDisplayName("${signUpBody.name};${signUpBody.phone};${signUpBody.userType}");
      await firebaseAuth.signOut();
      await registerNewUser(signUpBody,userCredential);
      return userCredential;
    }on FirebaseException catch(e){
      throw Exception(e.code);
    }

  }

  Future<Response> registerNewUser(SignUpBody signUpBody,UserCredential userCredential)async{

    UsersModel usersModel = UsersModel();
    usersModel.userName = signUpBody.name;
    usersModel.userPhone = signUpBody.phone;
    usersModel.userUserType = signUpBody.userType;
    usersModel.userEmail = signUpBody.email;
    usersModel.userUID = userCredential.user!.uid!;
    usersModel.userToken = sharedPreferences.getString(AppConstants.FIRESTORE_TOKENS);

    return await apiClient.postData(AppConstants.REGISTER_NEW_USER, usersModel.toJson());

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