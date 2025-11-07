import java.io.*;
import java.util.*;
import java.util.function.Predicate;
import java.util.stream.Stream;

// =========================================================
// Exercises class
// =========================================================
public final class Exercises {

    private Exercises() {}

    // 1) firstThenLowerCase
    public static Optional<String> firstThenLowerCase(List<String> xs, Predicate<String> predicate) {
        return xs.stream()
                 .filter(predicate)
                 .findFirst()
                 .map(s -> s.toLowerCase(Locale.ROOT));
    }

    // 2) say(...).and(...).phrase
    public static Say say() {
        return new Say("");
    }

    public static Say say(String word) {
        return new Say(word == null ? "" : word);
    }

    public static final class Say {
        private final String phrase;
        private Say(String phrase) { this.phrase = phrase; }

        public Say and(String word) {
            if (word == null) word = "";
            if (phrase.isEmpty()) return new Say(word);
            return new Say(phrase + " " + word);
        }

        public String phrase() { return phrase; }

        @Override public String toString() { return phrase; }
    }

    // 3) meaningfulLineCount
    public static long meaningfulLineCount(String filename) throws IOException {
        try (BufferedReader br = new BufferedReader(new FileReader(filename))) {
            return br.lines()
                     .map(String::stripLeading)
                     .filter(line -> !line.isEmpty())
                     .filter(line -> line.charAt(0) != '#')
                     .count();
        }
    }
}

// =========================================================
// Quaternion record
// =========================================================
record Quaternion(double a, double b, double c, double d) {

    public static final Quaternion ZERO = new Quaternion(0, 0, 0, 0);
    public static final Quaternion I    = new Quaternion(0, 1, 0, 0);
    public static final Quaternion J    = new Quaternion(0, 0, 1, 0);
    public static final Quaternion K    = new Quaternion(0, 0, 0, 1);

    public Quaternion {
        if (Double.isNaN(a) || Double.isNaN(b) || Double.isNaN(c) || Double.isNaN(d))
            throw new IllegalArgumentException("Coefficients cannot be NaN");
    }

    public Quaternion plus(Quaternion q) {
        return new Quaternion(a + q.a, b + q.b, c + q.c, d + q.d);
    }

    public Quaternion times(Quaternion q) {
        double na = a*q.a - b*q.b - c*q.c - d*q.d;
        double nb = a*q.b + b*q.a + c*q.d - d*q.c;
        double nc = a*q.c - b*q.d + c*q.a + d*q.b;
        double nd = a*q.d + b*q.c - c*q.b + d*q.a;
        return new Quaternion(na, nb, nc, nd);
    }

    public Quaternion conjugate() {
        return new Quaternion(a, -b, -c, -d);
    }

    public List<Double> coefficients() {
        return List.of(a, b, c, d);
    }

    @Override public String toString() {
        StringBuilder sb = new StringBuilder();
        appendTerm(sb, a, "");
        appendTerm(sb, b, "i");
        appendTerm(sb, c, "j");
        appendTerm(sb, d, "k");
        return sb.length() == 0 ? "0" : sb.toString();
    }

    private void appendTerm(StringBuilder sb, double val, String suffix) {
        if (val == 0) return;
        if (sb.length() > 0) sb.append(val < 0 ? "" : "+");
        sb.append(val).append(suffix);
    }
}

// =========================================================
// BinarySearchTree sealed interface and implementations
// =========================================================
sealed interface BinarySearchTree permits Empty, Node {
    BinarySearchTree insert(String value);
    boolean contains(String value);
    int size();
}

final class Empty implements BinarySearchTree {
    public BinarySearchTree insert(String value) { return new Node(value, this, this); }
    public boolean contains(String value) { return false; }
    public int size() { return 0; }
    public String toString() { return ""; }
}

final class Node implements BinarySearchTree {
    private final String value;
    private final BinarySearchTree left;
    private final BinarySearchTree right;

    Node(String value, BinarySearchTree left, BinarySearchTree right) {
        this.value = value;
        this.left = left;
        this.right = right;
    }

    public BinarySearchTree insert(String v) {
        int cmp = v.compareTo(value);
        if (cmp == 0) return this;
        if (cmp < 0) return new Node(value, left.insert(v), right);
        else return new Node(value, left, right.insert(v));
    }

    public boolean contains(String v) {
        int cmp = v.compareTo(value);
        if (cmp == 0) return true;
        return cmp < 0 ? left.contains(v) : right.contains(v);
    }

    public int size() {
        return 1 + left.size() + right.size();
    }

    public String toString() {
        return "(" + left + value + right + ")";
    }
}
