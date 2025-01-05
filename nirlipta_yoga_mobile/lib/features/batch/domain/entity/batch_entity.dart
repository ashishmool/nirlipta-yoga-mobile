import 'package:equatable/equatable.dart';

class BatchEntity extends Equatable{
  final String? batchId;
  final String batchName;

  const BatchEntity({
    this.batchId,
    required this.batchName,
});




  @override
  List<Object?> get props => [batchId, batchName];

}
