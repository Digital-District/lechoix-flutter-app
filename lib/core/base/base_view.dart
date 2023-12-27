abstract class BaseView {
  void showProgress();

  void hideProgress();

  void showSuccessMsg(String msg);

  void showErrorMsg(String msg);

  String localize(String key);

  void handleUnauthenticatedUser();
}
