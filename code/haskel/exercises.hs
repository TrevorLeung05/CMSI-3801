module Exercises (
    firstThenApply,
    powers,
    Shape(..), -- Exporting the type and its constructors
    volume,
    surfaceArea,
    BST(..),   -- Exporting the type and its constructors
    size,
    contains,
    insert,
    inorder,
    meaningfulLineCount
) where

import System.IO
import Data.Char (isSpace)
import Data.List (isPrefixOf)

-- | Finds the first element in a list satisfying a predicate,
-- | then applies a function to it.
firstThenApply :: [a] -> (a -> Bool) -> (a -> b) -> Maybe b
firstThenApply [] _ _ = Nothing
firstThenApply (x:xs) p f
    | p x       = Just (f x)
    | otherwise = firstThenApply xs p f

-- | Generates an infinite list of powers of a number.
-- | e.g., powers 2 = [1, 2, 4, 8, ...]
powers :: Num a => a -> [a]
powers n = iterate (*n) 1

-- | A data type representing geometric shapes.
data Shape = Sphere Double | Box Double Double Double deriving (Eq, Show)

-- | Calculates the volume of a shape.
volume :: Shape -> Double
volume (Sphere r) = (4/3) * pi * r^3
volume (Box l w h) = l * w * h

-- | Calculates the surface area of a shape.
surfaceArea :: Shape -> Double
surfaceArea (Sphere r) = 4 * pi * r^2
surfaceArea (Box l w h) = 2 * (l*w + l*h + w*h)

-- | A data type for a Binary Search Tree.
data BST a = Empty | Node (BST a) a (BST a)

-- | Custom Show instance to match the test cases.
instance Show a => Show (BST a) where
    show Empty = "()"
    show (Node l v r) = "(" ++ showSub l ++ show v ++ showSub r ++ ")"
      where
        -- Helper to avoid printing "()" for empty subtrees inside a node
        showSub :: Show a => BST a -> String
        showSub Empty = ""
        showSub tree = show tree

-- | Calculates the number of nodes in a BST.
size :: BST a -> Int
size Empty = 0
size (Node l _ r) = 1 + size l + size r

-- | Checks if a value is present in the BST.
contains :: Ord a => a -> BST a -> Bool
contains _ Empty = False
contains x (Node l v r)
    | x == v    = True
    | x < v     = contains x l
    | otherwise = contains x r

-- | Inserts a value into the BST. Does not add duplicates.
insert :: Ord a => a -> BST a -> BST a
insert x Empty = Node Empty x Empty
insert x (Node l v r)
    | x == v    = Node l v r -- Value already exists
    | x < v     = Node (insert x l) v r
    | otherwise = Node l v (insert x r)

-- | Performs an in-order traversal of the BST, returning a sorted list.
inorder :: BST a -> [a]
inorder Empty = []
inorder (Node l v r) = inorder l ++ [v] ++ inorder r

-- | Helper function to trim whitespace from both ends of a string.
trim :: String -> String
trim = f . f
   where f = reverse . dropWhile isSpace

-- | Helper function to determine if a line is "meaningful"
-- | (not empty and not a comment).
isMeaningful :: String -> Bool
isMeaningful line =
    let trimmed = trim line
    in not (null trimmed) && not ("--" `isPrefixOf` trimmed)

-- | Reads a file and counts the number of "meaningful" lines.
-- | A meaningful line is one that is not empty and does not
-- | start with "--" (after trimming whitespace).
meaningfulLineCount :: FilePath -> IO Int
meaningfulLineCount filepath = do
    contents <- readFile filepath
    let allLines = lines contents
    let meaningfulLines = filter isMeaningful allLines
    return (length meaningfulLines)
