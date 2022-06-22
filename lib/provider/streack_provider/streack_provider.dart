import 'package:flutter/material.dart';
import 'package:meditation_app/api_provider/streck_cout_api/streack_count_api.dart';
import 'package:meditation_app/model/user_model.dart';

import '../../model/streack_count_model/streack_count_model.dart';

class StreackCountProvider extends ChangeNotifier {
  StreckCoutApiProvider streckCoutApiProvider = StreckCoutApiProvider();

  Future<ApiResponseModel<CountStrackModel>> streackCountProvider({
    required int userId,
  }) async {
    final ApiResponseModel<CountStrackModel> res =
        await streckCoutApiProvider.streckCoutApi(
      userId: userId,
    );

    notifyListeners();
    return res;
  }
}
