import 'package:flutter/material.dart';
import 'package:meditation_app/api_provider/subscription_api/subscription_api.dart';

class SubscriptionProvider extends ChangeNotifier {
  SubscriptionApi subscriptionApi = SubscriptionApi();

  Future subscriptionProvider({required int id, required int type}) async {
    final res = await subscriptionApi.subscriptionApi(id: id, type: type);

    notifyListeners();
    return res;
  }
}
