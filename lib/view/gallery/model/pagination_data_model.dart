class PaginationDataModel {
  int page;
  int limit;

  PaginationDataModel({this.page, this.limit});

  PaginationDataModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    return data;
  }
}
