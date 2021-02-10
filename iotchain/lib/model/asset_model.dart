class Asset {
  String uniqueID;
  String name;
  String description;
  String value;
  String owner;

  static Asset fromJson(json) {
    Asset asset = new Asset();
    asset.name = json["name"];
    asset.description = json["description"];
    asset.value = json["value"];
    asset.owner = json["owner"];
    return asset;
  }
}

