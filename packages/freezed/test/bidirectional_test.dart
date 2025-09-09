import 'package:analyzer/dart/analysis/results.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'integration/bidirectional.dart';

void main() {
  test('has no issue', () async {
    final main = await resolveSources(
      {'freezed|test/integration/bidirectional.dart': useAssetReader},
      (r) => r.libraries.firstWhere(
        (element) =>
            element.firstFragment.source.toString().contains('bidirectional'),
      ),
    );

    final errorResult =
        await main.session.getErrors(
              '/freezed/test/integration/bidirectional.freezed.dart',
            )
            as ErrorsResult;

    expect(errorResult.diagnostics, isEmpty);
  });

  test('bidirectional deep_copy', () {
    final person = Person(
      name: 'Adam',
      age: 36,
      appointment: Appointment(
        title: 'Some Appointment',
        creator: Person(
          name: 'Bob',
          age: 24,
          appointment: Appointment(title: 'Other Appointment'),
        ),
      ),
    );

    expect(
      person.copyWith.appointment!.creator!(name: 'Steve'),
      Person(
        name: 'Adam',
        age: 36,
        appointment: Appointment(
          title: 'Some Appointment',
          creator: Person(
            name: 'Steve',
            age: 24,
            appointment: Appointment(title: 'Other Appointment'),
          ),
        ),
      ),
    );

    expect(
      person.copyWith.appointment!.creator!.appointment!(
        title: 'Some New Appointment',
      ),
      Person(
        name: 'Adam',
        age: 36,
        appointment: Appointment(
          title: 'Some Appointment',
          creator: Person(
            name: 'Bob',
            age: 24,
            appointment: Appointment(title: 'Some New Appointment'),
          ),
        ),
      ),
    );
  });
}
