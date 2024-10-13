String checkBalancedBrackets(String input) {
  List<String> stack = [];

  Map<String, String> matchingBrackets = {
    ')': '(',
    ']': '[',
    '}': '{',
  };

  for (var char in input.split('')) {
    if (matchingBrackets.values.contains(char)) {
      stack.add(char);
    } else if (matchingBrackets.keys.contains(char)) {
      if (stack.isEmpty || stack.last != matchingBrackets[char]) {
        return "Not balanced";
      }
      stack.removeLast();
    }
  }

  return stack.isEmpty ? "Balanced" : "Not balanced";
}

void main() {
  print(checkBalancedBrackets("{what is (42)}?"));
  print(checkBalancedBrackets("[text}"));
  print(checkBalancedBrackets("{[[(a)b]c]d}"));
}
