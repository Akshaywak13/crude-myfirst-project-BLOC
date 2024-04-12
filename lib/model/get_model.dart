
class GetModel {
    int? createdAt;
    String? name;
    dynamic avatar;
    String? id;
    int? creatAt;

    GetModel({
        this.createdAt,
        this.name,
        this.avatar,
        this.id,
        this.creatAt,
    });

    factory GetModel.fromJson(Map<String, dynamic> json) => GetModel(
        createdAt: json["createdAt"],
        name: json["name"],
        avatar: json["avatar"],
        id: json["id"],
        creatAt: json["creatAt"],
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "name": name,
        "avatar": avatar,
        "id": id,
        "creatAt": creatAt,
    };
}
