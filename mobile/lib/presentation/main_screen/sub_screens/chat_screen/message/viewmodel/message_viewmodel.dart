import 'package:sed/app/di.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/usecase/chat_messages_usecase.dart';
import 'package:sed/domain/usecase/chat_send_message_usecase.dart';
import 'package:sed/domain/usecase/new_conversation_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/sub_screens/chat_screen/viewmodel/chat_screen_viewmodel.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';

class MessageViewModel extends BaseViewModel
    with MessageViewModelInputs, MessageViewModelOutputs {
  final NewConversationUseCase _newConversationUseCase =
      instance<NewConversationUseCase>();

  final ChatMessagesUseCase _chatMessagesUseCase =
      instance<ChatMessagesUseCase>();

  final NewMessageUseCase _newMessageUseCase =
      instance<NewMessageUseCase>();

  @override
  void start() {}

  @override
  Future<String> createNewConversation(String sellerId) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    var response = await _newConversationUseCase.execute(
        NewConversationUseCaseInputs(Utils.getUserId(), sellerId));

    String conversationId = "";

    response.fold(
        (failure) => {
              // left -> failure
            }, (response) {
      // right -> success

      conversationId = response.conversationId;

      inputState.add(ContentState());
    });

    return conversationId;
  }

  @override
  Future<GetChatMessages> getConversationMessages(String conversationId) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    var response = await _chatMessagesUseCase.execute(
        ChatMessageUseCaseInput(conversationId));

    GetChatMessages result = GetChatMessages([]);

    response.fold(
        (failure) => {
              // left -> failure
            }, (response) {
      // right -> success

      result = response;
      
      inputState.add(ContentState());
    });

    return result;
  }

  @override
  void sendMessage(String conversationId, String senderId, String message) async{
    final ChatViewModel _chatViewModel =
    instance<ChatViewModel>();

    _chatViewModel.socket.emit('sendMessage', NewMessageUseCaseInput(conversationId, senderId, message));
  }

}

abstract class MessageViewModelInputs {
  Future<String> createNewConversation(String sellerId);

  Future<GetChatMessages> getConversationMessages(String conversationId);

  void sendMessage(String conversationId, String senderId, String message);
}

abstract class MessageViewModelOutputs {}
