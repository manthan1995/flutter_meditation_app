class NextSongModel {
  bool? status;
  String? msg;
  Data? data;

  NextSongModel({this.status, this.msg, this.data});

  NextSongModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? mEDITATIONID;
  String? iMAGE;
  String? mUSIC;
  String? tITLE;
  String? sUBTITLE;
  String? tEXT;
  String? cREATEDATE;
  String? uPDATEDATE;
  String? mEDITATIONTYPE;
  String? uRLS;

  Data(
      {this.mEDITATIONID,
      this.iMAGE,
      this.mUSIC,
      this.tITLE,
      this.sUBTITLE,
      this.tEXT,
      this.cREATEDATE,
      this.uPDATEDATE,
      this.mEDITATIONTYPE,
      this.uRLS});

  Data.fromJson(Map<String, dynamic> json) {
    mEDITATIONID = json['MEDITATION_ID'];
    iMAGE = json['IMAGE'];
    mUSIC = json['MUSIC'];
    tITLE = json['TITLE'];
    sUBTITLE = json['SUBTITLE'];
    tEXT = json['TEXT'];
    cREATEDATE = json['CREATE_DATE'];
    uPDATEDATE = json['UPDATE_DATE'];
    mEDITATIONTYPE = json['MEDITATION_TYPE'];
    uRLS = json['URLS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MEDITATION_ID'] = mEDITATIONID;
    data['IMAGE'] = iMAGE;
    data['MUSIC'] = mUSIC;
    data['TITLE'] = tITLE;
    data['SUBTITLE'] = sUBTITLE;
    data['TEXT'] = tEXT;
    data['CREATE_DATE'] = cREATEDATE;
    data['UPDATE_DATE'] = uPDATEDATE;
    data['MEDITATION_TYPE'] = mEDITATIONTYPE;
    data['URLS'] = uRLS;
    return data;
  }
}
