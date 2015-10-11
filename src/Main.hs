{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Data.Text.Lazy as T
import Control.Monad.IO.Class (liftIO)
import Data.Monoid ((<>))

import Web.Scotty
import System.Environment

main :: IO ()
main = do
    port <- read <$> getEnv "PORT"
    scotty port $ do
      get "/env" $ do
        envList <- liftIO getEnvironment
        text $ envText envList
      get "/headers" $ do
        hs <- headers
        text $ T.intercalate "\n" $ map (\(k,v) -> k <> " = " <> v) hs
  where
    envText :: [(String, String)] -> T.Text
    envText es = T.intercalate "\n" $ map (\(k,v) -> T.pack (k ++ " = " ++ v)) es
