import java.io.BufferedReader
import java.io.File
import java.io.IOException

fun <T> firstThenLowerCase(
    array: Array<T>
    predicate: (T) -> Boolean
): String? = array.firstOrNull(predicate)?.toString()?.lowercase()

class Say private constructor(private val words: List<String>) {
    val phrase: String
        get() = words.joinToString(" ")

    fun and (word: String): Say = 
        Say(words + word)

    companion object {
        fun start(first: String): Say =
            Say(listOf(first))
    }
}

fun countRelevantLines(filename: String): Int {
    return File(filename).bufferedReader().use { reader: BufferedReader ->
        reader.lineSequence()
            .filter { line ->
                val trimmed = line.trim()
                trimmed.isNotEmpty() && !trimmed.startsWith("#")
                }
                .count()
    }
}

data class Quaternion private constructor(
    val a: Double, 
    val b: Double, 
    val c: Double, 
    val d: Double 
) {
    operator fun plus(other: Quaternion): Quaternion = 
        Quaternion(a + other.a, b + other.b, c + other.c, d + other.d)

    operator fun times(other: Quaternion): Quaternion {
        val e = other.a
        val f = other.b
        val g = other.c
        val h = other.d

        val ra = a * e - b * f - c * g - d * h
        val rb = a * f + b * e + c * h - d * g
        val rc = a * g - b * h + c * e + d * f 
        val rd = a * h + b * g - c * f + d * e 

        return Quaternion(ra, rb, rc, rd)
    }

    fun conjugate(): Quaternion = 
        Quaternion(a, -b, -c, -d)

    fun coefficients(): DoubleArray = 
        doubleArrayOf(a, b, c, d)

    override fun toString(): String = 
        "($a, $b, $c, $d)"

    companion object {
        val ZERO = Quaternion(0.0, 0.0, 0.0, 0.0)
        val I = Quaternion(0.0, 1.0, 0.0, 0.0)
        val J = Quaternion(0.0, 0.0, 1.0, 0.0)
        val K = Quaternion(0.0, 0.0, 0.0, 1.0)

        fun of(a: Double, b: Double, c: Double, d: Double): Quaternion = 
            Quaternion(a, b, c, d)
    }
}

sealed interface BinarySearchTree {
    val size: Int
    
    fun insert(value: String): BinarySearchTree

    fun contains(value: String): Boolean

    override fun toString(): String

    object Empty: BinarySearchTree {
        override val size: Int = 0
        
        override fun insert(value: String): BinarySearchTree = 
            Node(value, this, this)

        override fun contains(value: String): Boolean = false

        override fun toString(): String = ""
    }

    data class Node(
        val value: String,
        val left: BinarySearchTree,
        val right: BinarySearchTree
    ) : BinarySearchTree {
        override val size: Int = 1 + left.size + right.size

        override fun insert(value: String): BinarySearchTree = 
            when {
                value < this.value ->
                    Node(this.value, left.insert(value), right)
                value > this.value ->
                    Node(this.value, left, right.insert(value))
                else -> this
            }
        
        override fun contains(value: String): Boolean = 
            when {
                value < this.value -> left.contains(value)
                value > this.value -> right.contains(value)
                else -> true
            }
        
        override fun toString(): String = 
            "(${left.toString()}$value${right.toString()})"
    }
}