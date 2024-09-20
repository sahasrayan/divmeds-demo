import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_button_event.dart';
part 'post_button_state.dart';

class PostButtonBloc extends Bloc<PostButtonEvent, PostButtonState> {
  PostButtonBloc() : super(PostButtonInitial()) {
    on<PostButtonEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
