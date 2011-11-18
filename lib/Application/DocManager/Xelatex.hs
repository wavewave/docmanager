module Application.DocManager.Xelatex where

import Application.DocManager.Config
import Application.DocManager.Type 

import Control.Monad 

import System.FilePath
import System.Directory
import System.Process 

cpPics :: DocManagerConfig -> IO () 
cpPics dmc = do 
  let wdir = dmc_working dmc 
      bdir = dmc_texbase dmc 
  b <- doesDirectoryExist (wdir </> "pic")
  when b $ removeDirectoryRecursive (wdir </> "pic") 
 
  createDirectory (wdir </> "pic")   
  cnts <- getDirectoryContents (bdir </> "pic")  
  
  let f [] = return ()
      f "." = return () 
      f ".." = return ()
      f fn = copyFile (bdir </> "pic" </> fn) (wdir </> "pic" </> fn)
  mapM_ f cnts 

runXelatex :: DocManagerConfig -> Document -> IO ()
runXelatex dmc doc = do 
  let wdir = dmc_working dmc
      bdir = dmc_texbase dmc 
      webdir = dmc_webbase dmc
  copyFile (bdir </> docfilename doc) (wdir </> docfilename doc)
  setCurrentDirectory wdir 
  replicateM 4 (system ("xelatex " ++ docfilename doc) )

  let (docfilenamebdy,_) = splitExtension (docfilename doc)

  copyFile (wdir </> docfilenamebdy <.> "pdf") 
           (webdir </> docfilenamebdy <.> "pdf")

  return () 
