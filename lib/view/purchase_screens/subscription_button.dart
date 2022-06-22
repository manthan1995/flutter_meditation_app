// ignore: file_names
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:meditation_app/api_provider/subscription_api/subscription_api.dart';
import 'package:meditation_app/constant/colors.dart';
import 'package:meditation_app/provider/auth_provider/login_provider.dart';
import 'package:page_transition/page_transition.dart';
import '../../bottom_bar.dart';
import '../../constant/preferences_key.dart';
import '../../constant/strings.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';
import 'dart:io';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

bool _kAutoConsume = true;
String _kUpgradeId = 'com.scape.meditations.yearlypack';
List<String> _kProductIds = <String>[
  _kUpgradeId,
];

class SubscriptionButton extends StatefulWidget {
  String screenType;
  SubscriptionButton({required this.screenType});
  @override
  State<SubscriptionButton> createState() => _SubscriptionButtonState();
}

class _SubscriptionButtonState extends State<SubscriptionButton> {
  final InAppPurchase _inAppPurchasePlatform = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  final bool _isAvailable = false;
  bool _purchasePending = false;
  String? _queryProductError;
  late Map<String, dynamic> prefData;
  SubscriptionApi subscriptionApi = SubscriptionApi();
  LoginProvider loginProvider = LoginProvider();

  @override
  void initState() {
    var data = preferences.getString(Keys.userReponse);
    prefData = jsonDecode(data!);

    super.initState();
  }

  Future<void> completePendingTransactions() async {
    try {
      var transactions = await SKPaymentQueueWrapper().transactions();
      for (var skPaymentTransactionWrapper in transactions) {
        SKPaymentQueueWrapper().finishTransaction(skPaymentTransactionWrapper);
      }
    } catch (e) {
      // log(e.toString());
    }
  }

