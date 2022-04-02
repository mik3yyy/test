// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_state_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AuthStateTearOff {
  const _$AuthStateTearOff();

  AuthUnauthenticated<T> authUnauthenticated<T>() {
    return AuthUnauthenticated<T>();
  }

  AuthLoading<T> authLoading<T>() {
    return AuthLoading<T>();
  }

  AuthAuthenticated<T> authAuthenticated<T>(T? value) {
    return AuthAuthenticated<T>(
      value,
    );
  }

  AuthError<T> authError<T>(Object error, StackTrace stackTrace) {
    return AuthError<T>(
      error,
      stackTrace,
    );
  }
}

/// @nodoc
const $AuthState = _$AuthStateTearOff();

/// @nodoc
mixin _$AuthState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() authUnauthenticated,
    required TResult Function() authLoading,
    required TResult Function(T? value) authAuthenticated,
    required TResult Function(Object error, StackTrace stackTrace) authError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? authUnauthenticated,
    TResult Function()? authLoading,
    TResult Function(T? value)? authAuthenticated,
    TResult Function(Object error, StackTrace stackTrace)? authError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? authUnauthenticated,
    TResult Function()? authLoading,
    TResult Function(T? value)? authAuthenticated,
    TResult Function(Object error, StackTrace stackTrace)? authError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthUnauthenticated<T> value) authUnauthenticated,
    required TResult Function(AuthLoading<T> value) authLoading,
    required TResult Function(AuthAuthenticated<T> value) authAuthenticated,
    required TResult Function(AuthError<T> value) authError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AuthUnauthenticated<T> value)? authUnauthenticated,
    TResult Function(AuthLoading<T> value)? authLoading,
    TResult Function(AuthAuthenticated<T> value)? authAuthenticated,
    TResult Function(AuthError<T> value)? authError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthUnauthenticated<T> value)? authUnauthenticated,
    TResult Function(AuthLoading<T> value)? authLoading,
    TResult Function(AuthAuthenticated<T> value)? authAuthenticated,
    TResult Function(AuthError<T> value)? authError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<T, $Res> {
  factory $AuthStateCopyWith(
          AuthState<T> value, $Res Function(AuthState<T>) then) =
      _$AuthStateCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<T, $Res> implements $AuthStateCopyWith<T, $Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  final AuthState<T> _value;
  // ignore: unused_field
  final $Res Function(AuthState<T>) _then;
}

/// @nodoc
abstract class $AuthUnauthenticatedCopyWith<T, $Res> {
  factory $AuthUnauthenticatedCopyWith(AuthUnauthenticated<T> value,
          $Res Function(AuthUnauthenticated<T>) then) =
      _$AuthUnauthenticatedCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$AuthUnauthenticatedCopyWithImpl<T, $Res>
    extends _$AuthStateCopyWithImpl<T, $Res>
    implements $AuthUnauthenticatedCopyWith<T, $Res> {
  _$AuthUnauthenticatedCopyWithImpl(AuthUnauthenticated<T> _value,
      $Res Function(AuthUnauthenticated<T>) _then)
      : super(_value, (v) => _then(v as AuthUnauthenticated<T>));

  @override
  AuthUnauthenticated<T> get _value => super._value as AuthUnauthenticated<T>;
}

/// @nodoc

class _$AuthUnauthenticated<T> implements AuthUnauthenticated<T> {
  const _$AuthUnauthenticated();

  @override
  String toString() {
    return 'AuthState<$T>.authUnauthenticated()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthUnauthenticated<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() authUnauthenticated,
    required TResult Function() authLoading,
    required TResult Function(T? value) authAuthenticated,
    required TResult Function(Object error, StackTrace stackTrace) authError,
  }) {
    return authUnauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? authUnauthenticated,
    TResult Function()? authLoading,
    TResult Function(T? value)? authAuthenticated,
    TResult Function(Object error, StackTrace stackTrace)? authError,
  }) {
    return authUnauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? authUnauthenticated,
    TResult Function()? authLoading,
    TResult Function(T? value)? authAuthenticated,
    TResult Function(Object error, StackTrace stackTrace)? authError,
    required TResult orElse(),
  }) {
    if (authUnauthenticated != null) {
      return authUnauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthUnauthenticated<T> value) authUnauthenticated,
    required TResult Function(AuthLoading<T> value) authLoading,
    required TResult Function(AuthAuthenticated<T> value) authAuthenticated,
    required TResult Function(AuthError<T> value) authError,
  }) {
    return authUnauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AuthUnauthenticated<T> value)? authUnauthenticated,
    TResult Function(AuthLoading<T> value)? authLoading,
    TResult Function(AuthAuthenticated<T> value)? authAuthenticated,
    TResult Function(AuthError<T> value)? authError,
  }) {
    return authUnauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthUnauthenticated<T> value)? authUnauthenticated,
    TResult Function(AuthLoading<T> value)? authLoading,
    TResult Function(AuthAuthenticated<T> value)? authAuthenticated,
    TResult Function(AuthError<T> value)? authError,
    required TResult orElse(),
  }) {
    if (authUnauthenticated != null) {
      return authUnauthenticated(this);
    }
    return orElse();
  }
}

