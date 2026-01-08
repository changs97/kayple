// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_detail_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostDetailState {
  Post? get post => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;

  /// Create a copy of PostDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostDetailStateCopyWith<PostDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostDetailStateCopyWith<$Res> {
  factory $PostDetailStateCopyWith(
          PostDetailState value, $Res Function(PostDetailState) then) =
      _$PostDetailStateCopyWithImpl<$Res, PostDetailState>;
  @useResult
  $Res call({Post? post, bool isLoading, Object? error});

  $PostCopyWith<$Res>? get post;
}

/// @nodoc
class _$PostDetailStateCopyWithImpl<$Res, $Val extends PostDetailState>
    implements $PostDetailStateCopyWith<$Res> {
  _$PostDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? post = freezed,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      post: freezed == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as Post?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
    ) as $Val);
  }

  /// Create a copy of PostDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostCopyWith<$Res>? get post {
    if (_value.post == null) {
      return null;
    }

    return $PostCopyWith<$Res>(_value.post!, (value) {
      return _then(_value.copyWith(post: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostDetailStateImplCopyWith<$Res>
    implements $PostDetailStateCopyWith<$Res> {
  factory _$$PostDetailStateImplCopyWith(_$PostDetailStateImpl value,
          $Res Function(_$PostDetailStateImpl) then) =
      __$$PostDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Post? post, bool isLoading, Object? error});

  @override
  $PostCopyWith<$Res>? get post;
}

/// @nodoc
class __$$PostDetailStateImplCopyWithImpl<$Res>
    extends _$PostDetailStateCopyWithImpl<$Res, _$PostDetailStateImpl>
    implements _$$PostDetailStateImplCopyWith<$Res> {
  __$$PostDetailStateImplCopyWithImpl(
      _$PostDetailStateImpl _value, $Res Function(_$PostDetailStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? post = freezed,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_$PostDetailStateImpl(
      post: freezed == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as Post?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$PostDetailStateImpl implements _PostDetailState {
  const _$PostDetailStateImpl({this.post, this.isLoading = false, this.error});

  @override
  final Post? post;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final Object? error;

  @override
  String toString() {
    return 'PostDetailState(post: $post, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostDetailStateImpl &&
            (identical(other.post, post) || other.post == post) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, post, isLoading, const DeepCollectionEquality().hash(error));

  /// Create a copy of PostDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostDetailStateImplCopyWith<_$PostDetailStateImpl> get copyWith =>
      __$$PostDetailStateImplCopyWithImpl<_$PostDetailStateImpl>(
          this, _$identity);
}

abstract class _PostDetailState implements PostDetailState {
  const factory _PostDetailState(
      {final Post? post,
      final bool isLoading,
      final Object? error}) = _$PostDetailStateImpl;

  @override
  Post? get post;
  @override
  bool get isLoading;
  @override
  Object? get error;

  /// Create a copy of PostDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostDetailStateImplCopyWith<_$PostDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
