module Api (API,serveAPI) where

import Servant

type API = "api" :> Get '[JSON] [()]

serveAPI :: Server API
serveAPI = return [()]