{-# LANGUAGE DeriveDataTypeable #-}

module Application.DocManager.Type where 

import System.Console.CmdArgs

data Docmanager = Test 
              deriving (Show,Data,Typeable)

test :: Docmanager
test = Test 

mode = modes [test]

