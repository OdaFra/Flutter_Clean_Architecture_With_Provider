import 'package:freezed_annotation/freezed_annotation.dart';

part 'either.freezed.dart';

@freezed
class Either<L, R> with _$Either<L, R> {
  factory Either.left(L value) = Left;
  factory Either.right(R value) = Right;
}

 //  Either._(this._left, this._right, this.isLeft);

  // factory Either.left(Left failure) {
  //   return Either._(failure, null, true);
  // }
  // factory Either.right(Right value) {
  //   return Either._(null, value, false);
  // }
  // final Left? _left;
  // final Right? _right;
  // final bool isLeft;

  // T when<T>(
  //   T Function(Left) left,
  //   T Function(Right) right,
  // ) {
  //   if (isLeft) {
  //     return left(_left as Left);
  //   } else {
  //     return right(_right as Right);
  //   }
  // }