module PartFour where

import PartOne

-- Determine whether a given integer number is prime.
problem31 :: Integral a => a -> Bool
problem31 x
  | x < 2 = False
  | x <= 3 = True
  | mod x 2 == 0 = False
  | mod x 3 == 0 = False
  | otherwise = calc 5
  where
    calc i
      | (i * i) > x = True
      | mod x i == 0 = False
      | mod x (i + 2) == 0 = False
      | otherwise = calc $ i + 6

-- Determine the greatest common divisor of two positive integer numbers. Use Euclid's algorithm.
problem32 :: Integral a => a -> a -> a
problem32 x y =
  if y == 0
    then abs x
    else problem32 y $ mod x y

-- Determine whether two positive integer numbers are coprime. Two numbers are coprime if their greatest common divisor equals 1.
problem33 :: Integral a => a -> a -> Bool
problem33 x y = gcd x y == 1

-- Calculate Euler's totient function phi(m).
problem34 :: Integral a => a -> a
problem34 1 = 1
problem34 x =
  sum $
  map
    (\a ->
       if problem33 x a
         then 1
         else 0)
    [1 .. x - 1]

problem34' :: Integral a => a -> Int
problem34' 1 = 1
problem34' x = length $ filter (problem33 x) [1 .. x - 1]

-- Determine the prime factors of a given positive integer. Construct a flat list containing the prime factors in ascending order.
problem35 :: Integral a => a -> [a]
problem35 n = problem32' [n]
  where
    problem32' (x:xs)
      | problem31 x = xs ++ [x]
      | mod x 2 == 0 = problem32' $ (div x 2) : xs ++ [2]
      | mod x 3 == 0 = problem32' $ (div x 3) : xs ++ [3]
      | mod x 5 == 0 = problem32' $ (div x 5) : xs ++ [5]
      | mod x 7 == 0 = problem32' $ (div x 7) : xs ++ [7]
      | otherwise = error "What happened?"

-- Determine the prime factors of a given positive integer.
problem36 :: Integral a => a -> [(a, Int)]
problem36 n = map swap $ problem10 $ problem35 n
  where
    swap (x, y) = (y, x)

-- Calculate Euler's totient function phi(m) (improved).
problem37 :: Integral a => a -> a
problem37 x = foldr (*) 1 $ map (\(p, m) -> (p - 1) * p ^ (m - 1)) $ problem36 x

problem37' :: Integral a => a -> a
problem37' x = product [(p - 1) * p ^ (m - 1) | (p, m) <- problem36 x]

-- A list of prime numbers.
problem39 :: Integral a => a -> a -> [a]
problem39 x y = filter problem31 [x .. y]

-- Goldbach's conjecture.
problem40 :: Integral a => a -> (a, a)
problem40 n = head [(a, b) | a <- primes, b <- primes, a + b == n]
  where
    primes = problem39 2 (n - 2)

problem40' :: Integral a => a -> (a, a)
problem40' n =
  head [(x, y) | x <- problem39 2 (n - 2), let y = n - x, problem31 y]

-- Given a range of integers by its lower and upper limit, print a list of all even numbers and their Goldbach composition.
problem41 :: Integral a => a -> a -> [(a, a)]
problem41 x y = map problem40' $ filter even [x .. y]

-- Very rarely, the primes are both bigger than say 50. Try to find out how many such cases there are in the range 2..3000.
problem41' :: Integral a => a -> a -> a -> [(a, a)]
problem41' x y m = filter (\(a, b) -> a > m && b > m) $ problem41 x y
