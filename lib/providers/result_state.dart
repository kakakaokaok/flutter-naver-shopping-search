// part of 'result_provider.dart';

// enum ResultStatus {
//   initial,
//   loading,
//   loaded,
//   error,
// }

// class ResultState extends Equatable {
//   final ResultStatus status;
//   final Store store;
//   final CustomError error;
//   ResultState({
//     required this.status,
//     required this.store,
//     required this.error,
//   });

//   factory ResultState.initial() {
//     return ResultState(
//       status: ResultStatus.initial,
//       store: Store.initial(),
//       error: CustomError(),
//     );
//   }

//   @override
//   String toString() =>
//       'ResultState(status: $status, store: $store, error: $error)';

//   @override
//   List<Object> get props => [status, store, error];

//   ResultState copyWith({
//     ResultStatus? status,
//     Store? store,
//     CustomError? error,
//   }) {
//     return ResultState(
//       status: status ?? this.status,
//       store: store ?? this.store,
//       error: error ?? this.error,
//     );
//   }
// }
