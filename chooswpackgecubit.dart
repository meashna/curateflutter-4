import 'dart:async';
import 'dart:io' show Platform;

import 'package:curate/src/constants/api_constants.dart';
import 'package:curate/src/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:meta/meta.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/network_check.dart';
import '../../../../data/manager/preferences_manager.dart';
import '../../../../data/models/ChoosePackageResponse.dart';
import '../../../../data/models/apis/UIResponse.dart';
import '../../../../data/repository/user_repo/user_repository.dart';
import '../../../../utils/routes/myNavigator.dart';
import '../../../app_screens.dart';
part 'choose_package_state.dart';


class ChoosePackageCubit extends Cubit<ChoosePackageState> {
  final _userRepository = GetIt.I<UserRepository>();
  ChoosePackageResponse? choosePackageResponse;
  Map<String, dynamic>? argumentData;
  Set<String> _kIds = <String>{/*'com.curate.planTest', 'com.curate.subTest1', 'com.curate.testNonConsumable', 'com.curate.TestConsumable', 'com.curate.plan3Month', 'com.curate.plan6Month', 'com.curate.plan12Month'*/};
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  List<String> _consumables = <String>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  Data? selectedElement;
  BuildContext context;


  ChoosePackageCubit(this.argumentData, this.context) : super(ChoosePackageLoading()){
    Future.delayed(Duration(milliseconds: 100),(){
      getPackageData();
    });
  }

  runInAppStartCode() async {
    try{
      final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
      _subscription = purchaseUpdated.listen((purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      }, onDone: () {
        _subscription.cancel();
      }, onError: (error) {
        // handle error here.
      });
    }catch(e){
     print("in app start catch error");
     print(e);
    }
    getInAppProduct();
  }

  disposeStream(){
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    if(_subscription != null){
      _subscription.cancel();
    }
  }

  getInAppProduct() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    _isAvailable = isAvailable;
    print("isAvailable");
    print(isAvailable);
    if(Platform.isIOS){
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }
    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(_kIds);
    print("in app response");
    print(response);
    if (response.notFoundIDs.isNotEmpty) {

      // Handle the error.
    }
    products = response.productDetails;
    emit(ChoosePackageInitial());
  }

  void setSelectedIOSproduct(Data? element){
    selectedElement  = element;
    purchaseIOSProduct(products.firstWhere((inAppElement) => (element?.iosPlanId ?? "") == inAppElement.id));
  }

  Future<void> purchaseIOSProduct(ProductDetails productDetails) async {
    final preferences = GetIt.I<PreferencesManager>();
    print(productDetails.toString());
    final UUID = await preferences.getUUID();
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails,applicationUserName:UUID);
    var ppprrr = await _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    try{
      purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print("pending");
        print(purchaseDetails.status);
        print(purchaseDetails.productID);
        print(purchaseDetails.purchaseID);
        context.loaderOverlay.show();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          context.loaderOverlay.hide();
          print("purchaseDetails.error");
          print(purchaseDetails.status);
          print(purchaseDetails.error);
          AppUtils.showToast(purchaseDetails.error == null ?  "In app error" : ('Error Code ${purchaseDetails.error!.code} Error Message ${purchaseDetails.error!.message}'));

        }
        else if (purchaseDetails.status == PurchaseStatus.purchased || purchaseDetails.status == PurchaseStatus.restored) {
          context.loaderOverlay.hide();
          /*  bool valid = await _verifyPurchase(purchaseDetails);
            if (valid) {
              _deliverProduct(purchaseDetails);
            } else {
              _handleInvalidPurchase(purchaseDetails);
            }*/
        }
        if (purchaseDetails.pendingCompletePurchase) {

          context.loaderOverlay.hide();
          print("pendingCompletePurchase");
          print(purchaseDetails.status);
          print(purchaseDetails.productID);
          print(purchaseDetails.purchaseID);
          print(purchaseDetails.verificationData.localVerificationData);
          print(purchaseDetails.verificationData.serverVerificationData);

          print(purchaseDetails.transactionDate);
          if (purchaseDetails is AppStorePurchaseDetails) {
            print("kojihugyfcxd;klnjb");
            print(purchaseDetails.skPaymentTransaction.payment);
            print(purchaseDetails.skPaymentTransaction.transactionIdentifier);
            print(purchaseDetails.skPaymentTransaction.originalTransaction);
            print(purchaseDetails.skPaymentTransaction.transactionTimeStamp);
            print(purchaseDetails.skPaymentTransaction.transactionState);
            final originalTransaction = purchaseDetails.skPaymentTransaction.originalTransaction;
            if (originalTransaction != null) {
              String? originalTransactionid = originalTransaction.transactionIdentifier;
              print("originalTransactionid");
              print(originalTransactionid);
              //AppUtils.showToast("Transacton Id: $originalTransactionid");
            }
          }

          //AppUtils.showToast("Purchase ID: ${purchaseDetails.purchaseID}");
          await _inAppPurchase.completePurchase(purchaseDetails);
          const env = AppConstants.baseUrlDev == "https://curateapi.illuminz.com/" ? "SANDBOX" : "PRODUCTION";
          Map<String, dynamic> queryData = {"transactionId":purchaseDetails.purchaseID,"productId":selectedElement?.id,"env":env};

          var response = await _userRepository.getAppleTransaction(queryData);
          if (response.status == Status.COMPLETED) {
            if(response.data?.flag == ApiConstants.paymentInAppPurchaseSuccess){
              RouteNavigator.popAllAndPushNamedReplacement(context, AppScreens.mainScreen);
            }else{
              AppUtils.showToast("get Apple transaction api flag: ${response.data?.flag}");
            }

          }else {
            AppUtils.showToast("get Apple transaction api error: ${response.message}");
          }

        }
      }
    });
    }catch(e){
      print("IN APP Try catch error");
      print(e.toString());
      AppUtils.showToast("IN APP Try catch error ${e.toString()}");
    }

  }

  Future<void> getPackageData() async {
    emit(ChoosePackageLoading());
    var chekcNetwork = await NetworkCheck.check();
    if (chekcNetwork) {
      try {
        var response = await _userRepository.getProducts();
        if (response.status == Status.COMPLETED) {
          choosePackageResponse = response.data;
          choosePackageResponse?.data?.forEach((element) {
            _kIds.add(element.iosPlanId ?? "");
          });

          if(Platform.isIOS){
            runInAppStartCode();
          }
          emit(ChoosePackageInitial());
        }else {
          emit(ChoosePackageError(response.message,));
        }
      } catch (e) {
        print("e");
        print(e);
        emit(ChoosePackageError(e.toString()
        ));
        
      }
    } else {
      emit(ChoosePackageNoInternet());
    }
  }

  Future<Map<String,dynamic>> getOrderId({num? id, required String upiID}) async {

   // Future.delayed(Duration(milliseconds: 100),(){emit(ChoosePackageLoading());});
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var response = await _userRepository.createUpiPaymentRequest(id??0,upiID);
        if (response.status == Status.COMPLETED) {
          return {"status":ApiConstants.paymentStatusPending,"value":response.data["data"]["id"]};
        }else {
          AppUtils.showToast(response.message);
          return {"status":ApiConstants.paymentStatusFailed,"value":response.message};
        }
      } catch (e) {
        AppUtils.showToast(e.toString());
        return {"status":ApiConstants.paymentStatusFailed,"value":e.toString()};
      }
    } else {
      AppUtils.showToast("No internet");
      return {"status":ApiConstants.paymentStatusFailed,"value":"No internet"};
    }
  }

}
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
