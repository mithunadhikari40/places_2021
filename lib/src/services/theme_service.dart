import 'package:rxdart/rxdart.dart';

class _ThemeService {
  final BehaviorSubject<bool> _themeSubject = BehaviorSubject();

  Function(bool theme) get addTheme => _themeSubject.sink.add;

  bool get getTheme => _themeSubject.hasValue ? _themeSubject.value : false;

  Stream<bool> get themeStream => _themeSubject.stream;

  void dispose() {
    _themeSubject.close();
  }
}

final themeService = _ThemeService();
