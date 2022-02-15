
import 'package:chat_socket/model/chat_model.dart';
import 'package:flutter/material.dart';

class SourceModelProvider extends ChangeNotifier{

  ChatModel _source_chatModel=ChatModel() ;

  setSourceChatModel(ChatModel chatModel){
    _source_chatModel=chatModel;
    notifyListeners();
  }
  get sourceChatModel{
    return _source_chatModel;
  }
  get sourceChatModelid{
    return _source_chatModel.id;
  }
  ChatModel targetmodel=ChatModel() ;

  setTargetChatModel(ChatModel chatModel){
    targetmodel=chatModel;
    notifyListeners();
  }

  get gettagetmodelid{
    return targetmodel.id;
  }

}