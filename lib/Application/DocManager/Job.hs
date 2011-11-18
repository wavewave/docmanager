module Application.DocManager.Job where

import Application.DocManager.Config
import Application.DocManager.Type 
import Application.DocManager.Data.Document
import Application.DocManager.Xournal 
import Application.DocManager.Xelatex 

import Control.Monad
import Data.List
import Data.Char

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

startIndividualJob :: DocManagerConfig -> String -> IO () 
startIndividualJob dmc fname = do 
  putStrLn "individual job started"
  putStrLn $ show dmc 
  
  let (fnamebdy,fnameext) =  splitExtension fname 

  let (p,f') = span isAlpha fnamebdy 
      (sn,vn) = span isDigit f' 
  case fnameext of 
    ".tex" -> do putStrLn "tex file"
                 let doc = Document p sn vn TeX
                 putStrLn $ show doc
                 cpPics dmc 
                 runXelatex dmc doc 

    ".xoj" -> do putStrLn "xoj file" 
                 let doc = Document p sn vn Xoj
                 putStrLn $ show doc 
                 runHXournal dmc doc 

{-


   mapM_ (runXelatex dmc) texfilelist 
  mapM_ (runHXournal dmc) xojfilelist 
 
-}


  

