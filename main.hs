module Main where

import Data.Functor (void, (<$>), (<$))

-- Step 1: Abstracting the map function
myMap :: (a -> b) -> [a] -> [b]
myMap _ []     = []
myMap f (x:xs) = f x : myMap f xs

exampleMap :: [Int]
exampleMap = myMap (+1) [1,2,3]

-- Step 2: The Functor type class
-- class Functor f where
--   fmap :: (a -> b) -> f a -> f b

-- Step 3: Defining Functor instances (custom example)
data Box a = Box a deriving Show

instance Functor Box where
  fmap f (Box x) = Box (f x)

exampleBox :: Box Int
exampleBox = fmap (*2) (Box 5)

-- Step 4: Seemingly unintuitive Functor instances
exampleTuple :: (String, Int)
exampleTuple = fmap (+10) ("score", 5)

-- Step 5: The Either a functor 🤔
exampleEither1 :: Either String Int
exampleEither1 = fmap (+3) (Right 7)

exampleEither2 :: Either String Int
exampleEither2 = fmap (+3) (Left "Error!")

-- Step 6: The (,) a functor 🤨
exampleTuple2 :: (String, Int)
exampleTuple2 = fmap (*3) ("points", 10)

-- Step 7: The (->) r functor 🤯
exampleFunction :: Int -> Int
exampleFunction = fmap (+1) (*2)

-- Step 8: Defining <$> and Lifting 🏋️ a function
exampleFmapOp :: Maybe Int
exampleFmapOp = (+2) <$> Just 8

liftedAdd :: Maybe Int -> Maybe Int -> Maybe Int
liftedAdd mx my = (+) <$> mx <*> my

-- Step 9: Functor nesting dolls 🪆
exampleNested :: [Maybe Int]
exampleNested = (fmap . fmap) (+1) [Just 3, Nothing, Just 5]

-- Step 10: Extra functions and Functor as defined in base
exampleVoid :: Maybe ()
exampleVoid = void (Just 99)

exampleReplace :: [String]
exampleReplace = ("x" <$ ["a","b","c"])

main :: IO ()
main = do
    putStrLn "=== Functor Marathon Demo ==="
    putStrLn "Step 1: Abstracting the map function"
    print exampleMap

    putStrLn "\nStep 3: Functor instance example"
    print exampleBox

    putStrLn "\nStep 4: Seemingly unintuitive Functor instances"
    print exampleTuple

    putStrLn "\nStep 5: Either a Functor"
    print exampleEither1
    print exampleEither2

    putStrLn "\nStep 6: (,) a Functor"
    print exampleTuple2

    putStrLn "\nStep 7: (->) r Functor"
    print (exampleFunction 3)

    putStrLn "\nStep 8: <$>, Lifting functions"
    print exampleFmapOp
    print (liftedAdd (Just 2) (Just 5))

    putStrLn "\nStep 9: Functor nesting dolls"
    print exampleNested

    putStrLn "\nStep 10: Extra functions and Functor from base"
    print exampleVoid
    print exampleReplace
