module Application.DocManager.Job where

import Application.DocManager.Config
import Application.DocManager.Type 
import Application.DocManager.Data.Document
import Application.DocManager.Xournal 
import Application.DocManager.Xelatex 

import Control.Monad

import System.FilePath 
import System.Directory 
import System.Process 

startJob :: DocManagerConfig -> IO () 
startJob dmc = do 
  putStrLn "job started"
  putStrLn $ show dmc 

  let texfilelist = filter (\x->doctype x == TeX) doclist 
      xojfilelist = filter (\x->doctype x == Xoj) doclist 

  mapM_ (runXelatex dmc) texfilelist 
  mapM_ (runHXournal dmc) xojfilelist 
 


  

