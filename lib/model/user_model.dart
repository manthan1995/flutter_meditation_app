class ApiResponseModel<T> {
  late bool? status;
  late String? message;
  late T? data;

  ApiResponseModel({
    this.data,
    this.message,
    this.status,
  });

  ApiResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
  }
}
