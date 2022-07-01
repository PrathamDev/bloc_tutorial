import 'package:bloc_tutorial/bloc/bloc_actions.dart';
import 'package:bloc_tutorial/bloc/person.dart';
import 'package:bloc_tutorial/bloc/person_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

const mockedPerson1 = [
  Person(name: 'Foo', age: 20),
  Person(name: 'Bar', age: 30),
];

const mockedPerson2 = [
  Person(name: 'Foo', age: 20),
  Person(name: 'Bar', age: 30),
];

Future<Iterable<Person>> mockGetPerson1(String url) =>
    Future.value(mockedPerson1);
Future<Iterable<Person>> mockGetPerson2(String url) =>
    Future.value(mockedPerson2);

void main() {
  group(
    'Testing bloc',
    () {
      late PersonsBloc bloc;
      setUp(() {
        bloc = PersonsBloc();
      });

      blocTest<PersonsBloc, FetchResult?>(
        'Test Initial State',
        build: () => bloc,
        verify: (bloc) => expect(bloc.state, null),
      );

      blocTest<PersonsBloc, FetchResult?>(
        'Mock retrieving persons from first iterable',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
            const LoadPersonsAction(
              url: 'dummy_url_1',
              loader: mockGetPerson1,
            ),
          );
          bloc.add(
            const LoadPersonsAction(
              url: 'dummy_url_1',
              loader: mockGetPerson1,
            ),
          );
        },
        expect: () => [
          const FetchResult(
              persons: mockedPerson1, isRetrievedFromCache: false),
          const FetchResult(persons: mockedPerson1, isRetrievedFromCache: true),
        ],
      );
      blocTest<PersonsBloc, FetchResult?>(
        'Mock retrieving persons from second iterable',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
            const LoadPersonsAction(
              url: 'dummy_url_2',
              loader: mockGetPerson2,
            ),
          );
          bloc.add(
            const LoadPersonsAction(
              url: 'dummy_url_2',
              loader: mockGetPerson2,
            ),
          );
        },
        expect: () => [
          const FetchResult(
              persons: mockedPerson2, isRetrievedFromCache: false),
          const FetchResult(persons: mockedPerson2, isRetrievedFromCache: true),
        ],
      );
    },
  );
}
