import 'package:flix_id/data/repositories/authentication.dart';
import 'package:flix_id/data/repositories/user_repository.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/user.dart';
import 'package:flix_id/domain/usecases/register/register_param.dart';
import 'package:flix_id/domain/usecases/usecase.dart';

class Register implements UseCase<Result<User>, RegisterParam> {
  final Authentication _authentication;
  final UserRepository _repository;

  Register({
    required Authentication authentication,
    required UserRepository repository,
  })  : _authentication = authentication,
        _repository = repository;
  @override
  Future<Result<User>> call(RegisterParam params) async {
    var uidResult = await _authentication.register(
      email: params.email,
      password: params.password,
    );
    if (uidResult.isSuccess) {
      var userResult = await _repository.createUser(
        uid: uidResult.resultValue!,
        email: params.email,
        name: params.name,
        photoUrl: params.photoUrl,
      );
      if (userResult.isSuccess) {
        return Result.success(userResult.resultValue!);
      } else {
        return Result.failed(userResult.errorMessagge!);
      }
    } else {
      return Result.failed(uidResult.errorMessagge!);
    }
  }
}
