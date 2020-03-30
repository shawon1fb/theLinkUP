import 'package:dio/dio.dart';

class ProfileCardModel {
  ProfileCardModel({
    this.id,
    this.name,
    this.imagesUrl,
    this.address,
    this.isConnected,
    //this.body,
  });

  var id;
  var name;
  var imagesUrl;
  var address;
  bool isConnected;
//var body;
}

List<ProfileCardModel> ProfileCardModelGenerator(list) {
  List<ProfileCardModel> profileList = new List();
  for (var item in list) {
    profileList.add(
      ProfileCardModel(
        id: item['creator']['id'],
        name: item['creator']['name'],
        imagesUrl: item['images'][0]['url'],
        address: item['body'],
        isConnected: item['connected'],
      ),
    );
  }

  return profileList;
}
