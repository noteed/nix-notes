{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import Network.Wai.Handler.Warp
import Servant


------------------------------------------------------------------------------
main :: IO ()
main = runSettings appSettings (serve server handler)
  where
  appSettings = (setPort 8000 . setHost "0.0.0.0") defaultSettings


------------------------------------------------------------------------------
type AddAPI =
  "add" :> Capture "a" Integer :> Capture "b" Integer :> Get '[JSON] Integer

------------------------------------------------------------------------------
server :: Proxy AddAPI
server = Proxy

handler :: Server AddAPI
handler a b = pure (a + b)
