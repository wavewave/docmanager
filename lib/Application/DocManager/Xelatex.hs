module Application.DocManager.Xelatex where

import Application.DocManager.Config
import Application.DocManager.Type 

import Control.Monad 

import System.FilePath
import System.Directory
import System.Process 

runXelatex :: DocManagerConfig -> Document -> IO ()
runXelatex dmc doc = do 
  let wdir = dmc_working dmc
      bdir = dmc_texbase dmc 
      webdir = dmc_webbase dmc
  copyFile (bdir </> docfilename doc) (wdir </> docfilename doc)
  setCurrentDirectory wdir 
  replicateM 3 (system ("xelatex " ++ docfilename doc) )

  let (docfilenamebdy,_) = splitExtension (docfilename doc)

  copyFile (wdir </> docfilenamebdy <.> "pdf") 
           (webdir </> docfilenamebdy <.> "pdf")

  return () 
