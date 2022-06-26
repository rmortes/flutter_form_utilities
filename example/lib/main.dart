import 'package:flutter/material.dart';
import 'package:form_utilities/validation.dart';
import 'package:form_utilities/validators/num_validator.dart';
import 'package:form_utilities/validators/str_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form example"),
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Username",
              ),
              validator: validate([
                ValStr().isNotEmpty(error: "The username can't be empty"),
                ValStr()
                    .startsWith("@", error: 'The username must start with "@"'),
                ValStr().lengthBiggerThan(4,
                    error: "The username must be at least 3 characters long"),
                ValStr().lengthSmallerThan(9,
                    error: "The username must be at most 8 characters long"),
                ValStr().notContainsSurrogatePair(
                    error: "Username must not contain emojis"),
              ]),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Age",
              ),
              validator: validate([
                ValInt().isValid(error: "Your age must be a whole number"),
                ValInt().isPositive(error: "Your age must be positive"),
                ValInt()
                    .lt(100, error: "Everybody knows there's no one that old"),
              ]),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Email",
              ),
              validator: validate([
                ValStr().isNotEmpty(error: "The email can't be empty"),
                ValStr().isEmail(error: "The email is not valid"),
                ValStr().lengthBiggerThan(8,
                    error:
                        "You don't have an email that short, don't try to fool me")
              ]),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            // Custom hybrid validator
            TextFormField(
              decoration: const InputDecoration(
                labelText: "The answer to life, the universe, and everything",
              ),
              validator: (val) {
                final validator = validate([
                  ValStr().isNotEmpty(
                      error: "There must be an answer, I just know!"),
                  ValInt().isValid(
                      error: "The answer must be a whole number, surely!"),
                  (str) => int.parse(str) >= 0
                      ? null
                      : "You think the answer is negative? Nay mate",
                  ValInt().neq(0,
                      error:
                          "The answer must not be zero, or else I have an appointment to make with my therapist"),
                  ValInt().lt(45,
                      error: "The answer is not THAT big, that'd be stupid!"),
                ]);
                final validated = validator(val);
                if (validated != null) {
                  return validated;
                }
                if (int.parse(val!) == 42) {
                  return "Ah, so you've read The Hitchhiker's Guide to the Galaxy, right?";
                }
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ],
        ),
      ),
    );
  }
}
