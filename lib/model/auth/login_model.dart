class LoginModel {
  bool? status;
  String? msg;
  Data? data;
  MeditationData? meditationData;
  NextMeditationData? nextMeditationData;
  int? trialDays;

  LoginModel(
      {this.status, this.msg, this.data, this.meditationData, this.trialDays});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    meditationData = json['meditationData'] != null
        ? MeditationData.fromJson(json['meditationData'])
        : null;
    nextMeditationData = json['nextMeditation'] != null
        ? NextMeditationData.fromJson(json['nextMeditation'])
        : null;
    trialDays = json['TRIAL_DAYS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    data['TRIAL_DAYS'] = trialDays;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (meditationData != null) {
      data['meditationData'] = meditationData!.toJson();
    }
    if (nextMeditationData != null) {
      data['nextMeditation'] = nextMeditationData!.toJson();
    }
    return data;
  }
}

class Data {
  int? uSERID;
  String? sOCIALID;
  String? username;
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
  int? sUBCRIPTIONTYPE;
  String? sUBCRIPTIONENDDATE;
  bool? iSSUBCRIBE;
  String? cREATEDATE;
  String? uPDATEDATE;
  int? mEDITATIONID;
  int? sUBCRIPTIONdAYS;
  int? longestStrike;
  int? totalStrike;

  Data(
      {this.uSERID,
      this.sOCIALID,
      this.pROFILEPIC,
      this.username,
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
      this.sUBCRIPTIONTYPE,
      this.sUBCRIPTIONENDDATE,
      this.iSSUBCRIBE,
      this.cREATEDATE,
      this.uPDATEDATE,
      this.sUBCRIPTIONdAYS,
      this.longestStrike,
      this.totalStrike,
      this.mEDITATIONID});

  Data.fromJson(Map<String, dynamic> json) {
    uSERID = json['USER_ID'];
    sOCIALID = json['SOCIAL_ID'];
    username = json['USER_NAME'];
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
    sUBCRIPTIONTYPE = json['SUBCRIPTION_TYPE'];
    sUBCRIPTIONENDDATE = json['SUBCRIPTION_END_DATE'];
    iSSUBCRIBE = json['ISSUBCRIBE'];
    cREATEDATE = json['CREATE_DATE'];
    uPDATEDATE = json['UPDATE_DATE'];
    mEDITATIONID = json['MEDITATION_ID'];
    sUBCRIPTIONdAYS = json['SUBCRIPTION_DAYS'];
    longestStrike = json['LONGEST_STRIKE'];
    totalStrike = json['TOTAL_STRIKE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['USER_ID'] = uSERID;
    data['SOCIAL_ID'] = sOCIALID;
    data['USER_NAME'] = username;
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
    data['SUBCRIPTION_TYPE'] = sUBCRIPTIONTYPE;
    data['SUBCRIPTION_END_DATE'] = sUBCRIPTIONENDDATE;
    data['ISSUBCRIBE'] = iSSUBCRIBE;
    data['CREATE_DATE'] = cREATEDATE;
    data['UPDATE_DATE'] = uPDATEDATE;
    data['MEDITATION_ID'] = mEDITATIONID;
    data['SUBCRIPTION_DAYS'] = sUBCRIPTIONdAYS;
    data['STRIKE'] = sTRIKE;
    data['LONGEST_STRIKE'] = longestStrike;
    data['TOTAL_STRIKE'] = totalStrike;
    return data;
  }
}

class MeditationData {
  int? mEDITATIONID;
  String? iMAGE;
  String? mUSIC;
  String? tITLE;
  String? sUBTITLE;
  String? tEXT;
  String? cREATEDATE;
  String? uPDATEDATE;
  String? uRLS;

  MeditationData(
      {this.mEDITATIONID,
      this.iMAGE,
      this.mUSIC,
      this.tITLE,
      this.sUBTITLE,
      this.tEXT,
      this.cREATEDATE,
      this.uRLS,
      this.uPDATEDATE});

  MeditationData.fromJson(Map<String, dynamic> json) {
    mEDITATIONID = json['MEDITATION_ID'];
    iMAGE = json['IMAGE'];
    mUSIC = json['MUSIC'];
    tITLE = json['TITLE'];
    sUBTITLE = json['SUBTITLE'];
    tEXT = json['TEXT'];
    cREATEDATE = json['CREATE_DATE'];
    uPDATEDATE = json['UPDATE_DATE'];
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
    data['URLS'] = uRLS;
    return data;
  }
}

class NextMeditationData {
  int? mEDITATIONID;
  String? iMAGE;
  String? mUSIC;
  String? tITLE;
  String? sUBTITLE;
  String? tEXT;
  String? cREATEDATE;
  String? uPDATEDATE;
  String? mEDITATIONTYPE;

  NextMeditationData(
      {this.mEDITATIONID,
      this.iMAGE,
      this.mUSIC,
      this.tITLE,
      this.sUBTITLE,
      this.tEXT,
      this.cREATEDATE,
      this.uPDATEDATE,
      this.mEDITATIONTYPE});

  NextMeditationData.fromJson(Map<String, dynamic> json) {
    mEDITATIONID = json['MEDITATION_ID'];
    iMAGE = json['IMAGE'];
    mUSIC = json['MUSIC'];
    tITLE = json['TITLE'];
    sUBTITLE = json['SUBTITLE'];
    tEXT = json['TEXT'];
    cREATEDATE = json['CREATE_DATE'];
    uPDATEDATE = json['UPDATE_DATE'];
    mEDITATIONTYPE = json['MEDITATION_TYPE'];
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
    return data;
  }
}
