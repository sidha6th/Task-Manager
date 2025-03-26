import 'package:task_manager/core/global/state/global_bloc_state.dart';

base class PaginatedGlobalBlocState<T> extends GlobalBlocState<List<T>> {
  const PaginatedGlobalBlocState({
    required this.isNextPageLoading,
    required this.hasGotAllData,
    required super.loading,
    required super.success,
    required this.page,
    super.data,
  });

  const PaginatedGlobalBlocState.error(this.page)
      : isNextPageLoading = false,
        hasGotAllData = false,
        super.error();

  const PaginatedGlobalBlocState.success(super.result,
      {required this.page, this.hasGotAllData = false})
      : isNextPageLoading = false,
        super.success();

  const PaginatedGlobalBlocState.loading(this.page)
      : isNextPageLoading = false,
        hasGotAllData = false,
        super.loading();

  const PaginatedGlobalBlocState.nextPageLoading(this.page, List<T>? data)
      : isNextPageLoading = true,
        hasGotAllData = false,
        super(loading: false, data: data, success: true);

  final int page;
  final bool hasGotAllData;
  final bool isNextPageLoading;

  bool get initialPage => page < 1;

  @override
  bool get hasData => data != null && data!.isNotEmpty;

  @override
  PaginatedGlobalBlocState<T> toSuccess({
    List<T>? task,
    bool hasGotAllData = false,
  }) {
    return copyWith(
      success: true,
      data: task,
      loading: false,
      isNextPageLoading: false,
      hasGotAllData: hasGotAllData,
      page: hasGotAllData ? page : page + 1,
    );
  }

  @override
  PaginatedGlobalBlocState<T> toLoading({int page = 0}) {
    return copyWith(
      loading: true,
      hasGotAllData: false,
      isNextPageLoading: false,
      page: page,
    );
  }

  PaginatedGlobalBlocState<T> toNextPageLoading() {
    return copyWith(
      loading: false,
      hasGotAllData: false,
      isNextPageLoading: true,
    );
  }

  @override
  PaginatedGlobalBlocState<T> toError() {
    return copyWith(
      success: false,
      loading: false,
      isNextPageLoading: false,
    );
  }

  @override
  PaginatedGlobalBlocState<T> copyWith({
    bool? isNextPageLoading,
    bool? hasGotAllData,
    bool? loading,
    bool? success,
    List<T>? data,
    int? page,
  }) {
    return PaginatedGlobalBlocState<T>(
      isNextPageLoading: isNextPageLoading ?? this.isNextPageLoading,
      hasGotAllData: hasGotAllData ?? this.hasGotAllData,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      page: page ?? this.page,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(covariant PaginatedGlobalBlocState<T> other) {
    if (identical(this, other)) return true;

    return other.data == data &&
        other.page == page &&
        other.loading == loading &&
        other.success == success &&
        other.hasGotAllData == hasGotAllData &&
        other.isNextPageLoading == isNextPageLoading;
  }

  @override
  int get hashCode =>
      page.hashCode ^
      hasGotAllData.hashCode ^
      isNextPageLoading.hashCode ^
      loading.hashCode ^
      success.hashCode ^
      data.hashCode;
}
