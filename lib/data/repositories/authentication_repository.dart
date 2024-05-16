
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<UserCredential> signInWithFacebook()async{

    Map<String,dynamic> userData = {};
    var accessToken = await FacebookAuth.instance.accessToken;

    if(accessToken != null){
      print(accessToken.toJson());
      userData = await FacebookAuth.instance.getUserData();
    }else{
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if(loginResult.status == LoginStatus.success){
        accessToken = loginResult.accessToken;
        userData = await FacebookAuth.instance.getUserData();
      }else{
        print(loginResult.status);
        print(loginResult.message);
      }
    }

    final credential = FacebookAuthProvider.credential(accessToken!.token);
    var userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    SignUpBody signUpBody = SignUpBody();

    String name = userCredential.user!.displayName!;
    if(name.contains(";")){
      List<String> dataList = name.split(";");
      name = dataList[0];
    }

    signUpBody.name = name;
    signUpBody.phone = userCredential.user!.phoneNumber != null ? userCredential.user!.phoneNumber : "";
    signUpBody.userType = "Usuario";
    signUpBody.email = userCredential.user!.email;

    await registerNewUser(signUpBody,userCredential);

    return userCredential;

  }

  void facebookLogOut() async{
    await FacebookAuth.instance.logOut();
  }

  Future<UserCredential> signInWithGoogle() async{

    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken
    );

    var userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    SignUpBody signUpBody = SignUpBody();

    String name = userCredential.user!.displayName!;
    if(name.contains(";")){
      List<String> dataList = name.split(";");
      name = dataList[0];
    }

    signUpBody.name = name;
    signUpBody.phone = userCredential.user!.phoneNumber != null ? userCredential.user!.phoneNumber : "";
    signUpBody.userType = "Usuario";
    signUpBody.email = userCredential.user!.email;

    await registerNewUser(signUpBody,userCredential);

    return userCredential;

  }

  void googleLogOut() async{
    await GoogleSignIn().signOut();
  }

  Future<FirebaseAuth> getProfileData() async{

    return firebaseAuth;

  }

  Future<Response> updatePhoneNumber(String phoneNumber) async{

    Map<String,String> phoneUpdated = {};
    phoneUpdated["UserPhone"] = phoneNumber;
    phoneUpdated["UserUID"] = firebaseAuth.currentUser!.uid!;

    return await apiClient.putData(AppConstants.UPDATE_PHONE_NUMBER, phoneUpdated);

  }

  Future<bool> verifyCurrentUser() async{
    if(firebaseAuth.currentUser != null){
      return true;
    }else{
      return false;
    }
  }

  Future<void> signOut() async{
    await FacebookAuth.instance.logOut();
    await GoogleSignIn().signOut();
    return await firebaseAuth.signOut();
  }

}