import 'package:asuka/asuka.dart';
import 'package:mais_filmes/app/modules/login/domain/repositories/login_interface.dart';
import 'package:mais_filmes/app/shared/overlay/loading_dialog.dart';
import 'package:mais_filmes/app/shared/stores/auth_store.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final ILoginRepository repository;
  final LoadingDialog loading;
  final AuthStore authStore;

  LoginControllerBase(this.repository, this.authStore, this.loading);

  @observable
  String? name;
  @observable
  String? email;

  /// Tries to login and, if it fails, signup
  void enters() async {
    if (name == null || name!.isEmpty) {
      AsukaSnackbar.alert("Insira o nome corretamente").show();
      return;
    }
    else if (email == null || email!.isEmpty || !(email!.contains("@"))) {
      AsukaSnackbar.alert("Insira um email válido").show();
      return;
    }
    loading.show();
    var response = await repository.loginEmail(email: email!, name: name!);
    response.fold(
      (failure) async {
        var response2 = await repository.signup({'email': email, 'name': name});
        response2.fold(
          (failure) {
            loading.hide();
            AsukaSnackbar.alert(failure.message).show();
          },
          (user) async {
            loading.hide(); 
            await authStore.setLoggedUser(user);  
          }
        );
      },
      (user) async {
        loading.hide();
        await authStore.setLoggedUser(user);
      }
    );
  }  
}