module Application.DocManager.Job where

import Application.DocManager.Config
import Application.DocManager.Type 
import Application.DocManager.Data.Document

import Control.Monad

import System.FilePath 
import System.Directory 
import System.Process 



startJob :: DocManagerConfig -> IO () 
startJob dmc = do 
  putStrLn "job started"
  putStrLn $ show dmc 

  let wdir = dmc_workingdir  dmc
      bdir = dmc_docbase dmc 
  mapM_ (putStrLn . docfilename) doclist 

  let cpfile x = copyFile (bdir </> docfilename x) (wdir </> docfilename x)
      xelatex x = replicateM 4 (system ("xelatex " ++ docfilename x) )

  let texfilelist = filter (\x->doctype x == TeX) doclist 
  mapM_ cpfile  texfilelist 

  setCurrentDirectory wdir 

  mapM_ xelatex texfilelist 



  

