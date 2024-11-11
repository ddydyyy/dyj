class KospiModel {
  final String BAS_DD, // 기준일자
      IDX_CLSS, // 계열 구분
      IDX_NM, // 지수명
      CLSPRC_IDX, // 종가
      CMPPREVDD_IDX, // 대비
      FLUC_RT, // 등락률
      OPNPRC_IDX, // 시가
      HGPRC_IDX, // 고가
      LWPRC_IDX, // 저가
      ACC_TRDVOL, // 거래량
      ACC_TRDVAL, // 거래대금
      MKTCAP; // 상장시가총액

  KospiModel.fromJson(Map<String, dynamic> json)
      : BAS_DD = json['BAS_DD'],
        IDX_CLSS = json['IDX_CLSS'],
        IDX_NM = json['IDX_NM'],
        CLSPRC_IDX = json['CLSPRC_IDX'],
        CMPPREVDD_IDX = json['CMPPREVDD_IDX'],
        FLUC_RT = json['FLUC_RT'],
        OPNPRC_IDX = json['OPNPRC_IDX'],
        HGPRC_IDX = json['HGPRC_IDX'],
        LWPRC_IDX = json['LWPRC_IDX'],
        ACC_TRDVOL = json['ACC_TRDVOL'],
        ACC_TRDVAL = json['ACC_TRDVAL'],
        MKTCAP = json['MKTCAP'];
}
