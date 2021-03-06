module Data.DOM.Free
  ( Element()
  , Attribute()
  , Content()
  , AttributeKey()
  , IsValue
  , toValue

  , a
  , div
  , p
  , img 

  , href
  , _class
  , src
  , width
  , height

  , (:=)
  , text
  , elem
  , comment
  
  , render
  , render'
  ) where

import Data.Maybe
import Data.Array (map)
import Data.String (joinWith)
import Data.Foldable (for_)

import Control.Monad.Eff
import Control.Monad.Free
import Control.Monad.ST
import Control.Monad.Writer
import Control.Monad.Writer.Class

newtype Element = Element
  { name         :: String
  , attribs      :: [Attribute]
  , content      :: Maybe (Content Unit)
  }

data ContentF a
  = TextContent String a
  | ElementContent Element a
  | CommentContent String a

instance functorContentF :: Functor ContentF where
  (<$>) f (TextContent s a) = TextContent s (f a)
  (<$>) f (ElementContent e a) = ElementContent e (f a)
  (<$>) f (CommentContent s a) = CommentContent s (f a)

newtype Content a = Content (Free ContentF a)

runContent :: forall a. Content a -> Free ContentF a
runContent (Content x) = x

instance functorContent :: Functor Content where
  (<$>) f (Content x) = Content (f <$> x)

instance applyContent :: Apply Content where
  (<*>) (Content f) (Content x) = Content (f <*> x)

instance applicativeContent :: Applicative Content where
  pure = Content <<< pure

instance bindContent :: Bind Content where
  (>>=) (Content x) f = Content (x >>= (runContent <<< f))

instance monadContent :: Monad Content

newtype Attribute = Attribute
  { key          :: String 
  , value        :: String
  }

newtype AttributeKey a = AttributeKey String

element :: String -> [Attribute] -> Maybe (Content Unit) -> Element
element name attribs content = Element
  { name:      name
  , attribs:   attribs
  , content:   content
  }

text :: String -> Content Unit
text s = Content $ liftF $ TextContent s unit

elem :: Element -> Content Unit
elem e = Content $ liftF $ ElementContent e unit

comment :: String -> Content Unit
comment s = Content $ liftF $ CommentContent s unit

class IsValue a where
  toValue :: a -> String

instance stringIsValue :: IsValue String where
  toValue = id
 
instance numberIsValue :: IsValue Number where
  toValue = show

(:=) :: forall a. (IsValue a) => AttributeKey a -> a -> Attribute
(:=) (AttributeKey key) value = Attribute
  { key: key
  , value: toValue value
  }

a :: [Attribute] -> Content Unit -> Element
a attribs content = element "a" attribs (Just content)

div :: [Attribute] -> Content Unit -> Element
div attribs content = element "div" attribs (Just content)

p :: [Attribute] -> Content Unit -> Element
p attribs content = element "p" attribs (Just content)

img :: [Attribute] -> Element
img attribs = element "img" attribs Nothing

href :: AttributeKey String
href = AttributeKey "href"

_class :: AttributeKey String
_class = AttributeKey "class"

src :: AttributeKey String
src = AttributeKey "src"

width :: AttributeKey Number
width = AttributeKey "width"

height :: AttributeKey Number
height = AttributeKey "height"

render :: Element -> String
render e = execWriter $ renderElement e
  where
  renderElement :: Element -> Writer String Unit
  renderElement (Element e) = do
    tell "<"
    tell e.name
    for_ e.attribs $ \a -> do
      tell " "
      renderAttribute a
    renderContent e.content
    
    where
    renderAttribute :: Attribute -> Writer String Unit
    renderAttribute (Attribute a) = do
      tell a.key
      tell "=\""
      tell a.value
      tell "\""

    renderContent :: Maybe (Content Unit) -> Writer String Unit
    renderContent Nothing = tell " />"
    renderContent (Just (Content content)) = do
      tell ">"
      goM renderContentItem content
      tell "</"
      tell e.name
      tell ">"

    renderContentItem :: forall a. ContentF (Free ContentF a) -> Writer String (Free ContentF a)
    renderContentItem (TextContent s rest) = tell s >>= \_ -> return rest
    renderContentItem (ElementContent e rest) = renderElement e >>= \_ -> return rest
    renderContentItem (CommentContent s rest) = tell ("<!-- " ++ s ++ " -->") >>= \_ -> return rest


render' :: Element -> String
render' = pureST <<< renderST
  where
  renderST :: forall eff h. Element -> Eff (st :: ST h | eff) String
  renderST e = newSTRef "" >>= \ref -> (renderElement ref e)
    where
    renderElement ref' (Element e) = modifySTRef ref' (++ ("<" ++ e.name))
      >>= \_ -> for_ e.attribs (\a -> modifySTRef ref' (++ " ") >>= \_ -> renderAttribute ref' a)
      >>= \_ -> renderContent ref' e.content

      where
      renderAttribute ref'' (Attribute a) = modifySTRef ref' (++ (a.key ++ "=\"" ++ a.value ++ "\""))

      renderContent ref'' Nothing = modifySTRef ref'' (++ " />")
      renderContent ref'' (Just (Content content)) = modifySTRef ref'' (++ ">")
        >>= \_ -> goM (renderContentItem ref'') content
        >>= \_ -> modifySTRef ref'' (++ ("</" ++ e.name ++ ">"))

      renderContentItem ref'' (TextContent s rest)    = modifySTRef ref'' (++ s) >>= \_ -> return rest
      renderContentItem ref'' (ElementContent e rest) = renderElement ref'' e >>= \_ -> return rest
      renderContentItem ref'' (CommentContent s rest) = modifySTRef ref'' (++ comment) >>= \_ -> return rest
        where comment = ("<!-- " ++ s ++ " -->")
