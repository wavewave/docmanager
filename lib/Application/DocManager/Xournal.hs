module Application.DocManager.Xournal where

import System.IO
import System.FilePath
import System.Process 
import System.Directory

import Application.DocManager.Type 
import Application.DocManager.Config

import Control.Monad 

runHXournal :: DocManagerConfig -> Document -> IO () 
runHXournal dmc doc = do 
  let fname = docfilename doc 
  let wdir = dmc_working dmc
      xdir = dmc_xojbase dmc
      webdir = dmc_webbase dmc
  let (fnamebdy,fnameext) = splitExtension fname 

  putStrLn "runHXournal" 

  b1 <- doesDirectoryExist (wdir </> fnamebdy) 
  when b1 $ removeDirectoryRecursive (wdir </> fnamebdy) 

  b2 <- doesDirectoryExist (webdir </> fnamebdy)
  when b2 $ removeDirectoryRecursive (webdir </> fnamebdy)


  createDirectory (wdir </> fnamebdy)
  setCurrentDirectory (wdir </> fnamebdy)

  copyFile (xdir </> fname) (wdir </> fnamebdy </> fname) 
  system $ "hxournal makesvg " ++ fname

  renameDirectory (wdir </> fnamebdy) (webdir </> fnamebdy) 
  return ()

  