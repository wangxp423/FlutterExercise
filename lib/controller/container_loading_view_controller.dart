import 'package:flutter/material.dart';


enum PageStatus {
  loading,
  empty,
  content,
  networkError,
}

class ContainerLoadingViewController extends ChangeNotifier {
  PageStatus _status = PageStatus.loading;

  PageStatus get status => _status;


  void _switchStatus(PageStatus status) {
    _status = status;
    notifyListeners();
  }

  void showLoading() {
    _switchStatus(PageStatus.loading);
  }

  void showContent(bool show) {
    if (show) _switchStatus(PageStatus.content);
  }
}