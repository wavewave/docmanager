module Application.DocManager.Config where

import Text.Parsec
import Control.Monad.Identity
import Control.Applicative

import HEP.Parser.Config


data DocManagerConfig = DocManagerConfig { 
  dmc_workingdir :: FilePath, 
  dmc_docbase :: FilePath
} deriving (Show)

docManagerConfigParser :: ParsecT String () Identity DocManagerConfig 
docManagerConfigParser = 
  oneGroupFieldInput "docmanager" $ 
    DocManagerConfig <$> (oneFieldInput "workingdir") 
                     <*> (oneFieldInput "docbase")

