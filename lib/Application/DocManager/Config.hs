module Application.DocManager.Config where

import Text.Parsec
import Control.Monad.Identity
import Control.Applicative

import HEP.Parser.Config


data DocManagerConfig = DocManagerConfig { 
  dmc_working :: FilePath, 
  dmc_texbase :: FilePath, 
  dmc_xojbase :: FilePath,
  dmc_webbase :: FilePath
} deriving (Show)

docManagerConfigParser :: ParsecT String () Identity DocManagerConfig 
docManagerConfigParser = 
  oneGroupFieldInput "docmanager" $ 
    DocManagerConfig <$> (oneFieldInput "working") 
                     <*> (oneFieldInput "texbase")
                     <*> (oneFieldInput "xojbase")
                     <*> (oneFieldInput "webbase")

