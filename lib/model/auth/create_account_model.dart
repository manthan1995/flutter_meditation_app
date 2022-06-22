class CreateAccountModel {
  bool? status;
  String? msg;
  Data? data;
  MeditationData? meditationData;
  NextMeditationData? nextMeditationData;
  int? trialDays;

  CreateAccountModel({
    this.status,
    this.msg,
    this.data,
    this.meditationData,
    this.nextMeditationData,
  });

  CreateAccountModel.fromJson(Map<String, dynamic> json) {
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
  bool? iSACTIVE;
  bool? iSDELETE;
  bool? iSSTRIKE;
  String? cREATEDATE;
  String? uPDATEDATE;
  int? uSERID;
  String? tYPE;
  String? userName;
  String? eMAIL;
  String? pASSWORD;
  bool? iSSOCIAL;
  int? sTRIKE;
  String? mEDITATIONIDS;
  String? mEDITATIONSTARTDATE;
  int? mEDITATIONID;
  int? sUBCRIPTIONTYPE;
  String? sUBCRIPTIONENDDATE;
  bool? iSSUBCRIBE;
  int? sUBCRIPTIONdAYS;
  int? longestStrike;
  int? totalStrike;

  Data(
      {this.iSACTIVE,
      this.iSDELETE,
      this.iSSTRIKE,
      this.userName,
      this.cREATEDATE,
      this.uPDATEDATE,
      this.uSERID,
      this.tYPE,
      this.eMAIL,
      this.pASSWORD,
      this.iSSOCIAL,
      this.mEDITATIONIDS,
      this.mEDITATIONSTARTDATE,
      this.mEDITATIONID,
      this.sUBCRIPTIONTYPE,
      this.sUBCRIPTIONENDDATE,
      this.sUBCRIPTIONdAYS,
      this.sTRIKE,
      this.iSSUBCRIBE});

  Data.fromJson(Map<String, dynamic> json) {
    iSACTIVE = json['ISACTIVE'];
    iSDELETE = json['ISDELETE'];
    iSSTRIKE = json['ISSTRIKE'];
    userName = json['USER_NAME'];
    cREATEDATE = json['CREATE_DATE'];
    uPDATEDATE = json['UPDATE_DATE'];
    uSERID = json['USER_ID'];
    tYPE = json['TYPE'];
    eMAIL = json['EMAIL'];
    pASSWORD = json['PASSWORD'];
    iSSOCIAL = json['ISSOCIAL'];
    sTRIKE = json['STRIKE'];
    mEDITATIONIDS = json['MEDITATION_IDS'];
    mEDITATIONSTARTDATE = json['MEDITATION_START_DATE'];
    mEDITATIONID = json['MEDITATION_ID'];
    sUBCRIPTIONTYPE = json['SUBCRIPTION_TYPE'];
    sUBCRIPTIONENDDATE = json['SUBCRIPTION_END_DATE'];
    iSSUBCRIBE = json['ISSUBCRIBE'];
    sUBCRIPTIONdAYS = json['SUBCRIPTION_DAYS'];
    longestStrike = json['LONGEST_STRIKE'];
    totalStrike = json['TOTAL_STRIKE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ISACTIVE'] = iSACTIVE;
    data['ISDELETE'] = iSDELETE;
    data['USER_NAME'] = userName;
    data['ISSTRIKE'] = iSSTRIKE;
    data['CREATE_DATE'] = cREATEDATE;
    data['UPDATE_DATE'] = uPDATEDATE;
    data['USER_ID'] = uSERID;
    data['TYPE'] = tYPE;
    data['EMAIL'] = eMAIL;
    data['PASSWORD'] = pASSWORD;
    data['ISSOCIAL'] = iSSOCIAL;
    data['MEDITATION_IDS'] = mEDITATIONIDS;
    data['MEDITATION_START_DATE'] = mEDITATIONSTARTDATE;
    data['MEDITATION_ID'] = mEDITATIONID;
    data['SUBCRIPTION_TYPE'] = sUBCRIPTIONTYPE;
    data['SUBCRIPTION_END_DATE'] = sUBCRIPTIONENDDATE;
    data['ISSUBCRIBE'] = iSSUBCRIBE;
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
