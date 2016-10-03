module Main where

import Prelude hiding (IO)
import qualified Prelude as P

import Data.Vector
import Data.Text

data World = World {
  stdin  :: Vector Text,
  stdout :: Vector Text
                   }

data Interrupt = RequestStdin

newtype IO a = IO (World -> Either Interrupt (World, a))

instance Functor IO where
  fmap f (IO action) = IO (\world1 -> case action world1 of
                             Right (world2,a) -> Right (world2, f a)
                             Left interrupt -> Left interrupt)

instance Applicative IO where
  pure x = IO (\world -> Right (world, x))
  (IO fAction) <*> (IO xAction) =
    IO (\world1 -> case fAction world1 of
           Right (world2, f) -> case xAction world2 of
             Right (world3, x) -> Right (world3, f x)
             Left interrupt -> Left interrupt
           Left interrupt -> Left interrupt)

instance Monad IO where
  return = pure
  (IO xAction) >>= f = IO (\world1 -> case xAction world1 of
                              Right (world2, x) -> case f x of
                                IO action -> action world2
                              Left interrupt -> Left interrupt)

main :: P.IO ()
main = putStrLn "IO!"
