{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Data.GI.Base
import qualified Data.Text    as T
import qualified GI.Gdk
import qualified GI.GLib
import           GI.GObject
import           GI.Gtk       (IsBuilder, ToolButton (..), Window (..))
import qualified GI.Gtk

main :: IO ()
main = do
  _          <- GI.Gtk.init Nothing
  builder    <- GI.Gtk.builderNewFromFile "app/gui.glade"
  mainwindow <- builderGetObject Window builder "xcb-vs-gtk-window"

  openButton <- builderGetObject ToolButton builder "open-button"
  _shid0     <- GI.Gtk.onWidgetButtonReleaseEvent openButton $ \_evbtn -> do
    _esid <- GI.Gdk.threadsAddIdle GI.GLib.PRIORITY_DEFAULT $
      GI.Gtk.fileChooserNativeNew Nothing
                                  (Just mainwindow)
                                  GI.Gtk.FileChooserActionSave
                                  Nothing
                                  Nothing
        >>= GI.Gtk.nativeDialogRun
        >>= print
        >>  return True
    return True

  _shid1     <- GI.Gtk.onWidgetStateFlagsChanged mainwindow print

  _shid2     <- GI.Gtk.onWidgetDestroy mainwindow GI.Gtk.mainQuit
  GI.Gtk.widgetShowAll mainwindow
  GI.Gtk.main

builderGetObject
  :: (GI.GObject.GObject b, IsBuilder a)
  => (Data.GI.Base.ManagedPtr b -> b)
  -> a
  -> T.Text
  -> IO b
builderGetObject objectTypeClass builder objectId = do
  m <- GI.Gtk.builderGetObject builder objectId
  case m of
    Nothing -> error $ "Couldn't find GUI object with id " ++ T.unpack objectId ++ " in gui.glade"
    Just o  -> GI.Gtk.unsafeCastTo objectTypeClass o
