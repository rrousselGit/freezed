class AssertTemplate {
  AssertTemplate({
    this.eval,
    this.message,
  });

  final String? eval;
  final String? message;

  @override
  String toString() {
    if (message != null) {
      final newMessage = message!.replaceAll('"', '\\"').replaceAll("'", "\\'");

      return "assert($eval, '$newMessage')";
    }
    return 'assert($eval)';
  }
}
