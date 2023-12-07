import 'base_bloc.dart';
import 'base_view.dart';

class DummyBloc extends BaseBloc {
  DummyBloc(BaseView view) : super(view);

  @override
  void onDispose() {}
}
