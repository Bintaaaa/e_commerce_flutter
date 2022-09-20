part of 'banner_cubit.dart';

class BannerState extends Equatable {
  final ViewData<List<BannerDataEntity>> bannerState;
  const BannerState({
    required this.bannerState,
  });

  BannerState copyWith({ViewData<List<BannerDataEntity>>? bannerState}) {
    return BannerState(
      bannerState: bannerState ?? this.bannerState,
    );
  }

  @override
  List<Object?> get props => [bannerState];
}
