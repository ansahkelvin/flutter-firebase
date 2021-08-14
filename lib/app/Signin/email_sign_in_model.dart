enum EmailFormType { SignIn, Register }

class EmailSignInModel {
  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.formType = EmailFormType.SignIn,
    this.isSubmitted = false,
  });
  final String email;
  final String password;
  final bool isLoading;
  final EmailFormType formType;
  final bool isSubmitted;

  EmailSignInModel copyWith({
    String email,
    String password,
    EmailFormType formType,
    bool isLoading,
    bool isSubmitted,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }
}