abstract class AuthUnauthenticated<T> implements AuthState<T> {
  const factory AuthUnauthenticated() = _$AuthUnauthenticated<T>;
}

/// @nodoc
abstract class $AuthLoadingCopyWith<T, $Res> {
  factory $AuthLoadingCopyWith(
          AuthLoading<T> value, $Res Function(AuthLoading<T>) then) =
      _$AuthLoadingCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$AuthLoadingCopyWithImpl<T, $Res>
    extends _$AuthStateCopyWithImpl<T, $Res>
    implements $AuthLoadingCopyWith<T, $Res> {
  _$AuthLoadingCopyWithImpl(
      AuthLoading<T> _value, $Res Function(AuthLoading<T>) _then)
      : super(_value, (v) => _then(v as AuthLoading<T>));

  @override
  AuthLoading<T> get _value => super._value as AuthLoading<T>;
}

/// @nodoc

class _$AuthLoading<T> implements AuthLoading<T> {
  const _$AuthLoading();

  @override
  String toString() {
    return 'AuthState<$T>.authLoading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthLoading<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() authUnauthenticated,
    required TResult Function() authLoading,
    required TResult Function(T? value) authAuthenticated,
    required TResult Function(Object error, StackTrace stackTrace) authError,
  }) {
    return authLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? authUnauthenticated,
    TResult Function()? authLoading,
    TResult Function(T? value)? authAuthenticated,
    TResult Function(Object error, StackTrace stackTrace)? authError,
  }) {
    return authLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? authUnauthenticated,
    TResult Function()? authLoading,
    TResult Function(T? value)? authAuthenticated,
    TResult Function(Object error, StackTrace stackTrace)? authError,
    required TResult orElse(),
  }) {
    if (authLoading != null) {
      return authLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthUnauthenticated<T> value) authUnauthenticated,
    required TResult Function(AuthLoading<T> value) authLoading,
    required TResult Function(AuthAuthenticated<T> value) authAuthenticated,
    required TResult Function(AuthError<T> value) authError,
  }) {
    return authLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AuthUnauthenticated<T> value)? authUnauthenticated,
    TResult Function(AuthLoading<T> value)? authLoading,
    TResult Function(AuthAuthenticated<T> value)? authAuthenticated,
    TResult Function(AuthError<T> value)? authError,
  }) {
    return authLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthUnauthenticated<T> value)? authUnauthenticated,
    TResult Function(AuthLoading<T> value)? authLoading,
    TResult Function(AuthAuthenticated<T> value)? authAuthenticated,
    TResult Function(AuthError<T> value)? authError,
    required TResult orElse(),
  }) {
    if (authLoading != null) {
      return authLoading(this);
    }
    return orElse();
  }
}

abstract class AuthLoading<T> implements AuthState<T> {
  const factory AuthLoading() = _$AuthLoading<T>;
}

/// @nodoc
abstract class $AuthAuthenticatedCopyWith<T, $Res> {
  factory $AuthAuthenticatedCopyWith(AuthAuthenticated<T> value,
          $Res Function(AuthAuthenticated<T>) then) =
      _$AuthAuthenticatedCopyWithImpl<T, $Res>;
  $Res call({T? value});
}

/// @nodoc
class _$AuthAuthenticatedCopyWithImpl<T, $Res>
    extends _$AuthStateCopyWithImpl<T, $Res>
    implements $AuthAuthenticatedCopyWith<T, $Res> {
  _$AuthAuthenticatedCopyWithImpl(
      AuthAuthenticated<T> _value, $Res Function(AuthAuthenticated<T>) _then)
      : super(_value, (v) => _then(v as AuthAuthenticated<T>));

  @override
  AuthAuthenticated<T> get _value => super._value as AuthAuthenticated<T>;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(AuthAuthenticated<T>(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc

class _$AuthAuthenticated<T> implements AuthAuthenticated<T> {
  const _$AuthAuthenticated(this.value);

  @override
  final T? value;

  @override
  String toString() {
    return 'AuthState<$T>.authAuthenticated(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthAuthenticated<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  $AuthAuthenticatedCopyWith<T, AuthAuthenticated<T>> get copyWith =>
      _$AuthAuthenticatedCopyWithImpl<T, AuthAuthenticated<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() authUnauthenticated,
    required TResult Function() authLoading,
    required TResult Function(T? value) authAuthenticated,
    required TResult Function(Object error, StackTrace stackTrace) authError,
  }) {
    return authAuthenticated(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? authUnauthenticated,
    TResult Function()? authLoading,
    TResult Function(T? value)? authAuthenticated,
    TResult Function(Object error, StackTrace stackTrace)? authError,
  }) {
    return authAuthenticated?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? authUnauthenticated,
    TResult Function()? authLoading,
    TResult Function(T? value)? authAuthenticated,
    TResult Function(Object error, StackTrace stackTrace)? authError,
    required TResult orElse(),
  }) {
    if (authAuthenticated != null) {
      return authAuthenticated(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthUnauthenticated<T> value) authUnauthenticated,
    required TResult Function(AuthLoading<T> value) authLoading,
    required TResult Function(AuthAuthenticated<T> value) authAuthenticated,
    required TResult Function(AuthError<T> value) authError,
  }) {
    return authAuthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AuthUnauthenticated<T> value)? authUnauthenticated,
    TResult Function(AuthLoading<T> value)? authLoading,
    TResult Function(AuthAuthenticated<T> value)? authAuthenticated,
    TResult Function(AuthError<T> value)? authError,
  }) {
    return authAuthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthUnauthenticated<T> value)? authUnauthenticated,
    TResult Function(AuthLoading<T> value)? authLoading,
    TResult Function(AuthAuthenticated<T> value)? authAuthenticated,
    TResult Function(AuthError<T> value)? authError,
    required TResult orElse(),
  }) {
    if (authAuthenticated != null) {
      return authAuthenticated(this);
    }
    return orElse();
  }
}

