part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

final class CategoryLoadedEvent extends CategoryEvent {
  final AllSettings allSettings;
  // final bool? isFood;
  // final bool? isCat;

  const CategoryLoadedEvent({required this.allSettings});
}
