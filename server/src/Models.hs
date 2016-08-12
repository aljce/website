{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
module Models where

import Control.Monad.Reader

import Database.Persist.Postgresql
import Database.Persist.TH  (mkMigrate, mkPersist, persistLowerCase, share, sqlSettings)

import Types

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|

User json
    name  String
    email String
    deriving Show

|]

doMigrations :: (MonadIO m) => SqlPersistT m ()
doMigrations = runMigration migrateAll

runDb :: (MonadReader a m, MonadIO m, a ~ Config) => SqlPersistT IO b -> m b
runDb query = asks getPool >>= liftIO . runSqlPool query

