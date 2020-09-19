class AssertTemplate {
  AssertTemplate({
    this.eval,
    this.message,
  });

  final String eval;
  final String message;

  @override
  String toString() {
    if (message != null) {
      return "assert($eval, '$message')";
    }
    return 'assert($eval)';
  }
}
