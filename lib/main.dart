import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'data/datasource/local_source.dart';
import 'data/repositoryimpl/repositotyImpl.dart';
import 'domain/repository/repository.dart';
import 'domain/usecases/usecase_local.dart';
import 'presentation/pages/onboard.dart';

void main() {
  LocalSource localSource = LocalSourceImpl();
  Repository repository = RepositoryImpl(Source: localSource);
  UseCaseLocalSource useCase = UseCaseLocalSource(repo: repository);
  runApp(ScreenUtilInit(
    designSize: const Size(390, 844),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(providers: [
        Provider.value(value: useCase)
      ],
      child: OnBoard()),
    ),
  ));
}


