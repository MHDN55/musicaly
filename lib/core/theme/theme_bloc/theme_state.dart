// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'theme_bloc.dart';

enum ThemeStatus { initial, loaded, loading }

class ThemeState extends Equatable {
  final ThemeStatus status;
  final ThemeData themeData;
  const ThemeState({
    required this.status,
    required this.themeData,
  });

  ThemeState copyWith({
    ThemeStatus? status,
    ThemeData? themeData,
  }) {
    return ThemeState(
      status: status ?? this.status,
      themeData: themeData ?? this.themeData,
    );
  }

  @override
  List<Object> get props => [status, themeData];
}

// class ThemeInitial extends ThemeState {}

// class LoadedThemeState extends ThemeState {
//   final ThemeData themeData;
//   const LoadedThemeState({
//     required this.themeData,
//   });

//   @override
//   List<Object> get props => [themeData];
// }
