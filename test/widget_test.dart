
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tests/data/datasource/local_source.dart';
import 'package:tests/data/models/board_model.dart';
import 'package:tests/data/repositoryimpl/repositotyImpl.dart';
import 'package:tests/domain/entities/board.dart';
import 'package:tests/domain/usecases/usecase_local.dart';
import 'package:tests/presentation/pages/onboard.dart';

import 'queue.dart';

void main() {
  SharedPreferences.setMockInitialValues({});

  test('Изображение и текста из очереди извлекается правильно (в порядке добавления в очередь)', () async {
    LocalSourceImpl localSourceImpl = LocalSourceImpl();
    RepositoryImpl repositoryImpl = RepositoryImpl(Source: localSourceImpl);
    UseCaseLocalSource useCaseLocalSource = UseCaseLocalSource(repo: repositoryImpl);

    queue.add(BoardModel(title: 'Quick Delivery At Your Doorstep',
          label: 'Enjoy quick pick-up and delivery to your destination',
          picture: 'first_board',
          width: 346,
          height: 346,).toJson(),);
    queue.add( BoardModel( title: 'Flexible Payment',
          label:
              'Different modes of payment either before and after delivery without stress',
          picture: 'second_board',
          width: 424,
          height: 316,).toJson(),);

    useCaseLocalSource.loadData(queue);
    Board? board =  await useCaseLocalSource.unloadData();
      
    expect(board, BoardModel.fromJson(queue.first));

  });

    test('Корректное извлечение элементов из очереди (количество элементов в очереди уменьшается на единицу))', () async {
    LocalSourceImpl localSourceImpl = LocalSourceImpl();
    RepositoryImpl repositoryImpl = RepositoryImpl(Source: localSourceImpl);
    UseCaseLocalSource useCaseLocalSource = UseCaseLocalSource(repo: repositoryImpl);

    queue.clear();
    queue.add(BoardModel(title: 'Quick Delivery At Your Doorstep',
          label: 'Enjoy quick pick-up and delivery to your destination',
          picture: 'first_board',
          width: 346,
          height: 346,).toJson(),
       ); 
    queue.add(BoardModel( title: 'Flexible Payment',
          label:
              'Different modes of payment either before and after delivery without stress',
          picture: 'second_board',
          width: 424,
          height: 316,).toJson(),);
       
    useCaseLocalSource.loadData(queue);
    await useCaseLocalSource.next();
    expect(useCaseLocalSource.isLast,true);
    useCaseLocalSource.loadData([]);

  });


  testWidgets('В случае, когда в очереди несколько картинок, устанавливается правильная надпись на кнопке', (widgetTester) async{
     LocalSourceImpl localSourceImpl = LocalSourceImpl();
    RepositoryImpl repositoryImpl = RepositoryImpl(Source: localSourceImpl);
    UseCaseLocalSource useCaseLocalSource = UseCaseLocalSource(repo: repositoryImpl);

    queue.clear();
     queue.add(BoardModel(title: 'Quick Delivery At Your Doorstep',
          label: 'Enjoy quick pick-up and delivery to your destination',
          picture: 'first_board',
          width: 346,
          height: 346,).toJson(),
       ); 
    queue.add(BoardModel( title: 'Flexible Payment',
          label:
              'Different modes of payment either before and after delivery without stress',
          picture: 'second_board',
          width: 424,
          height: 316,).toJson(),);
    useCaseLocalSource.loadData(queue);

    await widgetTester.pumpWidget(ScreenUtilInit(
      designSize: const Size(390, 844),
      child: MaterialApp(home: MultiProvider(providers: [Provider.value(value: useCaseLocalSource)],
    child: const OnBoard()))));
    await widgetTester.pumpAndSettle();
    expect(find.text('Next'), findsOneWidget);
  });

   testWidgets('−Случай, когда очередь пустая, надпись на кнопке должна измениться на "Sing Up".', (widgetTester) async{
     LocalSourceImpl localSourceImpl = LocalSourceImpl();
    RepositoryImpl repositoryImpl = RepositoryImpl(Source: localSourceImpl);
    UseCaseLocalSource useCaseLocalSource = UseCaseLocalSource(repo: repositoryImpl);

    queue.clear();
     queue.add(BoardModel(title: 'Quick Delivery At Your Doorstep',
          label: 'Enjoy quick pick-up and delivery to your destination',
          picture: 'first_board',
          width: 346,
          height: 346,).toJson(),
       );

    useCaseLocalSource.loadData(queue);

    await widgetTester.pumpWidget(ScreenUtilInit(child: MaterialApp(home: MultiProvider(providers: [Provider.value(value: useCaseLocalSource)],

    child: const OnBoard()))));

    await widgetTester.pumpAndSettle();

    expect(find.text('Sign Up'), findsOneWidget);
  });


     testWidgets('Если очередь пустая и пользователь нажал на кнопку “Sing in”, происходит открытие пустого экрана «Holder» приложения. Если очередь не пустая – переход отсутствует.', (widgetTester) async{
     LocalSourceImpl localSourceImpl = LocalSourceImpl();
    RepositoryImpl repositoryImpl = RepositoryImpl(Source: localSourceImpl);
    UseCaseLocalSource useCaseLocalSource = UseCaseLocalSource(repo: repositoryImpl);

    queue.clear();
    useCaseLocalSource.loadData(queue);

    await widgetTester.pumpWidget(ScreenUtilInit(child: MaterialApp(home: MultiProvider(providers: [Provider.value(value: useCaseLocalSource)],
    child: const OnBoard()))));
    await widgetTester.pumpAndSettle();
    expect(find.byKey(const ValueKey('HolderKey')), findsOneWidget);
  });

}
