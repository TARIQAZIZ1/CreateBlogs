class blogModel{
  String bid= '';
  String title= '';
  String desc= '';
  String image= '';

  blogModel({required this.bid,required this.title, required this.desc, required this.image});
  factory blogModel.fromMap(map){
    return blogModel(
      bid: map['bid'],
      title: map['title'],
      desc: map['desc'],
      image: map['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bid': bid,
      'title': title,
      'desc': desc,
      'image': image,
    };
  }
}