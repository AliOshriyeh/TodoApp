import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task01/domain/controller/auth_controller.dart';
import 'auth_controller_test.mocks.dart';

@GenerateMocks([SupabaseClient, AuthResponse, User])
void main() {
  late MockSupabaseClient mockSupabase;
  late AuthController authController;

  setUp(() async {
    // Mock Supabase initialization
    mockSupabase = MockSupabaseClient();

    authController = AuthController();
    authController.setSupabaseClient(mockSupabase);
  });

  tearDown(() {
    // Reset any mocks if needed
    reset(mockSupabase);
  });

  test('signUp calls supabase.auth.signUp', () async {
    final mockResponse = MockAuthResponse();
    final mockUser = MockUser();

    when(mockResponse.user).thenReturn(mockUser);

    await authController.signUp('test@example.com', 'password123');
  });

  test('validateEmail returns correct validations', () {
    expect(authController.validateEmail(null), 'Please enter your email');
    expect(authController.validateEmail('invalid'), 'Please enter a valid email');
    expect(authController.validateEmail('valid@example.com'), null);
  });
}
