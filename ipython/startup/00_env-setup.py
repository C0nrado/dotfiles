# This script sets up the python interpreter for the current env python exe
import os

env_name = os.environ.get('CONDA_DEFAULT_ENV')

# If current env name is `spark` then update python interpretar path for local env
# Python version should match that of the supported by the Spark version. Therefore is implicit
# that when creating a `spark` conda-env the chosen python version complies with the requeriments.

if os.environ.get('CONDA_PREFIX') and (env_name == 'spark'):
    pyspark_python = os.path.join(os.environ['CONDA_PREFIX'], 'bin/python')
    os.environ['PYSPARK_PYTHON'] = os.path.abspath(pyspark_python)
