-- Generated by psc-make version 0.6.9.3
module Data.Traversable where
import Prelude ()
import Data.Traversable ()
import Data.Array ()
import Data.Tuple ()
import Prim ()
import Prelude ()
import Data.Array ()
import Data.Either ()
import Data.Foldable ()
import Data.Maybe ()
import Data.Monoid.Additive ()
import Data.Monoid.Dual ()
import Data.Monoid.First ()
import Data.Monoid.Last ()
import Data.Monoid.Multiplicative ()
import Data.Tuple ()
--  | `Traversable` represents data structures which can be _traversed_,
--  | accumulating results and effects in some `Applicative` functor.
--  |
--  | - `traverse` runs an action for every element in a data structure,
--  |   and accumulates the results.
--  | - `sequence` runs the actions _contained_ in a data structure,
--  |   and accumulates the results.
--  |
--  | The `traverse` and `sequence` functions should be compatible in the
--  | following sense:
--  |
--  | - `traverse f xs = sequence (f <$> xs)`
--  | - `sequence = traverse id` 
--  | 
--  | `Traversable` instances should also be compatible with the corresponding
--  | `Foldable` instances, in the following sense:
--  |
--  | - `foldMap f = runConst <<< traverse (Const <<< f)`
--  | `Traversable` represents data structures which can be _traversed_,
--  | accumulating results and effects in some `Applicative` functor.
--  |
--  | - `traverse` runs an action for every element in a data structure,
--  |   and accumulates the results.
--  | - `sequence` runs the actions _contained_ in a data structure,
--  |   and accumulates the results.
--  |
--  | The `traverse` and `sequence` functions should be compatible in the
--  | following sense:
--  |
--  | - `traverse f xs = sequence (f <$> xs)`
--  | - `sequence = traverse id` 
--  | 
--  | `Traversable` instances should also be compatible with the corresponding
--  | `Foldable` instances, in the following sense:
--  |
--  | - `foldMap f = runConst <<< traverse (Const <<< f)`
--  | `Traversable` represents data structures which can be _traversed_,
--  | accumulating results and effects in some `Applicative` functor.
--  |
--  | - `traverse` runs an action for every element in a data structure,
--  |   and accumulates the results.
--  | - `sequence` runs the actions _contained_ in a data structure,
--  |   and accumulates the results.
--  |
--  | The `traverse` and `sequence` functions should be compatible in the
--  | following sense:
--  |
--  | - `traverse f xs = sequence (f <$> xs)`
--  | - `sequence = traverse id` 
--  | 
--  | `Traversable` instances should also be compatible with the corresponding
--  | `Foldable` instances, in the following sense:
--  |
--  | - `foldMap f = runConst <<< traverse (Const <<< f)`
--  | `Traversable` represents data structures which can be _traversed_,
--  | accumulating results and effects in some `Applicative` functor.
--  |
--  | - `traverse` runs an action for every element in a data structure,
--  |   and accumulates the results.
--  | - `sequence` runs the actions _contained_ in a data structure,
--  |   and accumulates the results.
--  |
--  | The `traverse` and `sequence` functions should be compatible in the
--  | following sense:
--  |
--  | - `traverse f xs = sequence (f <$> xs)`
--  | - `sequence = traverse id` 
--  | 
--  | `Traversable` instances should also be compatible with the corresponding
--  | `Foldable` instances, in the following sense:
--  |
--  | - `foldMap f = runConst <<< traverse (Const <<< f)`
--  | A generalization of `zipWith` which accumulates results in some `Applicative`
--  | functor.
--  | A version of `traverse` with its arguments flipped.
--  |
--  | 
--  | This can be useful when running an action written using do notation
--  | for every element in a data structure:
--  |
--  | For example:
--  |
--  | ```purescript
--  | for [1, 2, 3] \n -> do
--  |   print n
--  |   return (n * n)
--  | ```
--  | Fold a data structure from the right, keeping all intermediate results
--  | instead of only the final result.
--  |
--  | Unlike `scanr`, `mapAccumR` allows the type of accumulator to differ
--  | from the element type of the final data structure.
--  | Fold a data structure from the right, keeping all intermediate results
--  | instead of only the final result.
--  | Fold a data structure from the left, keeping all intermediate results
--  | instead of only the final result.
--  |
--  | Unlike `scanl`, `mapAccumL` allows the type of accumulator to differ
--  | from the element type of the final data structure.
--  | Fold a data structure from the left, keeping all intermediate results
--  | instead of only the final result.
class (Prelude.Functor t, Data.Foldable.Foldable t) <= Traversable t where
  traverse :: forall a b m. (Prelude.Applicative m) => (a -> m b) -> t a -> m (t b)
  sequence :: forall a m. (Prelude.Applicative m) => t (m a) -> m (t a)
foreign import mapAccumR :: forall a b s f. (Data.Traversable.Traversable f) => (s -> a -> Data.Tuple.Tuple s b) -> s -> f a -> Data.Tuple.Tuple s (f b)
foreign import mapAccumL :: forall a b s f. (Data.Traversable.Traversable f) => (s -> a -> Data.Tuple.Tuple s b) -> s -> f a -> Data.Tuple.Tuple s (f b)
foreign import scanr :: forall a b f. (Data.Traversable.Traversable f) => (a -> b -> b) -> b -> f a -> f b
foreign import scanl :: forall a b f. (Data.Traversable.Traversable f) => (b -> a -> b) -> b -> f a -> f b
foreign import zipWithA :: forall m a b c. (Prelude.Applicative m) => (a -> b -> m c) -> [a] -> [b] -> m [c]
foreign import for :: forall a b m t. (Prelude.Applicative m, Data.Traversable.Traversable t) => t a -> (a -> m b) -> m (t b)
foreign import instance traversableArray :: Data.Traversable.Traversable Prim.Array
foreign import instance traversableEither :: Data.Traversable.Traversable (Data.Either.Either a)
foreign import instance traversableMaybe :: Data.Traversable.Traversable Data.Maybe.Maybe
foreign import instance traversableTuple :: Data.Traversable.Traversable (Data.Tuple.Tuple a)
foreign import instance traversableAdditive :: Data.Traversable.Traversable Data.Monoid.Additive.Additive
foreign import instance traversableDual :: Data.Traversable.Traversable Data.Monoid.Dual.Dual
foreign import instance traversableFirst :: Data.Traversable.Traversable Data.Monoid.First.First
foreign import instance traversableLast :: Data.Traversable.Traversable Data.Monoid.Last.Last
foreign import instance traversableMultiplicative :: Data.Traversable.Traversable Data.Monoid.Multiplicative.Multiplicative
