import 'package:personhealth/repositorys/login_repository.dart';

Future<void> main() async {

  bool isLogin = await login('0936588854', '123456');
  if (isLogin) {
    print('Login success');
  } else {
    print('Login Fail');
  }

}