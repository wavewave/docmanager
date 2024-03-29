module Application.DocManager.Command where

import Application.DocManager.ProgType
import Application.DocManager.Job

import Application.DocManager.Config

import Text.Parsec 

import System.Environment 
import System.FilePath

commandLineProcess :: Docmanager -> IO ()
commandLineProcess c = do 
  putStrLn "test called"
  homedir <- getEnv "HOME"
  let dotdocmanager = homedir </> ".docmanager"
  configstr <- readFile dotdocmanager
  let conf_result = parse docManagerConfigParser "" configstr 
  case conf_result of
    Left err -> putStrLn (show err) 
    Right dmc -> do  
      case c of 
        Test -> startJob dmc
        Individual fname -> startIndividualJob dmc fname