  Future<void> initStoreInfo() async {
    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchasePlatform.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _purchasePending = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _purchasePending = false;
      });
      return;
    }

    await _inAppPurchasePlatform.restorePurchases();

    setState(() {
      _products = productDetailResponse.productDetails;
      _purchasePending = false;
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _products.isNotEmpty
            ? _buildProductList()
            : widget.screenType == 'SubScribe'
                ? MaterialButton(
                    onPressed: () async {
                      await HapticFeedback.mediumImpact();
                      completePendingTransactions();
                      initStoreInfo();
                    },
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    minWidth: MediaQuery.of(context).size.width / 3,
                    color: Colours.blackColor,
                    child: const Text(
                      Strings.subscribe,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colours.whiteColor,
                      ),
                    ),
                  )
                : MaterialButton(
                    minWidth: 190,
                    height: 70,
                    color: Colours.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      widget.screenType,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.78,
                      ),
                    ),
                    onPressed: () async {
                      await HapticFeedback.mediumImpact();
                      completePendingTransactions();
                      initStoreInfo();
                    },
                  ),
      ],
    );
  }

  Widget _buildProductList() {
    final List<Widget> productList = <Widget>[];

    final Map<String, PurchaseDetails> purchases =
        Map<String, PurchaseDetails>.fromEntries(
            _purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        _inAppPurchasePlatform.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));
    productList.addAll(_products.map(
      (ProductDetails productDetails) {
        final PurchaseDetails? previousPurchase = purchases[productDetails.id];
        return widget.screenType == 'SubScribe' ||
                widget.screenType == 'Start free trial'
            ? MaterialButton(
                onPressed: () async {
                  await HapticFeedback.mediumImpact();
                  await completePendingTransactions();
                  late PurchaseParam purchaseParam;
                  final Stream<List<PurchaseDetails>> purchaseUpdated =
                      _inAppPurchasePlatform.purchaseStream;
                  _subscription = purchaseUpdated.listen(
                      (List<PurchaseDetails> purchaseDetailsList) {
                    _listenToPurchaseUpdated(purchaseDetailsList);
                  }, onDone: () {
                    _subscription?.cancel();
                  }, onError: (Object error) {});

                  if (Platform.isAndroid) {
                    await completePendingTransactions();
                    final GooglePlayPurchaseDetails? oldSubscription =
                        _getOldSubscription(
                            productDetails as GooglePlayProductDetails,
                            purchases);

                    purchaseParam = GooglePlayPurchaseParam(
                        productDetails: productDetails,
                        applicationUserName: null,
                        changeSubscriptionParam: (oldSubscription != null)
                            ? ChangeSubscriptionParam(
                                oldPurchaseDetails: oldSubscription,
                                prorationMode:
                                    ProrationMode.immediateWithTimeProration,
                              )
                            : null);
                  } else {
                    await completePendingTransactions();
                    purchaseParam = PurchaseParam(
                      productDetails: productDetails,
                      applicationUserName: null,
                    );
                  }

                  if (productDetails.id == _kUpgradeId) {
                    await completePendingTransactions();
                    _inAppPurchasePlatform.buyConsumable(
                        purchaseParam: purchaseParam,
                        autoConsume: _kAutoConsume || Platform.isIOS);
                  } else {
                    await completePendingTransactions();
                    _inAppPurchasePlatform.buyNonConsumable(
                        purchaseParam: purchaseParam);
                  }
                },
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                minWidth: MediaQuery.of(context).size.width / 3,
                color: Colours.blackColor,
                child: const Text(
                  Strings.subscribe,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colours.whiteColor,
                  ),
                ),
              )
            : MaterialButton(
                minWidth: 190,
                height: 70,
                color: Colours.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  widget.screenType,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.78,
                  ),
                ),
                onPressed: () async {
                  await HapticFeedback.mediumImpact();
                  await completePendingTransactions();
                  final Stream<List<PurchaseDetails>> purchaseUpdated =
                      _inAppPurchasePlatform.purchaseStream;
                  _subscription = purchaseUpdated.listen(
                      (List<PurchaseDetails> purchaseDetailsList) {
                    _listenToPurchaseUpdated(purchaseDetailsList);
                  }, onDone: () {
                    _subscription?.cancel();
                  }, onError: (Object error) {});

                  late PurchaseParam purchaseParam;

                  if (Platform.isAndroid) {
                    await completePendingTransactions();
                    final GooglePlayPurchaseDetails? oldSubscription =
                        _getOldSubscription(
                            productDetails as GooglePlayProductDetails,
                            purchases);

                    purchaseParam = GooglePlayPurchaseParam(
                        productDetails: productDetails,
                        applicationUserName: null,
                        changeSubscriptionParam: (oldSubscription != null)
                            ? ChangeSubscriptionParam(
                                oldPurchaseDetails: oldSubscription,
                                prorationMode:
                                    ProrationMode.immediateWithTimeProration,
                              )
                            : null);
                  } else {
                    await completePendingTransactions();
                    purchaseParam = PurchaseParam(
                      productDetails: productDetails,
                      applicationUserName: null,
                    );
                  }

                  if (productDetails.id == _kUpgradeId) {
                    await completePendingTransactions();
                    _inAppPurchasePlatform.buyConsumable(
                        purchaseParam: purchaseParam,
                        autoConsume: _kAutoConsume || Platform.isIOS);
                  } else {
                    await completePendingTransactions();
                    _inAppPurchasePlatform.buyNonConsumable(
                        purchaseParam: purchaseParam);

                    var transactions =
                        await SKPaymentQueueWrapper().transactions();
                    for (var skPaymentTransactionWrapper in transactions) {
                      SKPaymentQueueWrapper()
                          .finishTransaction(skPaymentTransactionWrapper);
                    }
                  }
                },
              );
      },
    ));

    return Column(children: productList);
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {}

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.error) {
        handleError(purchaseDetails.error!);
      } else if (purchaseDetails.status == PurchaseStatus.purchased) {
        final bool valid = await _verifyPurchase(purchaseDetails);
        if (valid) {
          if (valid == true) {
            purchaseDetailsList.isEmpty;
            var response = await subscriptionApi.subscriptionApi(
                id: prefData['data']['USER_ID'], type: 365);
            if (response.data?.status == true) {
              if (prefData['data']['ISSOCIAL'] == true) {
                await loginProvider.loginSocialProvider(
                  socialId: preferences.getString(Keys.socialID).toString(),
                  isSocial: true,
                );
              } else {
                await loginProvider.loginProvider(
                  email: prefData['data']['EMAIL'],
                  password: preferences.getString(Keys.password).toString(),
                  isSocial: false,
                );
              }
              Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 400),
                  type: PageTransitionType.fade,
                  child: BottomBarscreen(selectBottmTab: 0),
                ),
              );
            }
          }
        } else {
          _handleInvalidPurchase(purchaseDetails);
          return;
        }

        if (!_kAutoConsume && purchaseDetails.productID == _kUpgradeId) {
          final InAppPurchaseAndroidPlatformAddition addition =
              InAppPurchasePlatformAddition.instance!
                  as InAppPurchaseAndroidPlatformAddition;

          await addition.consumePurchase(purchaseDetails);
        }

        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchasePlatform.completePurchase(purchaseDetails);
        }
      }
    }
  }

  GooglePlayPurchaseDetails? _getOldSubscription(
      GooglePlayProductDetails productDetails,
      Map<String, PurchaseDetails> purchases) {
    GooglePlayPurchaseDetails? oldSubscription;

    return oldSubscription;
  }
}
