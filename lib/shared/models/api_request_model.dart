class ApiRequest {
  int paginate;
  int page;
  String text;

  ApiRequest(
    this.paginate,
    this.page,
    this.text
  );

  ApiRequest.fromJson(Map<String, dynamic> json) : 
    paginate = json['paginate'],
    page = json['page'],
    text = json['text'];

  Map<String, dynamic> toJson() => {
    "paginate": paginate,
    "page": page,
    "text": text
  };
}