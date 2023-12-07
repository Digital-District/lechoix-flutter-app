class PaginationModel {
  int? currentPage;
  String? firstPageUrl;
  dynamic prevPageUrl;
  dynamic nextPageUrl;
  String? lastPageUrl;
  int? lastPage;
  int? perPage;
  int? total;
  String? path;

  bool get isEndOfList => currentPage == lastPage;

  int get nextPage => (currentPage ?? 0) + 1;

  PaginationModel({
    this.currentPage,
    this.firstPageUrl,
    this.prevPageUrl,
    this.nextPageUrl,
    this.lastPageUrl,
    this.lastPage,
    this.perPage,
    this.total,
    this.path,
  });

  PaginationModel.fromJson(dynamic json) {
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    prevPageUrl = json['prev_page_url'];
    nextPageUrl = json['next_page_url'];
    lastPageUrl = json['last_page_url'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    map['first_page_url'] = firstPageUrl;
    map['prev_page_url'] = prevPageUrl;
    map['next_page_url'] = nextPageUrl;
    map['last_page_url'] = lastPageUrl;
    map['last_page'] = lastPage;
    map['per_page'] = perPage;
    map['total'] = total;
    map['path'] = path;
    return map;
  }
}
