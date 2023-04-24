# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

import Client_rc
from GUI.UI.MainUI import MainUI

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    qml_file = Path(__file__).resolve().parent / "content/App.qml"
    engine.load(u":/content/App.qml")
    objects = engine.rootObjects()
    if not objects:
        sys.exit(-1)

    rootObject = objects[0]

    MainUI(rootObject)

    sys.exit(app.exec())
