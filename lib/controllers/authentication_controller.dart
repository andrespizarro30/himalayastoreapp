import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:himalayastoreapp/models/response_model.dart';

import '../base/convert_url_to_file.dart';
import '../base/show_custom_message.dart';
import '../data/repositories/authentication_repository.dart';
import '../models/sign_up_model.dart';
import '../utils/dimensions.dart';


class AuthenticationPageController extends GetxController implements GetxService{

  final AuthenticationRepo authRepo;
  FirebaseAuth firebaseAuth;
  FirebaseStorage firebaseStorage;

  AuthenticationPageController({
    required this.authRepo,
    required this.firebaseAuth,
    required this.firebaseStorage
  });

  late SignUpBody _signUpBody = SignUpBody();
  SignUpBody get signUpBody => _signUpBody;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _uid = "";
  String get uid => _uid;

  bool _currentFBUserExists = false;
  bool get currentFBUserExists => _currentFBUserExists;

  String _profileImageURL = "";
  String get profileImageURL => _profileImageURL;

  int _tapsCount = 0;
  int get tapsCount => _tapsCount;

  bool _isTechnician = false;
  bool get isTechnician => _isTechnician;

  double _imageRequestContainerHeight = 0;
  double get imageRequestContainerHeight => _imageRequestContainerHeight;

  bool _isOpenImageRequestContainer = false;
  bool get isOpenImageRequestContainer => _isOpenImageRequestContainer;

  TextEditingController tecUpdatePhoneNumber = TextEditingController();

  Future<void> registration(SignUpBody signUpBody) async{
    _isLoading = true;
    update();
    try{
      UserCredential userCredential = await authRepo.signUpWithEmailAndPassword(signUpBody);
      if(userCredential != null){
        showCustomSnackBar("Usuario creado exitosamente!!!",title: "Creación Usuario", backgroundColor: Colors.lightGreenAccent);
      }
      _isLoading = false;
      update();
    }catch(e){
      showCustomSnackBar("Error al intentar crear usuario, intente nuevamente...",title: "Creación Usuario");
      _isLoading = false;
      update();
    }

  }

  Future<ResponseModel> login(SignUpBody signUpBody) async{
    _isLoading = true;
    late ResponseModel responseModel;
    update();
    try{
      UserCredential userCredential = await authRepo.signInWithEmailAndPassword(signUpBody);
      if(userCredential != null){
        _uid = userCredential.user!.uid!;
        responseModel = ResponseModel(true, "Sign in correct");
      }else{
        responseModel = ResponseModel(false, "Error");
      }
      _isLoading = false;
      getProfileData("EmailPassword");

    }catch(e){
      responseModel = ResponseModel(false, "Error");
      showCustomSnackBar("Usuario y/o contrasena erroneos, intente nuevamente...",title: "Login usuario");
      _uid = "";
      _isLoading = false;
      update();
    }

    return responseModel;

  }

  Future<ResponseModel> signInWithFacebook()async{

    _isLoading = true;
    late ResponseModel responseModel;
    update();
    try{
      UserCredential userCredential = await authRepo.signInWithFacebook();
      if(userCredential != null){
        _uid = userCredential.user!.uid!;
        _profileImageURL = userCredential.additionalUserInfo!.profile!["picture"]["data"]["url"];
        File photoFile = await converURLImageToFile(_profileImageURL!);
        updatePhotoProfile("", photoFile);
        responseModel = ResponseModel(true, "Sign in correct");
      }else{
        responseModel = ResponseModel(false, "Error");
      }
      _isLoading = false;
      getProfileData("Facebook");

    }catch(e){
      responseModel = ResponseModel(false, "Error");
      showCustomSnackBar("Usuario y/o contrasena erroneos, intente nuevamente...",title: "Login usuario");
      _uid = "";
      _isLoading = false;
      update();
    }

    return responseModel;
  }

  Future<ResponseModel> signInWithGoogle() async{

    _isLoading = true;
    late ResponseModel responseModel;
    update();
    try{
      UserCredential userCredential = await authRepo.signInWithGoogle();
      if(userCredential != null){
        _uid = userCredential.user!.uid!;
        _profileImageURL = firebaseAuth.currentUser!.photoURL!;
        File photoFile = await converURLImageToFile(_profileImageURL!);
        updatePhotoProfile("", photoFile);
        responseModel = ResponseModel(true, "Sign in correct");
      }else{
        responseModel = ResponseModel(false, "Error");
      }
      _isLoading = false;
      getProfileData("Google");

    }catch(e){
      responseModel = ResponseModel(false, "Error");
      showCustomSnackBar("Usuario y/o contrasena erroneos, intente nuevamente...",title: "Login usuario");
      _uid = "";
      _isLoading = false;
      update();
    }

    return responseModel;

  }

  Future<ResponseModel> signInWithApple()async{

    _isLoading = true;
    late ResponseModel responseModel;
    update();
    try{
      UserCredential userCredential = await authRepo.signInWithApple();
      if(userCredential != null){
        _uid = userCredential.user!.uid!;
        responseModel = ResponseModel(true, "Sign in correct");
      }else{
        responseModel = ResponseModel(false, "Error");
      }
      _isLoading = false;
      getProfileData("Apple");

    }catch(e){
      responseModel = ResponseModel(false, "Error");
      showCustomSnackBar("Usuario y/o contrasena erroneos, intente nuevamente...",title: "Login usuario");
      _uid = "";
      _isLoading = false;
      update();
    }

    return responseModel;
  }

