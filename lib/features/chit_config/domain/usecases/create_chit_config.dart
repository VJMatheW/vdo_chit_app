import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/chit_config.dart';
import '../repositories/chit_config_repository.dart';

class CreateChitConfig implements UseCase<ChitConfig, Params> {
  final ChitConfigRepository chitConfigRepository;

  CreateChitConfig(this.chitConfigRepository);

  @override
  Future<ChitConfig> call(params) {}
}

class Params extends Equatable {
  final amount;
  final commissionPercentage;
  final membersCount;

  Params({
    @required this.amount,
    @required this.commissionPercentage,
    @required this.membersCount,
  });

  @override
  List<Object> get props => throw UnimplementedError();
}
