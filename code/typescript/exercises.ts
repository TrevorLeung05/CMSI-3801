import * as fs from 'fs';
import * as readline from 'readline';

//firstThenApply Function: Finds the first element in an array satisfying a predicate, then applies a transform function to it
export function firstThenApply<T, U>(
  items: T[],
  predicate: (item: T) => boolean,
  transform: (item: T) => U,
): U | undefined {
  for (const item of items) {
    if (predicate(item)) {
      return transform(item);
    }
  }
  return undefined;
}

//Infinite Sequence of Powers: A generator that yields an infinite sequence of powers for a given base
export function* powersGenerator(base: bigint): Generator<bigint, void, unknown> {
  let current = 1n;
  while (true) {
    yield current;
    current *= base;
  }
}

//Count Valid Lines in a File: Asynchronously counts the number of "meaningful" lines in a text file
export async function meaningfulLineCount(filePath: string): Promise<number> {
  let count = 0;
  const fileStream = fs.createReadStream(filePath);
  const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity,
  });

  for await (const line of rl) {
    const trimmedLine = line.trim();
    if (trimmedLine && !trimmedLine.startsWith('#')) {
      count++;
    }
  }
  return count;
}

//3D Shape Data Types: A rectangular box with width, length, and depth
export interface Box {
  readonly kind: 'Box';
  readonly width: number;
  readonly length: number;
  readonly depth: number;
}

//A sphere with a radius
export interface Sphere {
  readonly kind: 'Sphere';
  readonly radius: number;
}

//A union type representing either a Box or a Sphere.
export type Shape = Box | Sphere;

/**
 * Calculates the volume of a given Shape.
 * @param shape The shape (Box or Sphere).
 * @returns The volume of the shape.
 */
export function volume(shape: Shape): number {
  switch (shape.kind) {
    case 'Box':
      return shape.width * shape.length * shape.depth;
    case 'Sphere':
      return (4 / 3) * Math.PI * Math.pow(shape.radius, 3);
  }
}

/**
 * Calculates the surface area of a given Shape.
 * @param shape The shape (Box or Sphere).
 * @returns The surface area of the shape.
 */
export function surfaceArea(shape: Shape): number {
  switch (shape.kind) {
    case 'Box':
      return 2 * (shape.width * shape.length + shape.width * shape.depth + shape.length * shape.depth);
    case 'Sphere':
      return 4 * Math.PI * Math.pow(shape.radius, 2);
  }
}

//Persistent Binary Search Tree: An abstract base class for a generic, persistent Binary Search Tree.
export abstract class BinarySearchTree<T> {
  abstract size(): number;
  abstract contains(value: T): boolean;
  abstract insert(value: T): BinarySearchTree<T>;
  abstract inorder(): Generator<T, void, unknown>;
  abstract toString(): string;
}

/**
 * Represents an empty Binary Search Tree (the "leaf" nodes).
 * This class is exported and serves as the entry point for creating a new tree.
 */
export class Empty<T> extends BinarySearchTree<T> {
  size(): number {
    return 0;
  }

  contains(_value: T): boolean {
    return false;
  }

  insert(value: T): BinarySearchTree<T> {
    // Inserting into an empty tree creates a new Node.
    return new Node(value, new Empty<T>(), new Empty<T>());
  }

  *inorder(): Generator<T, void, unknown> {
    // An empty tree yields nothing.
    return;
  }

  toString(): string {
    return '()';
  }
}

/**
 * Represents a non-empty node in the Binary Search Tree.
 * This class is NOT exported to enforce the security requirement.
 * Users can only create Nodes via the `insert` method, which preserves the BST property.
 */
class Node<T> extends BinarySearchTree<T> {
  private readonly nodeSize: number;

  constructor(
    private readonly value: T,
    private readonly left: BinarySearchTree<T>,
    private readonly right: BinarySearchTree<T>,
  ) {
    super();
    this.nodeSize = 1 + left.size() + right.size();
  }

  size(): number {
    return this.nodeSize;
  }

  contains(value: T): boolean {
    if (value < this.value) {
      return this.left.contains(value);
    } else if (value > this.value) {
      return this.right.contains(value);
    }
    return true; // value === this.value
  }

  insert(value: T): BinarySearchTree<T> {
    if (value < this.value) {
      // Create a new Node with an updated left subtree
      return new Node(this.value, this.left.insert(value), this.right);
    } else if (value > this.value) {
      // Create a new Node with an updated right subtree
      return new Node(this.value, this.left, this.right.insert(value));
    }
    // Value is already in the tree, return the same node (immutability)
    return this;
  }

  *inorder(): Generator<T, void, unknown> {
    yield* this.left.inorder();
    yield this.value;
    yield* this.right.inorder();
  }

  toString(): string {
    // An empty child does not contribute to the string representation inside a node.
    const leftStr = this.left instanceof Empty ? '' : this.left.toString();
    const rightStr = this.right instanceof Empty ? '' : this.right.toString();
    return `(${leftStr}${this.value}${rightStr})`;
  }
}