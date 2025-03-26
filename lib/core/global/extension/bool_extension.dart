extension BoolExtension on bool {
  T? then<T>(T? Function() ifTrue, {T? Function()? or}) {
    if (this) return ifTrue();
    return or?.call();
  }
}
