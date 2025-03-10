import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/models/user.dart';
import 'package:frontend/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(AuthState()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
  }

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    if (event.email.isEmpty || event.password.isEmpty) return;

    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final user = await _authRepository.login(event.email, event.password);
      emit(state.copyWith(status: AuthStatus.success, user: user));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, error: e.toString()));
    }
  }

  Future<void> _register(RegisterEvent event, Emitter<AuthState> emit) async {
    if (event.email.isEmpty || event.password.isEmpty) return;

    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final user = await _authRepository.register(event.email, event.password);
      emit(state.copyWith(status: AuthStatus.success, user: user));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, error: e.toString()));
    }
  }
}
