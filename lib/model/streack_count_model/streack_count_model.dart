class CountStrackModel {
  bool? status;
  String? msg;
  Data? data;

  CountStrackModel({this.status, this.msg, this.data});

  CountStrackModel.fromJson(Map<String, dynamic> json) {
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
  int? uSERID;
  String? sOCIALID;
  String? pROFILEPIC;
  String? eMAIL;
  String? pASSWORD;
  String? cOMPANYCODE;
  String? tYPE;
  bool? iSSOCIAL;
  bool? iSACTIVE;
  bool? iSDELETE;
  String? mEDITATIONIDS;
  String? mEDITATIONSTARTDATE;
  int? sTRIKE;
  bool? iSSTRIKE;
  int? sUBCRIPTIONDAYS;
  String? sUBCRIPTIONENDDATE;
  bool? iSSUBCRIBE;
  String? cREATEDATE;
  String? uPDATEDATE;
  int? mEDITATIONID;
  int? longestStrike;
  int? totalStrike;

  Data(
      {this.uSERID,
      this.sOCIALID,
      this.pROFILEPIC,
      this.eMAIL,
      this.pASSWORD,
      this.cOMPANYCODE,
      this.tYPE,
      this.iSSOCIAL,
      this.iSACTIVE,
      this.iSDELETE,
      this.mEDITATIONIDS,
      this.mEDITATIONSTARTDATE,
      this.sTRIKE,
      this.iSSTRIKE,
      this.sUBCRIPTIONDAYS,
      this.sUBCRIPTIONENDDATE,
      this.iSSUBCRIBE,
      this.cREATEDATE,
      this.uPDATEDATE,
      this.longestStrike,
      this.totalStrike,
      this.mEDITATIONID});

  Data.fromJson(Map<String, dynamic> json) {
    uSERID = json['USER_ID'];
    sOCIALID = json['SOCIAL_ID'];
    pROFILEPIC = json['PROFILE_PIC'];
    eMAIL = json['EMAIL'];
    pASSWORD = json['PASSWORD'];
    cOMPANYCODE = json['COMPANY_CODE'];
    tYPE = json['TYPE'];
    iSSOCIAL = json['ISSOCIAL'];
    iSACTIVE = json['ISACTIVE'];
    iSDELETE = json['ISDELETE'];
    mEDITATIONIDS = json['MEDITATION_IDS'];
    mEDITATIONSTARTDATE = json['MEDITATION_START_DATE'];
    sTRIKE = json['STRIKE'];
    iSSTRIKE = json['ISSTRIKE'];
    sUBCRIPTIONDAYS = json['SUBCRIPTION_DAYS'];
    sUBCRIPTIONENDDATE = json['SUBCRIPTION_END_DATE'];
    iSSUBCRIBE = json['ISSUBCRIBE'];
    cREATEDATE = json['CREATE_DATE'];
    uPDATEDATE = json['UPDATE_DATE'];
    mEDITATIONID = json['MEDITATION_ID'];
    longestStrike = json['LONGEST_STRIKE'];
    totalStrike = json['TOTAL_STRIKE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['USER_ID'] = uSERID;
    data['SOCIAL_ID'] = sOCIALID;
    data['PROFILE_PIC'] = pROFILEPIC;
    data['EMAIL'] = eMAIL;
    data['PASSWORD'] = pASSWORD;
    data['COMPANY_CODE'] = cOMPANYCODE;
    data['TYPE'] = tYPE;
    data['ISSOCIAL'] = iSSOCIAL;
    data['ISACTIVE'] = iSACTIVE;
    data['ISDELETE'] = iSDELETE;
    data['MEDITATION_IDS'] = mEDITATIONIDS;
    data['MEDITATION_START_DATE'] = mEDITATIONSTARTDATE;
    data['STRIKE'] = sTRIKE;
    data['ISSTRIKE'] = iSSTRIKE;
    data['SUBCRIPTION_DAYS'] = sUBCRIPTIONDAYS;
    data['SUBCRIPTION_END_DATE'] = sUBCRIPTIONENDDATE;
    data['ISSUBCRIBE'] = iSSUBCRIBE;
    data['CREATE_DATE'] = cREATEDATE;
    data['UPDATE_DATE'] = uPDATEDATE;
    data['MEDITATION_ID'] = mEDITATIONID;
    data['LONGEST_STRIKE'] = longestStrike;
    data['TOTAL_STRIKE'] = totalStrike;
    return data;
  }
}
