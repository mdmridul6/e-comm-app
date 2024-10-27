import 'dart:io';
import 'dart:collection';

// Function to return precedence of operators
int precedence(String op) {
  if (op == '+' || op == '-') return 1;
  if (op == '*' || op == '/') return 2;
  return 0;
}

// Function to check if the character is an operator
bool isOperator(String c) {
  return (c == '+' || c == '-' || c == '*' || c == '/');
}

// Function to convert infix to postfix expression
String infixToPostfix(String infix) {
  var st = Queue<String>();
  String postfix = '';

  for (int i = 0; i < infix.length; i++) {
    String ch = infix[i];

    // If the character is an operand, add it to the output
    if (RegExp(r'[0-9]').hasMatch(ch)) {
      postfix += ch;
    }
    // If the character is '(', push it to the stack
    else if (ch == '(') {
      st.addFirst(ch);
    }
    // If the character is ')', pop and output from the stack
    // until an '(' is encountered
    else if (ch == ')') {
      while (st.isNotEmpty && st.first != '(') {
        postfix += st.removeFirst();
      }
      st.removeFirst(); // Remove the '(' from the stack
    }
    // If the character is an operator
    else if (isOperator(ch)) {
      while (st.isNotEmpty && precedence(st.first) >= precedence(ch)) {
        postfix += st.removeFirst();
      }
      st.addFirst(ch);
    }
  }

  // Pop all the operators from the stack
  while (st.isNotEmpty) {
    postfix += st.removeFirst();
  }

  return postfix;
}

// Function to convert infix to prefix expression
String infixToPrefix(String infix) {
  // Reverse the infix expression
  String reversedInfix = infix.split('').reversed.join('');

  // Replace '(' with ')' and vice versa
  String modifiedInfix = '';
  for (int i = 0; i < reversedInfix.length; i++) {
    if (reversedInfix[i] == '(') {
      modifiedInfix += ')';
    } else if (reversedInfix[i] == ')') {
      modifiedInfix += '(';
    } else {
      modifiedInfix += reversedInfix[i];
    }
  }

  // Convert the modified infix to postfix
  String postfix = infixToPostfix(modifiedInfix);

  // Reverse the postfix to get prefix
  String prefix = postfix.split('').reversed.join('');

  return prefix;
}

void main() {
  String? infix = stdin.readLineSync(); // Read input expression

  if (infix != null) {
    String prefix = infixToPrefix(infix);
    print(prefix); // Output the result directly without extra text
  }
}