  Future<void> getProfileData(String loginMode) async{

    var firebaseAuth = await authRepo.getProfileData();

    if(firebaseAuth.currentUser != null){

      if(loginMode == "EmailPassword"){
        var dataList = firebaseAuth.currentUser!.displayName!.split(";");

        _signUpBody.name = dataList[0];
        _signUpBody.phone = dataList.length>1 ? dataList[1] : "";
        _signUpBody.userType = dataList.length>1 ? dataList[2] : "";
        _signUpBody.email = firebaseAuth.currentUser!.email;

        if(_profileImageURL.isEmpty || _profileImageURL == ""){
          _profileImageURL = firebaseAuth.currentUser!.photoURL != null ? firebaseAuth.currentUser!.photoURL! : "";
        }
      }else
      if(loginMode == "Google"){

        _signUpBody.name = firebaseAuth.currentUser!.displayName!;
        _signUpBody.phone = firebaseAuth.currentUser!.phoneNumber != null ? firebaseAuth.currentUser!.phoneNumber : "";
        _signUpBody.userType = "Usuario";
        _signUpBody.email = firebaseAuth.currentUser!.email;

        await firebaseAuth.currentUser!.updateDisplayName("${signUpBody.name};${signUpBody.phone};${signUpBody.userType}");

        _profileImageURL = firebaseAuth.currentUser!.photoURL != null ? firebaseAuth.currentUser!.photoURL! : "";
      }
      else
      if(loginMode == "Facebook"){

        _signUpBody.name = firebaseAuth.currentUser!.displayName!;
        _signUpBody.phone = firebaseAuth.currentUser!.phoneNumber != null ? firebaseAuth.currentUser!.phoneNumber : "";
        _signUpBody.userType = "Usuario";
        _signUpBody.email = firebaseAuth.currentUser!.email;

        await firebaseAuth.currentUser!.updateDisplayName("${signUpBody.name};${signUpBody.phone};${signUpBody.userType}");

      }
      else
      if(loginMode == "Apple"){

        _signUpBody.name = firebaseAuth.currentUser!.displayName!;
        _signUpBody.phone = firebaseAuth.currentUser!.phoneNumber != null ? firebaseAuth.currentUser!.phoneNumber : "";
        _signUpBody.userType = "Usuario";
        _signUpBody.email = firebaseAuth.currentUser!.email;

        await firebaseAuth.currentUser!.updateDisplayName("${signUpBody.name};${signUpBody.phone};${signUpBody.userType}");

      }


      update();
    }

  }

  Future<bool> updatePhoneNumber() async{

    var firebaseAuth = await authRepo.getProfileData();

    await firebaseAuth.currentUser!.updateDisplayName("${signUpBody.name};${tecUpdatePhoneNumber.text};${signUpBody.userType}");

    Response response = await authRepo.updatePhoneNumber(tecUpdatePhoneNumber.text);

    await getProfileData("EmailPassword");

    if(response.body["PhoneUpdated"]=="OK"){
      return true;
    }else{
      return false;
    }

  }

  Future<void> updatePhotoProfile(String appCurrentDirectory, File imageFile) async{

    List<String> pathParts = imageFile.path.split("/");

    String fileName = pathParts[pathParts.length-1];

    final Reference refStorage = firebaseStorage.ref().child("MyPhotoProfile")
        .child(firebaseAuth.currentUser!.uid!)    
        .child(fileName);


    final UploadTask uploadTask = refStorage.putFile(imageFile);

    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => true);

    if(taskSnapshot.state == TaskState.success){
      final String photoURL = await taskSnapshot.ref.getDownloadURL();
      firebaseAuth.currentUser!.updatePhotoURL(photoURL);
      _profileImageURL = photoURL;
      update();
    }

  }

  Future<void> verifyCurrentUser() async{
    _currentFBUserExists = await authRepo.verifyCurrentUser();
    update();
  }

  void signOut() async{
    await authRepo.signOut();
  }

  void addTapCount(){
    _tapsCount = _tapsCount + 1;
    update();
  }

  void setIfTechnician(){
    _isTechnician = !_isTechnician;
    update();
  }

  void openImageRequestContainer(){

    _isOpenImageRequestContainer = !isOpenImageRequestContainer;

    _imageRequestContainerHeight = isOpenImageRequestContainer ? Dimensions.screenHeight * 0.38 : 0;

    update();

  }

  void closeDraggingUpdateImageRequestContainer(double dy){

    _imageRequestContainerHeight = _imageRequestContainerHeight - dy;
    if(_imageRequestContainerHeight<Dimensions.screenHeight * 0.2){
      _isOpenImageRequestContainer = false;
    }else{
      _isOpenImageRequestContainer = true;
    }

    update();

  }

  void closeDraggingEndImageRequestContainer(){

    if(_imageRequestContainerHeight<Dimensions.screenHeight * 0.2){
      _isOpenImageRequestContainer = false;
      _imageRequestContainerHeight=0;
    }else{
      _imageRequestContainerHeight = Dimensions.screenHeight * 0.38;
    }

    update();

  }

}