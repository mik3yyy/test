// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:kayndrexsphere_mobile/Data/services/messages/message_repository/message_manager.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/models/chat_model.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/models/my_event.dart';

final localMsgProvider = StateNotifierProvider.autoDispose<
    RemoteMessageNotifier, LocalMessagesState>((ref) {
  return RemoteMessageNotifier(ref);
});

class LocalMessagesState extends Equatable {
  final List<ChatModel> chatmodel;
  final bool isLoading;
  const LocalMessagesState({required this.chatmodel, required this.isLoading});

  factory LocalMessagesState.initial() {
    return const LocalMessagesState(chatmodel: [], isLoading: true);
  }

  LocalMessagesState copyWith({
    List<ChatModel>? chatmodel,
    bool? isLoading,
  }) =>
      LocalMessagesState(
          chatmodel: chatmodel ?? this.chatmodel,
          isLoading: isLoading ?? this.isLoading);

  @override
  List<Object?> get props => [chatmodel, isLoading];
}

class RemoteMessageNotifier extends StateNotifier<LocalMessagesState> {
  final Ref ref;
  RemoteMessageNotifier(this.ref) : super(LocalMessagesState.initial());

  void getRemoteList(int uuid) async {
    try {
      final res =
          await ref.read(messageManagerProvider).getDialogMessages(uuid);
      final messageList = res.data!.messages;
      for (var msg in messageList) {
        var newList = ChatModel(
            id: msg.id!.toInt(),
            dialogId: msg.dialogId!.toInt(),
            message: msg.message.toString(),
            sentAt: msg.sentAt!,
            firstName: msg.from!.firstName.toString(),
            lastName: msg.from!.lastName.toString(),
            email: msg.from!.email.toString());
        if (mounted) {
          state = state.copyWith(chatmodel: [...state.chatmodel, newList]);
        }
      }
      state = state.copyWith(isLoading: false);
    } catch (e) {
      throw e.toString();
    }
  }

  void addFromPusher(MyEvent msg) async {
    var newList = ChatModel(
        id: msg.message!.id!.toInt(),
        dialogId: msg.message!.dialogId!.toInt(),
        message: msg.message!.message.toString(),
        sentAt: msg.message!.sentAt!,
        firstName: msg.message!.from!.firstName.toString(),
        lastName: msg.message!.from!.lastName.toString(),
        email: msg.message!.from!.email.toString());

    state = state.copyWith(chatmodel: [...state.chatmodel, newList]);
  }
}
