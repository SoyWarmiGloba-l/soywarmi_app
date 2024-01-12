

import 'package:bloc/bloc.dart';
import 'package:soywarmi_app/domain/usescase/chat_conversations/get_chat_conversations_usecase.dart';
import 'package:soywarmi_app/presentation/bloc/chat_conversations/get_chat_conversations_state.dart';

import '../../../core/usecases.dart';

class GetChatConversationsCubit extends Cubit<GetChatConversationsState> {
  GetChatConversationsCubit({required this.getChatConversationsUseCase}):super(GetChatConversationsInitial());
  final GetChatConversationsUseCase getChatConversationsUseCase;
  Future<void> getChatConversations() async {
    emit(GetChatConversationsLoading());
    final failureOrChatConversations =
    await getChatConversationsUseCase.call(NoParams());
    failureOrChatConversations.fold(
          (failure) => emit(GetChatConversationsError(message: failure.message)),
          (chatConversations) =>
          emit(GetChatConversationsLoaded(chat_conversations: chatConversations)),
    );
  }
}
