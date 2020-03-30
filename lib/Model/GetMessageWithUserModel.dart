class MessageBody {
  var sender_id;
  var receiver_id;
  var body;
  var created_at;

  MessageBody({
    this.body,
    this.created_at,
    this.receiver_id,
    this.sender_id,
  });
}

List<MessageBody> ProfileCardModelGenerator(list) {
  List<MessageBody> profileList = new List();
  for (var item in list) {
    profileList.add(
      MessageBody(
        body: item['body'],
        created_at: item['created_at'],
        receiver_id: item['receiver_id'],
        sender_id: item['sender_id'],
      ),
    );
  }

  return profileList;
}
