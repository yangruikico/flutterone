/// lableName : "name"
/// isCheck : true

class FaceLabel {
  String labelName;
  bool isCheck;

  static FaceLabel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    FaceLabel faceLabelBean = FaceLabel();
    faceLabelBean.labelName = map['labelName'];
    faceLabelBean.isCheck = map['isCheck'];
    return faceLabelBean;
  }

  Map toJson() => {
    "labelName": labelName,
    "isCheck": isCheck,
  };
}