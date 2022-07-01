import 'package:hydrated_bloc/hydrated_bloc.dart';

class SectionCubit extends HydratedCubit<int> {
  SectionCubit() : super(0);

  void selectItem(int index) => emit(index);

  @override
  int? fromJson(Map<String, dynamic> json) => json['section_index'] as int;

  @override
  Map<String, int> toJson(int state) => {'section_index': state};
}
