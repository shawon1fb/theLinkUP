class RecentUsers {
  var id;
  var name;
  var gender;
  var pictureUrl;
  bool unread;

  RecentUsers({
    this.name,
    this.id,
    this.gender,
    this.pictureUrl,
    this.unread,
  });
}

List<RecentUsers> getRecentUsersList(list) {
  List<RecentUsers> recentUsersListData = new List();
  for (var item in list) {
    try {
      var b = item['picture']['url'];
    } catch (e) {
      print('========');
      item['picture'] = {
        "url":
            "https://github.com/shawon1fb/storeImage/blob/master/squre/black.png?raw=true"
      };
      print(item['picture']['url']);
      print('========');
      print(e);
    }
    recentUsersListData.add(
      RecentUsers(
        id: item['id'],
        name: item['name'],
        gender: item['gender'],
        pictureUrl: item['picture']['url'],
        unread: item['unread'],
      ),
    );
  }

  return recentUsersListData;
}
