class ResponseListenerPage {
  SnackBarType snackBarType;
  int codeMessage;
  int idWidget;

  ResponseListenerPage(
      {this.snackBarType = SnackBarType.error, this.codeMessage = 0, this.idWidget = 0});
}

enum SnackBarType { error, success }
