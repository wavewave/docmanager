{-# LANGUAGE RecordWildCards #-}

module Application.DocManager.Type where

import System.FilePath

data DocType = TeX | Xoj
             deriving (Show,Eq,Ord)

data Document = Document { prefix :: String
                         , serialnum :: String 
                         , version :: String
                         , doctype :: DocType } 
                deriving (Show)

doctypeext :: DocType -> String  
doctypeext TeX = "tex"
doctypeext Xoj = "xoj"

docfilename :: Document -> String 
docfilename Document {..} = 
    prefix ++ serialnum ++ version <.> doctypeext doctype 
             