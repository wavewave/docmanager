module Application.DocManager.Command where

import Application.DocManager.Type
import Application.DocManager.Job

commandLineProcess :: Docmanager -> IO ()
commandLineProcess Test = do 
  putStrLn "test called"
  startJob
