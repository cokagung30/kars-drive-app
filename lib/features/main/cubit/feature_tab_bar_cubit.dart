import 'package:bloc/bloc.dart';

class FeatureTabBarCubit extends Cubit<int> {
  FeatureTabBarCubit() : super(1);

  void onPageChanged(int index) => emit(index);
}
