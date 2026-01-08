// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_list_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostListState {
  List<Post> get posts => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;

  /// Create a copy of PostListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostListStateCopyWith<PostListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostListStateCopyWith<$Res> {
  factory $PostListStateCopyWith(
          PostListState value, $Res Function(PostListState) then) =
      _$PostListStateCopyWithImpl<$Res, PostListState>;
  @useResult
  $Res call({List<Post> posts, bool isLoading, Object? error});
}

/// @nodoc
class _$PostListStateCopyWithImpl<$Res, $Val extends PostListState>
    implements $PostListStateCopyWith<$Res> {
  _$PostListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      posts: null == posts
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostListStateImplCopyWith<$Res>
    implements $PostListStateCopyWith<$Res> {
  factory _$$PostListStateImplCopyWith(
          _$PostListStateImpl value, $Res Function(_$PostListStateImpl) then) =
      __$$PostListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Post> posts, bool isLoading, Object? error});
}

/// @nodoc
class __$$PostListStateImplCopyWithImpl<$Res>
    extends _$PostListStateCopyWithImpl<$Res, _$PostListStateImpl>
    implements _$$PostListStateImplCopyWith<$Res> {
  __$$PostListStateImplCopyWithImpl(
      _$PostListStateImpl _value, $Res Function(_$PostListStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_$PostListStateImpl(
      posts: null == posts
          ? _value._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$PostListStateImpl implements _PostListState {
  const _$PostListStateImpl(
      {final List<Post> posts = const [], this.isLoading = false, this.error})
      : _posts = posts;

  final List<Post> _posts;
  @override
  @JsonKey()
  List<Post> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final Object? error;

  @override
  String toString() {
    return 'PostListState(posts: $posts, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostListStateImpl &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_posts),
      isLoading,
      const DeepCollectionEquality().hash(error));

  /// Create a copy of PostListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostListStateImplCopyWith<_$PostListStateImpl> get copyWith =>
      __$$PostListStateImplCopyWithImpl<_$PostListStateImpl>(this, _$identity);
}

abstract class _PostListState implements PostListState {
  const factory _PostListState(
      {final List<Post> posts,
      final bool isLoading,
      final Object? error}) = _$PostListStateImpl;

  @override
  List<Post> get posts;
  @override
  bool get isLoading;
  @override
  Object? get error;

  /// Create a copy of PostListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostListStateImplCopyWith<_$PostListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
