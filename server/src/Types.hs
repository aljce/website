{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Types where

import Control.Exception (throwIO)
import Control.Monad.Except (ExceptT, MonadError)
import Control.Monad.Reader (MonadIO, MonadReader, ReaderT)
import Servant (ServantErr)

import Database.Persist.Postgresql (ConnectionPool, ConnectionString, createPostgresqlPool)

newtype App a = App { runApp :: ReaderT Config (ExceptT ServantErr IO) a }
  deriving ( Functor, Applicative, Monad, MonadReader Config,
             MonadError ServantErr, MonadIO)

data Config = Config
    { getPool :: ConnectionPool
    , getEnv  :: Environment }

data Environment = Development | Test | Production deriving (Eq, Show, Read)
