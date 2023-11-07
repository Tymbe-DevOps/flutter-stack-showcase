part of './models.dart';

@immutable
class ServiceState {
  final Result<DeviceDataModel> detailStatus;
  final Result<String> insertStatus;

  const ServiceState({
    required this.detailStatus,
    required this.insertStatus,
  });

  factory ServiceState.initial() => ServiceState(
        detailStatus: Result.loading(),
        insertStatus: Result.loading(),
      );

  ServiceState copyWith({
    Result<DeviceDataModel>? detailStatus,
    Result<String>? insertStatus,
  }) {
    return ServiceState(
      detailStatus: detailStatus ?? this.detailStatus,
      insertStatus: insertStatus ?? this.insertStatus,
    );
  }

  @override
  String toString() =>
      'ServiceState(detailStatus: $detailStatus, insertStatus: $insertStatus)';
}
