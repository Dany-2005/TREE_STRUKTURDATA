import 'dart:io';

class Node<T> {
  T nodeValue;
  Node? left, right;

  Node(this.nodeValue);
}

class BinaryTree<T> {
  Node<T>? root;

  // Pre-order non-rekursif (NLR)
  void preOrderNonRekursif() {
    if (root == null) return;

    List<Node> stack = [root!];

    while (stack.isNotEmpty) {
      Node current = stack.removeLast();
      stdout.write('${current.nodeValue} ');

      if (current.right != null) stack.add(current.right!);
      if (current.left != null) stack.add(current.left!);
    }
  }

  // In-order non-rekursif (LNR)
  void inOrderNonRekursif() {
    List<Node> stack = [];
    Node? current = root;

    while (current != null || stack.isNotEmpty) {
      while (current != null) {
        stack.add(current);
        current = current.left;
      }

      current = stack.removeLast();
      stdout.write('${current.nodeValue} ');
      current = current.right;
    }
  }

  // Post-order non-rekursif (LRN)
  void postOrderNonRekursif() {
    if (root == null) return;

    List<Node> stack1 = [root!];
    List<Node> stack2 = [];

    while (stack1.isNotEmpty) {
      Node current = stack1.removeLast();
      stack2.add(current);

      if (current.left != null) stack1.add(current.left!);
      if (current.right != null) stack1.add(current.right!);
    }

    while (stack2.isNotEmpty) {
      Node current = stack2.removeLast();
      stdout.write('${current.nodeValue} ');
    }
  }
}

void main() {
  BinaryTree tree = BinaryTree();

  tree.root = Node("A");
  tree.root!.left = Node("B");
  tree.root!.right = Node("C");
  tree.root!.left!.left = Node("D");
  tree.root!.left!.right = Node("E");
  tree.root!.right!.left = Node("F");
  tree.root!.right!.right = Node("G");
  
  print('Pre-order (non-rekursif) [NLR - Node, Left, Right]:');
  tree.preOrderNonRekursif();

  print('\nIn-order (non-rekursif) [LNR - Left, Node, Right]:');
  tree.inOrderNonRekursif();

  print('\nPost-order (non-rekursif) [LRN - Left, Right, Node]:');
  tree.postOrderNonRekursif();
}
