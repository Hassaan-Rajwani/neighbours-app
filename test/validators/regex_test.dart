import 'package:flutter_test/flutter_test.dart';
import 'package:neighbour_app/utils/regex_constants.dart';

void main() {
// test for checking firstName validation
  test('firstNameValidator returns null for valid input', () {
    const validInput = 'John';
    final result = ProjectRegex.firstNameValidator(validInput);
    expect(result, isNull);
  });

  test('firstNameValidator returns an error message for empty input', () {
    const emptyInput = '';
    final result = ProjectRegex.firstNameValidator(emptyInput);
    expect(result, 'Please enter first name');
  });

  test('''
firstNameValidator returns error message for input with numbers and symbols''',
      () {
    const inValidInput = r'Jo3hn$';
    final result = ProjectRegex.firstNameValidator(inValidInput);
    expect(result, 'Numbers and Symbols not allowed');
  });

// test for checking lastName validation
  test('lastNameValidator returns null for valid input', () {
    const validInput = 'Alex';
    final result = ProjectRegex.lastNameValidator(validInput);
    expect(result, isNull);
  });

  test('lastNameValidator returns an error message for empty input', () {
    const emptyInput = '';
    final result = ProjectRegex.lastNameValidator(emptyInput);
    expect(result, 'Please enter last name');
  });

  test('''
lastNameValidator returns error message for input with numbers and symbols''',
      () {
    const inValidInput = r'Al3ex$';
    final result = ProjectRegex.lastNameValidator(inValidInput);
    expect(result, 'Numbers and Symbols not allowed');
  });

// test for checking otp validation

  test('otpInputValidator returns null for valid input', () {
    const validInput = '123456';
    final result = ProjectRegex.otpInputValidator(validInput);
    expect(result, isNull);
  });

  test('otpInputValidator returns error message for empty input', () {
    const emptyInput = '';
    final result = ProjectRegex.otpInputValidator(emptyInput);
    expect(result, 'Otp cannot be empty');
  });

  test(
      'otpInputValidator returns error message for input with incorrect length',
      () {
    const invalidInput = '12345';
    final result = ProjectRegex.otpInputValidator(invalidInput);
    expect(result, 'Otp character length should be 6');
  });

  test('''
otpInputValidator returns error message for input with non-numeric characters''',
      () {
    const invalidInput = '12a456';
    final result = ProjectRegex.otpInputValidator(invalidInput);
    expect(result, 'Otp can only contain numbers');
  });

  // test for checking email validation

  test('emailValidator returns null for a valid email', () {
    const validEmail = 'test@example.com';
    final result = ProjectRegex.emailValidator(validEmail);
    expect(result, isNull);
  });

  test('emailValidator returns error message for an empty email', () {
    const emptyEmail = '';
    final result = ProjectRegex.emailValidator(emptyEmail);
    expect(result, 'Please enter your email address');
  });

  test('emailValidator returns error message for an invalid email', () {
    const invalidEmail = 'notanemail';
    final result = ProjectRegex.emailValidator(invalidEmail);
    expect(result, 'Please enter valid email address');
  });

  // test for checking password validation

  test('passwordValidator returns null for a valid password', () {
    const validPassword = 'AbC@1234';
    final result = ProjectRegex.passwordValidator(validPassword);
    expect(result, isNull);
  });

  test('passwordValidator returns error message for an empty password', () {
    const emptyPassword = '';
    final result = ProjectRegex.passwordValidator(emptyPassword);
    expect(result, 'Please enter a password.');
  });

  test('passwordValidator returns error message for a short password', () {
    const shortPassword = 'Abc12@';
    final result = ProjectRegex.passwordValidator(shortPassword);
    expect(result, 'Password should be greater than 8 characters.');
  });

  test('passwordValidator returns error message for a missing uppercase letter',
      () {
    const missingUppercase = 'abcde12@';
    final result = ProjectRegex.passwordValidator(missingUppercase);
    expect(result, 'Password should like (abcDe12@)');
  });

  test(
      'passwordValidator returns error message for a missing special character',
      () {
    const missingSpecialChar = 'AbcDe123';
    final result = ProjectRegex.passwordValidator(missingSpecialChar);
    expect(result, 'Password should like (abcDe12@)');
  });

  // test for checking otp validation
  test('otpValidator returns an empty string for a valid OTP', () {
    const validOTP = '1234';
    final result = ProjectRegex.otpValidator(validOTP);
    expect(result, '');
  });

  test('otpValidator returns error message for an empty OTP', () {
    const emptyOTP = '';
    final result = ProjectRegex.otpValidator(emptyOTP);
    expect(result, 'Please enter code');
  });

  test('otpValidator returns error message for an incorrect length OTP', () {
    const invalidLengthOTP = '12';
    final result = ProjectRegex.otpValidator(invalidLengthOTP);
    expect(result, 'Please enter correct code');
  });

  test('otpValidator returns error message for a non-numeric OTP', () {
    const nonNumericOTP = 'abcd';
    final result = ProjectRegex.otpValidator(nonNumericOTP);
    expect(result, 'Please enter correct code');
  });

  // test for checking bio validation
  test('bioValidator returns an empty string for a non-empty bio', () {
    const nonEmptyBio = 'This is a sample bio.';
    final result = ProjectRegex.bioValidator(nonEmptyBio);
    expect(result, '');
  });

  test('bioValidator returns error message for an empty bio', () {
    const emptyBio = '';
    final result = ProjectRegex.bioValidator(emptyBio);
    expect(result, 'Please enter your bio');
  });

  // test for checking description validation
  test('descriptionValidator returns null for a non-empty description', () {
    const nonEmptyDescription = 'This is a sample description.';
    final result = ProjectRegex.descriptionValidator(nonEmptyDescription);
    expect(result, isNull);
  });

  test('descriptionValidator returns error message for an empty description',
      () {
    const emptyDescription = '';
    final result = ProjectRegex.descriptionValidator(emptyDescription);
    expect(result, 'Please enter your description');
  });

  // test for checking street validation
  test('streetValidator returns null for a non-empty street', () {
    const nonEmptyStreet = '123 Main Street';
    final result = ProjectRegex.streetValidator(nonEmptyStreet);
    expect(result, isNull);
  });

  test('streetValidator returns error message for an empty street', () {
    const emptyStreet = '';
    final result = ProjectRegex.streetValidator(emptyStreet);
    expect(result, 'Please enter your street');
  });

  // test for checking house validation
  test('houseValidator returns null for a non-empty house number', () {
    const nonEmptyHouse = '123';
    final result = ProjectRegex.houseValidator(nonEmptyHouse);
    expect(result, isNull);
  });

  test('houseValidator returns error message for an empty house number', () {
    const emptyHouse = '';
    final result = ProjectRegex.houseValidator(emptyHouse);
    expect(result, 'Please enter your house no');
  });

  // test for checking floor validation
  test('floorValidator returns null for a non-empty floor', () {
    const nonEmptyFloor = '3rd Floor';
    final result = ProjectRegex.floorValidator(nonEmptyFloor);
    expect(result, isNull);
  });

  test('floorValidator returns error message for an empty floor', () {
    const emptyFloor = '';
    final result = ProjectRegex.floorValidator(emptyFloor);
    expect(result, 'Please enter your floor');
  });
}
