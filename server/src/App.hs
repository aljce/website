module App (app) where

import Network.Wai
import Servant

import Api

type APP = API :<|> Raw

server :: Server APP
server = serveAPI :<|> serveDirectory "../client"

app :: Application
app = serve (Proxy :: Proxy APP) server

