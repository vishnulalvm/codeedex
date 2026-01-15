part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const LOGIN = _Paths.LOGIN;
  static const HOME = _Paths.HOME;
  static const PRODUCT_LIST = _Paths.PRODUCT_LIST;
  static const PRODUCT_DETAIL = _Paths.PRODUCT_DETAIL;
}

abstract class _Paths {
  _Paths._();
  static const LOGIN = '/login';
  static const HOME = '/home';
  static const PRODUCT_LIST = '/product-list';
  static const PRODUCT_DETAIL = '/product-detail';
}
