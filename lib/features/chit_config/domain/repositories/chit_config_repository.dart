import 'package:vdo_chit_app/features/chit_config/domain/entities/chit_config.dart';

abstract class ChitConfigRepository {
  Future<ChitConfig> createChitConfig({
    int amount,
    int commissionPercentage,
    int membersCount,
  });

  Future<ChitConfig> getChitConfig({int chitConfigId});
  Future<List<ChitConfig>> getAllChitConfig();
  Future<ChitConfig> updateChitConfig({ChitConfig chitConfig});
  Future<bool> deleteChitConfig({int chitConfigId});
}
