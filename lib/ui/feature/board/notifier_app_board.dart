import 'package:corp_devices/io/enums/app_type.dart';
import 'package:corp_devices/io/repository/login_repository.dart';
import 'package:corp_devices/io/repository/repository_providers.dart';
import 'package:corp_devices/ui/feature/board/state_app_board.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [AppBoardNotifier] provider
final appBoardProvider = StateNotifierProvider<DashboardNotifier, DashboardState>(
  (ref) {
    final LoginRepository loginRepository = ref.read(loginRepoProvider);
    return DashboardNotifier(loginRepository).._checkAppStart();
  },
);

/// Notifier that holds info about about [AppBoardState]
class DashboardNotifier extends StateNotifier<DashboardState> {
  final LoginRepository _loginRepository;

  DashboardNotifier(LoginRepository loginRepository)
      : _loginRepository = loginRepository,
        super(DashboardState.initial());

  bool get _isSigned => _loginRepository.isSigned();
  bool get _hasChosenAppType => _loginRepository.getAppType() != null;

  Future<void> selectType(AppType type) async {
    await _loginRepository.saveType(type);
    state = DashboardState.selectedType(type);
  }

  Future<void> _checkAppStart() async {
    final session = _loginRepository.getSession();
    if (_isSigned && _hasChosenAppType) {
      // must awaited for small amount of time, otherwise listen function is not called
      await Future.delayed(const Duration(milliseconds: 10));
      state = DashboardState.skipScanner(session.type!);
    }
  }
}
