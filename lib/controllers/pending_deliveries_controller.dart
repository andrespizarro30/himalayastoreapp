

import 'package:get/get.dart';

import '../data/repositories/pending_deliveries_repo.dart';
import '../models/deliveries_id_model.dart';
import '../utils/dimensions.dart';

class PendingDeliviresController extends GetxController{

  final PendingDeliveriesRepo pendingDeliveriesRepo;

  PendingDeliviresController({required this.pendingDeliveriesRepo});

  double _statusChangeContainerHeight = 0;
  double get statusChangeContainerHeight => _statusChangeContainerHeight;

  bool _isOpenStatusContainer = false;
  bool get isOpenStatusContainer => _isOpenStatusContainer;

  List<Deliveries> _pendingDeliveriesList = [];
  List<Deliveries> get pendingDeliveriesList => _pendingDeliveriesList;

  bool _isLoading = false;
  bool get isLoading =>_isLoading;

  String _currentStatus = "";
  String get currentStatus => _currentStatus;

  Deliveries _currentDelivery = Deliveries();
  Deliveries get currentDelivery => _currentDelivery;

  String _isStatusUpdated = "NA";
  String get isStatusUpdated => _isStatusUpdated;

  Future<void> getPendingDeliveriesId()async{

    Response response = await pendingDeliveriesRepo.getPendingDeliveriesId();
    if(response.statusCode == 200){
      _pendingDeliveriesList=[];
      _pendingDeliveriesList.addAll(DeliveriesList.fromJson(response.body).deliveriesList);
    }else{

    }

    update();

  }

  void openStatusChangeRequestContainer(){

    _isOpenStatusContainer = !isOpenStatusContainer;

    _statusChangeContainerHeight = isOpenStatusContainer ? Dimensions.screenHeight * 0.54 : 0;

    update();

  }

  void changeCurrentStatus(String currentStatus){
    _currentStatus = currentStatus;
    update();
  }

  void assignCurrentDelivery(Deliveries delivery){

    _currentDelivery = delivery;

    changeCurrentStatus(delivery.deliveryStatus!);

  }

  Future<void> updateDeliveryIdStatus() async{

    _isLoading = true;
    update();

    Response response =  await pendingDeliveriesRepo.updateDeliveryIdStatus(currentDelivery, currentStatus);
    if(response.statusCode == 200){

      String resp = response.body["RegisterUpdated"];

      if(resp=="OK"){
        _isStatusUpdated = "OK";
        await pendingDeliveriesRepo.sendNotificationToUser(currentDelivery, currentStatus);
      }else{
        _isStatusUpdated = "NO";
      }

    }else{

    }

    _isLoading = false;
    getPendingDeliveriesId();
  }

  void restartStatus(){
    _isLoading = false;
    _isStatusUpdated = "NA";
    update();
  }


}