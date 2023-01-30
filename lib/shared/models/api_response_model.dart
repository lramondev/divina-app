class ApiResponse {
  int current_page;
  int last_page;
  int per_page;
  int? from;
  int? to;
  int total;

  String first_page_url;
  String last_page_url;
  String? next_page_url;
  String? prev_page_url;
  String path;

  List<dynamic> data;

  String? error;

  ApiResponse(
    this.current_page, 
    this.last_page, 
    this.per_page, 
    this.from, 
    this.to, 
    this.total, 
    this.first_page_url, 
    this.last_page_url, 
    this.next_page_url, 
    this.prev_page_url, 
    this.path, 
    this.data
  );

  ApiResponse.fromJson(Map<String, dynamic> json)
    : current_page = json['current_page'],
      last_page = json['last_page'],
      per_page = 20,
      from = json['from'],
      to = json['to'],
      total = json['total'],
      first_page_url = json['first_page_url'],
      last_page_url = json['last_page_url'],
      next_page_url = json['next_page_url'],
      prev_page_url = json['prev_page_url'],
      path = json['path'],
      data = json['data'];

  Map<String, dynamic> toJson() => {
    "current_page": current_page,
    "last_page": last_page,
    "per_page": per_page,
    "from": from,
    "to": to,
    "total": total,
    "first_page_url": first_page_url,
    "last_page_url": last_page_url,
    "next_page_url": next_page_url,
    "prev_page_url": prev_page_url,
    "path": path,
    "data": data
  };
}
