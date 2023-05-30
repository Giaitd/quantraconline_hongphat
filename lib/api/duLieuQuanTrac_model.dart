class DuLieuQuanTracModel {
  String thietBiId;
  String pH;
  String temp;
  String cod;
  String bod;
  String tss;
  String nh4;

  DuLieuQuanTracModel({
    this.thietBiId = "",
    this.pH = "",
    this.temp = "",
    this.cod = "",
    this.bod = "",
    this.tss = "",
    this.nh4 = "",
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'thietBiId': thietBiId.trim(),
      'pH': pH.trim(),
      'temp': temp.trim(),
      'cod': cod.trim(),
      'bod': bod.trim(),
      'tss': tss.trim(),
      'nh4': nh4.trim(),
    };

    return map;
  }
}
