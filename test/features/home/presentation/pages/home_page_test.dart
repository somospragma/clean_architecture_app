import 'package:clean_architecture_app/core/env/config_env.dart';
import 'package:clean_architecture_app/core/network/dio_network.dart';
import 'package:clean_architecture_app/core/router/router.dart';
import 'package:clean_architecture_app/features/auth/domain/usecases/auth_usecase.dart';
import 'package:clean_architecture_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthUsecase extends Mock implements AuthUsecase {}

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  late MockAuthUsecase mockAuthUsecase;
  late MockGoRouter mockGoRouter;

  setUpAll(() async {
    await dotenv.load(fileName: ".env");
    await ConfigENV.intance.loadEnvironment();
    DioNetwork.initDio();
  });

  setUp(() {
    mockAuthUsecase = MockAuthUsecase();
    mockGoRouter = MockGoRouter();
  });

  testWidgets('Debe navegar a la pantalla de registro',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authUsecaseProvider.overrideWithValue(mockAuthUsecase),
          appRouterProvider.overrideWithValue(mockGoRouter),
        ],
        child: const ScreenUtilInit(
            designSize: Size(375, 812),
            child: MaterialApp(home: HomePage())),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
  });
}
