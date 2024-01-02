
import 'package:bloc/bloc.dart';

import '../../../domain/entity/user_entity.dart';
import '../../../domain/usescase/chat_conversations/create_chat_conversations_usecase.dart';
import 'create_chat_conversations_state.dart';

class CreateChatConversationCubit extends Cubit<CreateChatConversationsState> {
  CreateChatConversationCubit({
    required CreateChatConversationsUseCase createChatConversationsUseCase,
  })  : _createChatConversationsUseCase = createChatConversationsUseCase,
        super(CreateChatConversationsInitial());

  final CreateChatConversationsUseCase _createChatConversationsUseCase;

  Future<void> createChatConversation({String? name,List<String>? users}) async {
    emit(CreateChatConversationsLoading());

    final result = await _createChatConversationsUseCase.call(
      CreateChatConversationsParams(
        name: name,
        users:users,
      ),
    );

    result.fold(
          (failure) => emit(CreateChatConversationsFailed(failure)),
          (id) => emit(CreateChatConversationsSuccess(id:id)),
    );
  }
}