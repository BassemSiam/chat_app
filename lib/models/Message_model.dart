class Message{

 String? message;
 String? id;

  Message(this.message,this.id);

  Message.fromJson( json){
    message = json['Messages'];
    id = json['id'];
  }
}