abstract class AuthAuthenticated<T> implements AuthState<T> {
  const factory AuthAuthenticated(T? value) = _$AuthAuthenticated<T>;

  T? get value;
  @JsonKey(ignore: true)
  $AuthAuthenticatedCopyWith<T, AuthAuthenticated<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthErrorCopyWith<T, $Res> {
  factory $AuthErrorCopyWith(
          AuthError<T> value, $Res Function(AuthError<T>) then) =
      _$AuthErrorCopyWithImpl<T, $Res>;
  $Res call({Object error, StackTrace stackTrace});
}

/// @nodoc
class _$AuthErrorCopyWithImpl<T, $Res> extends _$AuthStateCopyWithImpl<T, $Res>
    implements $AuthErrorCopyWith<T, $Res> {
  _$AuthErrorCopyWithImpl(
      AuthError<T> _value, $Res Function(AuthError<T>) _then)
      : super(_value, (v) => _then(v as AuthError<T>));

  @override
  AuthError<T> get _value => super._value as AuthError<T>;

  @override
  $Res call({
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(AuthError<T>(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Object,
      stackTrace == freezed
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace,
    ));
  }
}

/// @nodoc

class _$AuthError<T> implements AuthError<T> {
  const _$AuthError(this.error, this.stackTrace);

  @override
  final Object error;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'AuthState<$T>.authError(error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthError<T> &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality()
                .equals(other.stackTrace, stackTrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(stackTrace));

  @JsonKey(ignore: true)
  @override
  $AuthErrorCopyWith<T, AuthError<T>> get copyWith =>
      _$AuthErrorCopyWithImpl<T, AuthError<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() authUnauthenticated,
    required TResult Function() authLoading,
    required TResult Function(T? value) authAuthenticated,
    required TResult Function(Object error, StackTrace stackTrace) authError,
  }) {
    return authError(error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? authUnauthenticated,
    TResult Function()? authLoading,
    TResult Function(T? value)? authAuthenticated,
    TResult Function(Object error, StackTrace stackTrace)? authError,
  }) {
    return authError?.call(error, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? authUnauthenticated,
    TResult Function()? authLoading,
    TResult Function(T? value)? authAuthenticated,
    TResult Function(Object error, StackTrace stackTrace)? authError,
    required TResult orElse(),
  }) {
    if (authError != null) {
      return authError(error, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthUnauthenticated<T> value) authUnauthenticated,
    required TResult Function(AuthLoading<T> value) authLoading,
    required TResult Function(AuthAuthenticated<T> value) authAuthenticated,
    required TResult Function(AuthError<T> value) authError,
  }) {
    return authError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(AuthUnauthenticated<T> value)? authUnauthenticated,
    TResult Function(AuthLoading<T> value)? authLoading,
    TResult Function(AuthAuthenticated<T> value)? authAuthenticated,
    TResult Function(AuthError<T> value)? authError,
  }) {
    return authError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthUnauthenticated<T> value)? authUnauthenticated,
    TResult Function(AuthLoading<T> value)? authLoading,
    TResult Function(AuthAuthenticated<T> value)? authAuthenticated,
    TResult Function(AuthError<T> value)? authError,
    required TResult orElse(),
  }) {
    if (authError != null) {
      return authError(this);
    }
    return orElse();
  }
}

abstract class AuthError<T> implements AuthState<T> {
  const factory AuthError(Object error, StackTrace stackTrace) = _$AuthError<T>;

  Object get error;
  StackTrace get stackTrace;
  @JsonKey(ignore: true)
  $AuthErrorCopyWith<T, AuthError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
