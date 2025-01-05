import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/batch_entity.dart';

part 'batch_hive_model.g.dart';

//Command to Generate Adapter: dart run build_runner build -d
// Need to run each time changes are made to Model

@HiveType(typeId: HiveTableConstant.batchTableId)

class BatchHiveModel extends Equatable{
  @HiveField(0)
  final String? batchId;

  @HiveField(1)
  final String batchName;

  BatchHiveModel({
    String? batchId,
    required this.batchName,
    }) : batchId = batchId ?? const Uuid().v4();


  //Initial Constructor
  const BatchHiveModel.initial()
  : batchId = '',
  batchName = '';

  //From Entity
factory BatchHiveModel.fromEntity(BatchEntity entity){
  return BatchHiveModel(
    batchId: entity.batchId,
    batchName: entity.batchName,
  );
}

//To Entity
BatchEntity toEntity(){
  return BatchEntity(
    batchId: batchId,
    batchName: batchName,
  );
}

// To Entity List
static List<BatchHiveModel> fromEntityList(List<BatchEntity> entityList){
  return entityList
      .map((entity) => BatchHiveModel.fromEntity(entity))
      .toList();
}

  @override
  List<Object?> get props => [batchId, batchName];


}