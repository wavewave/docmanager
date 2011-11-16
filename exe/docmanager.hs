module Main where

import System.Console.CmdArgs

import Application.DocManager.Type
import Application.DocManager.Command

main :: IO () 
main = do 
  putStrLn "docmanager"
  param <- cmdArgs mode

  commandLineProcess param