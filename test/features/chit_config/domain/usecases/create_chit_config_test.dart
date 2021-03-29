import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vdo_chit_app/features/chit_config/domain/entities/chit_config.dart';
import 'package:vdo_chit_app/features/chit_config/domain/repositories/chit_config_repository.dart';
import 'package:vdo_chit_app/features/chit_config/domain/usecases/create_chit_config.dart';

class MockChitConfigRepository extends Mock implements ChitConfigRepository {}

void main() {
  CreateChitConfig usecase;
  MockChitConfigRepository mockChitConfigRepository;

  setUp(() {
    mockChitConfigRepository = MockChitConfigRepository();
    usecase = CreateChitConfig(mockChitConfigRepository);
  });

  final amount = 500000;
  final commissionPercentage = 3;
  final membersCount = 20;

  final chitConfig = ChitConfig(
      amount: amount,
      commissionPercentage: commissionPercentage,
      membersCount: membersCount);

  test('Should create chit for the input from the repository', () async {
    // arrange
    when(mockChitConfigRepository.createChitConfig(
      amount: amount,
      commissionPercentage: commissionPercentage,
      membersCount: membersCount,
    )).thenAnswer((_) async => chitConfig);
    // act
    final result = await usecase(Params(
      amount: amount,
      commissionPercentage: commissionPercentage,
      membersCount: membersCount,
    ));
    // assert
    expect(result, chitConfig);
    verify(mockChitConfigRepository.createChitConfig(
      amount: amount,
      commissionPercentage: commissionPercentage,
      membersCount: membersCount,
    ));
    verifyNoMoreInteractions(mockChitConfigRepository);
  });
}
