import 'package:vdo_chit_app/features/chit_config/domain/entities/chit_config.dart';
import 'package:vdo_chit_app/features/chit_config/domain/repositories/chit_config_repository.dart';

class ChitConfigRepositoryImpl implements ChitConfigRepository {
  @override
  Future<ChitConfig> createChitConfig({
    int amount,
    int commissionPercentage,
    int membersCount,
  }) {
    // TODO: implement createChitConfig
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteChitConfig({int chitConfigId}) {
    // TODO: implement deleteChitConfig
    throw UnimplementedError();
  }

  @override
  Future<List<ChitConfig>> getAllChitConfig() {
    // TODO: implement getAllChitConfig
    throw UnimplementedError();
  }

  @override
  Future<ChitConfig> getChitConfig({int chitConfigId}) {
    // TODO: implement getChitConfig
    throw UnimplementedError();
  }

  @override
  Future<ChitConfig> updateChitConfig({ChitConfig chitConfig}) {
    // TODO: implement updateChitConfig
    throw UnimplementedError();
  }
}
