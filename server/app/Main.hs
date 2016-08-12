module Main where

import Control.Monad.Logger (runStdoutLoggingT)
import Database.Persist.Postgresql (ConnectionPool, ConnectionString, createPostgresqlPool, runSqlPool)

import Network.Wai.Handler.Warp

import qualified Models as Models
import qualified App as App

main :: IO ()
main = do
  pool <- runStdoutLoggingT (createPostgresqlPool "host=localhost dbname=website user=test password=test port=5432" 1)
  runSqlPool Models.doMigrations pool
  run 8080 App.app
