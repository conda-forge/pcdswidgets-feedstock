# Install the package
$PYTHON setup.py install --single-version-externally-managed --record=record.txt

# Create auxiliary dirs
mkdir -p $PREFIX/etc/conda/activate.d
mkdir -p $PREFIX/etc/conda/deactivate.d
mkdir -p $PREFIX/etc/pcdswidgets

# Create auxiliary vars
DESIGNER_PLUGIN_PATH=$PREFIX/etc/pcdswidgets
DESIGNER_PLUGIN=$DESIGNER_PLUGIN_PATH/pcdswidgets_designer_plugin.py
ACTIVATE=$PREFIX/etc/conda/activate.d/pcdswidgets
DEACTIVATE=$PREFIX/etc/conda/deactivate.d/pcdswidgets

echo "from pcdswidgets.designer import *" >> $DESIGNER_PLUGIN

echo "export PYQTDESIGNERPATH=\$CONDA_PREFIX/etc/pcdswidgets:\$PYQTDESIGNERPATH" >> $ACTIVATE.sh
echo "unset PYQTDESIGNERPATH" >> $DEACTIVATE.sh

echo '@echo OFF' >> $ACTIVATE.bat
echo 'IF "%PYQTDESIGNERPATH%" == "" (' >> $ACTIVATE.bat
echo 'set PYQTDESIGNERPATH=%CONDA_PREFIX%\etc\pcdswidgets' >> $ACTIVATE.bat
echo ')ELSE (' >> $ACTIVATE.bat
echo 'set PYQTDESIGNERPATH=%CONDA_PREFIX%\etc\pcdswidgets;%PYQTDESIGNERPATH%' >> $ACTIVATE.bat
echo ')' >> $ACTIVATE.bat

unset DESIGNER_PLUGIN_PATH
unset DESIGNER_PLUGIN
unset ACTIVATE
unset DEACTIVATE
