-- Generated by psc-make version 0.6.9.3
module Data.Array.ST where
import Data.Function ()
import Data.Array.ST ()
import Prim ()
import Prelude ()
import Data.Maybe ()
import Data.Function ()
import Control.Monad.Eff ()
import Control.Monad.ST ()
--  | A reference to a mutable array.
--  |
--  | The first type parameter represents the memory region which the array belongs to.
--  | The second type parameter defines the type of elements of the mutable array.
--  |
--  | The runtime representation of a value of type `STArray h a` is the same as that of `[a]`,
--  | except that mutation is allowed.
--  | An element and its index
--  | Freeze a mutable array, creating an immutable array. Use this function as you would use
--  | `runST` to freeze a mutable reference.
--  |
--  | The rank-2 type prevents the reference from escaping the scope of `runSTArray`.
--  | Create an empty mutable array.
--  | Create an immutable copy of a mutable array, where each element
--  | is labelled with its index in the original array.
--  | Create a mutable copy of an immutable array.
--  | Remove and/or insert elements from/into a mutable array at the specified index.
--  | Append the values in an immutable array to the end of a mutable array.
--  | Append an element to the end of a mutable array.
--  | Change the value at the specified index in a mutable array.
--  | Read the value at the specified index in a mutable array.
--  | Create an immutable copy of a mutable array.
type Assoc (a :: *) = { index :: Prim.Number, value :: a }
foreign import data STArray :: * -> * -> *
foreign import toAssocArray :: forall a h r. Data.Array.ST.STArray h a -> Control.Monad.Eff.Eff (st :: Control.Monad.ST.ST h | r) [Data.Array.ST.Assoc a]
foreign import thaw :: forall a h r. [a] -> Control.Monad.Eff.Eff (st :: Control.Monad.ST.ST h | r) (Data.Array.ST.STArray h a)
foreign import freeze :: forall a h r. Data.Array.ST.STArray h a -> Control.Monad.Eff.Eff (st :: Control.Monad.ST.ST h | r) [a]
foreign import spliceSTArray :: forall a h r. Data.Array.ST.STArray h a -> Prim.Number -> Prim.Number -> [a] -> Control.Monad.Eff.Eff (st :: Control.Monad.ST.ST h | r) [a]
foreign import pushAllSTArray :: forall a h r. Data.Array.ST.STArray h a -> [a] -> Control.Monad.Eff.Eff (st :: Control.Monad.ST.ST h | r) Prim.Number
foreign import pushSTArray :: forall a h r. Data.Array.ST.STArray h a -> a -> Control.Monad.Eff.Eff (st :: Control.Monad.ST.ST h | r) Prim.Number
foreign import pokeSTArray :: forall a h r. Data.Array.ST.STArray h a -> Prim.Number -> a -> Control.Monad.Eff.Eff (st :: Control.Monad.ST.ST h | r) Prim.Boolean
foreign import peekSTArray :: forall a h r. Data.Array.ST.STArray h a -> Prim.Number -> Control.Monad.Eff.Eff (st :: Control.Monad.ST.ST h | r) (Data.Maybe.Maybe a)
foreign import emptySTArray :: forall a h r. Control.Monad.Eff.Eff (st :: Control.Monad.ST.ST h | r) (Data.Array.ST.STArray h a)
foreign import runSTArray :: forall a r. (forall h. Control.Monad.Eff.Eff (st :: Control.Monad.ST.ST h | r) (Data.Array.ST.STArray h a)) -> Control.Monad.Eff.Eff r [a]
