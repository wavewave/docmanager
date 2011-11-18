{-# LANGUAGE DeriveDataTypeable #-}

module Application.DocManager.ProgType where 

import System.Console.CmdArgs

data Docmanager = Test 
                | Individual { filename :: String }
              deriving (Show,Data,Typeable)

test :: Docmanager
test = Test 

individual :: Docmanager 
individual = Individual { filename = "" &= typ "FileName" &= argPos 0 } 

mode = modes [test, individual]

