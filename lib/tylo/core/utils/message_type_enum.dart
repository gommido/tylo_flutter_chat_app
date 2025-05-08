enum MessageType{

  text('text'),
  image('image'),
  audio('audio'),
  video('video'),
  voiceNote('voiceNote'),
  videoCall('videoCall');
  final String type;
  const MessageType(this.type);

}

extension MessageConverter on String{
  MessageType toEnum(){
    switch(this){
      case 'text':
      return MessageType.text;
      case 'image':
        return MessageType.image;
      case 'audio':
        return MessageType.audio;
      case 'video':
        return MessageType.video;
      case 'voiceNote':
        return MessageType.voiceNote;
      case 'videoCall':
        return MessageType.videoCall;
        default:
          return MessageType.text;
    }
  }
}