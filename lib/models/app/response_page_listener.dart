class ResponseListenerPage {
  SnackBarType snackBarType;
  int codeMessage;
  int idWidget;
  dynamic action;
  dynamic actionValue;

  ResponseListenerPage(
      {this.snackBarType = SnackBarType.error,
      this.codeMessage = 0,
      this.idWidget = 0,
      this.action,
      this.actionValue});
}

enum SnackBarType { error, success, ignore }
