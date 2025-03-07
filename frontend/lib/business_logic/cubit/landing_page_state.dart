part of 'landing_page_cubit.dart';

class LandingPageState extends Equatable {
  final int page;
  final List<String> buttonTexts = [
    "Continue",
    "Let's get started",
  ];

  LandingPageState({required this.page});

  @override
  List<Object?> get props => [page, buttonTexts];
}

class LandingPageInitial extends LandingPageState {
  LandingPageInitial() : super(page: 0);
}
