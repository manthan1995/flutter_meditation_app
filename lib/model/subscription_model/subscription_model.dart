class SubscriptionModel {
  bool? status;
  String? msg;
  SubData? data;

  SubscriptionModel({
    this.status,
    this.msg,
    this.data,
  });

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    msg = json["msg"];
    data = json['data'] != null ? SubData.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data?.toJson(),
      };
}

class SubData {
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

  SubData({
    this.uSERID,
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
    this.mEDITATIONID,
  });

  SubData.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() => {
        "USER_ID": uSERID,
        "SOCIAL_ID": sOCIALID,
        "PROFILE_PIC": pROFILEPIC,
        "EMAIL": eMAIL,
        "PASSWORD": pASSWORD,
        "COMPANY_CODE": cOMPANYCODE,
        "TYPE": tYPE,
        "ISSOCIAL": iSSOCIAL,
        "ISACTIVE": iSACTIVE,
        "ISDELETE": iSDELETE,
        "MEDITATION_IDS": mEDITATIONIDS,
        "MEDITATION_START_DATE": mEDITATIONSTARTDATE,
        "STRIKE": sTRIKE,
        "ISSTRIKE": iSSTRIKE,
        "SUBCRIPTION_DAYS": sUBCRIPTIONDAYS,
        "SUBCRIPTION_END_DATE": sUBCRIPTIONENDDATE,
        "ISSUBCRIBE": iSSUBCRIBE,
        "CREATE_DATE": cREATEDATE,
        "UPDATE_DATE": uPDATEDATE,
        "MEDITATION_ID": mEDITATIONID,
      };
}
