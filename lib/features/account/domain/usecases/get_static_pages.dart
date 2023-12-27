import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/static_page.dart';
import '../repositories/account_repository.dart';

class GetStaticPage extends UseCase<StaticPageResponse, StaticPageParam> {
  final AccountRepository repository;
  GetStaticPage({required this.repository});
  @override
  Future<Either<Failure, StaticPageResponse>> call(StaticPageParam params) async {
    return await repository.getStaticPage(page: params.page);
  }
}

class StaticPageParam {
  StaticPageParam({required this.page,});
  final int page;
}
