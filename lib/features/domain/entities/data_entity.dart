

class DataEntity {
  final List<DataEntityResult>? Result;
  DataEntity({this.Result});
}

class DataEntityResult{
  final String? id;
  final String? author;
  final int? width;
  final int? height;
  final String? url;
  final String? download_url;

  DataEntityResult({
    this.id,
    this.author,
    this.width,
    this.height,
    this.url,
    this.download_url,
  });
}
