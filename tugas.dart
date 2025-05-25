import 'dart:io';
import 'dart:collection';

class Node<T> {
  T nodeValue;
  Node<T>? left, right;

  Node(this.nodeValue);
}

class BinaryTree<T> {
  Node<T>? root;

  // Insert node secara level order (dengan Queue)
  void insertLevelOrder(T value) {
    Node<T> newNode = Node(value);
    if (root == null) {
      root = newNode;
      return;
    }

    Queue<Node<T>> queue = Queue<Node<T>>();
    queue.add(root!);

    while (queue.isNotEmpty) {
      Node<T> temp = queue.removeFirst();

      if (temp.left == null) {
        temp.left = newNode;
        break;
      } else {
        queue.add(temp.left!);
      }

      if (temp.right == null) {
        temp.right = newNode;
        break;
      } else {
        queue.add(temp.right!);
      }
    }
  }

  // Linear search dan insert ke target node
  bool insertAtTarget(T target, T newValue) {
    if (root == null) return false;

    Queue<Node<T>> queue = Queue<Node<T>>();
    queue.add(root!);

    while (queue.isNotEmpty) {
      Node<T> current = queue.removeFirst();
      if (current.nodeValue == target) {
        if (current.left == null) {
          current.left = Node(newValue);
        } else if (current.right == null) {
          current.right = Node(newValue);
        } else {
          return false; // target sudah punya 2 anak
        }
        return true;
      }
      if (current.left != null) queue.add(current.left!);
      if (current.right != null) queue.add(current.right!);
    }
    return false; // target tidak ditemukan
  }

  // Pre-order non-rekursif
  void preOrderNonRecursive() {
    if (root == null) return;

    List<Node<T>> stack = [root!];
    while (stack.isNotEmpty) {
      Node<T> node = stack.removeLast();
      stdout.write('${node.nodeValue} ');

      if (node.right != null) stack.add(node.right!);
      if (node.left != null) stack.add(node.left!);
    }
  }

  // In-order non-rekursif
  void inOrderNonRecursive() {
    List<Node<T>> stack = [];
    Node<T>? current = root;

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

  // Post-order non-rekursif
  void postOrderNonRecursive() {
    if (root == null) return;

    List<Node<T>> stack1 = [root!];
    List<Node<T>> stack2 = [];

    while (stack1.isNotEmpty) {
      Node<T> node = stack1.removeLast();
      stack2.add(node);

      if (node.left != null) stack1.add(node.left!);
      if (node.right != null) stack1.add(node.right!);
    }

    while (stack2.isNotEmpty) {
      stdout.write('${stack2.removeLast().nodeValue} ');
    }
  }
}

void main() {
  BinaryTree<dynamic> tree = BinaryTree<dynamic>();

  // Tambah data secara level order
  tree.insertLevelOrder(1);
  tree.insertLevelOrder(2);
  tree.insertLevelOrder(3);
  tree.insertLevelOrder(4);
  tree.insertLevelOrder(5);

  // Tambah node pada target tertentu
  tree.insertAtTarget("B", "F");
  tree.insertAtTarget("B", "G");

  print("Pre-order non-rekursif (NLR):");
  tree.preOrderNonRecursive();

  print("\nIn-order non-rekursi (LNR):");
  tree.inOrderNonRecursive();

  print("\nPost-order non-rekursif (LRN):");
  tree.postOrderNonRecursive();
}
