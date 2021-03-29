import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ChitConfig extends Equatable {
  final int chitConfigId;
  final String amount;
  final int commissionPercentage;
  final int membersCount;

  ChitConfig({
    this.chitConfigId,
    @required this.amount,
    @required this.commissionPercentage,
    @required this.membersCount,
  });

  @override
  List<Object> get props => [chitConfigId];
}
