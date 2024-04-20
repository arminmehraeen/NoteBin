import 'package:get_it/get_it.dart';
import 'package:notebin/features/post/domain/use_case/post_usecase.dart';
import 'package:notebin/features/post/presentation/bloc/post_bloc.dart';

class PostLocator {

  PostLocator(GetIt locator) {
    PostUseCase postUseCase = PostUseCase(apiService: locator(), storageService: locator()) ;
    locator.registerSingleton(PostBloc(postUseCase: postUseCase,stroageService: locator())) ;
  }

}
