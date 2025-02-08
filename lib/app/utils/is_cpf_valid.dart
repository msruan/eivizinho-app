bool isValidCPF(String cpf) {
  List<int> cpfList = cpf.split('').map((e) => int.parse(e)).toList();

  int firstDigit = 0;
  for (int i = 0; i < 9; i++) {
    firstDigit += cpfList[i] * (10 - i);
  }
  firstDigit = (firstDigit * 10) % 11;
  if (firstDigit == 10 || firstDigit == 11) firstDigit = 0;
  if (firstDigit != cpfList[9]) return false;

  int secondDigit = 0;
  for (int i = 0; i < 10; i++) {
    secondDigit += cpfList[i] * (11 - i);
  }
  secondDigit = (secondDigit * 10) % 11;
  if (secondDigit == 10 || secondDigit == 11) secondDigit = 0;
  if (secondDigit != cpfList[10]) return false;

  return true;
}
