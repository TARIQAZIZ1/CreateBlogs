import 'package:flutter_bloc/flutter_bloc.dart';
class PageIndexCubit extends Cubit<bool> {
  PageIndexCubit(bool initialState) : super(true);
  setBool({required isHidden}){
    print("${isHidden}");
     emit(isHidden);
  }
}