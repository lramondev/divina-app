class RepositoryResponse {
  String? type;
  String? title;
  String icon;
  String message;
  String? timer;
  dynamic data;

  RepositoryResponse(
    this.type,
    this.title,
    this.icon,
    this.message,
    this.timer,
    this.data
  );

  RepositoryResponse.fromJson(Map<String, dynamic> json) : 
    type = json['type'],
    title = json['title'],
    icon = json['icon'],
    message = json['message'],
    timer = json['timer'],
    data = json['data'];

  Map<String, dynamic> toJson() => {
    "type": type,
    "title": title,
    "icon": icon,
    "message": message,
    "timer": timer,
    "data": data
  };

  static List<RepositoryResponse> fromJsonList(List data) {
    return data.map((item) => RepositoryResponse.fromJson(item)).toList();
  }
}