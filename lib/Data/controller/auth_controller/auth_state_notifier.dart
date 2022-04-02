import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';

part 'auth_state_notifier.freezed.dart';

class AuthStateNotifier<T> extends StateNotifier<AuthState<T>> {
  AuthStateNotifier() : super(const AuthState.authUnauthenticated());

  Future<AuthState<T>> makeRequest(Future<T> Function() function) async {
    try {
      state = AuthState<T>.authLoading();
      final response = await function();
      final newState = AuthState<T>.authAuthenticated(response);
      if (mounted) {
        state = newState;
      }
      return newState;
    } catch (e, st) {
      final newState = AuthState<T>.authError(e, st);
      if (mounted) {
        state = newState;
      }
      return newState;
    }
  }
}

@freezed
class AuthState<T> with _$AuthState<T> {
  const factory AuthState.authUnauthenticated() = AuthUnauthenticated<T>;

  const factory AuthState.authLoading() = AuthLoading<T>;

  const factory AuthState.authAuthenticated(T? value) = AuthAuthenticated<T>;

  const factory AuthState.authError(Object error, StackTrace stackTrace) =
      AuthError<T>;
}
