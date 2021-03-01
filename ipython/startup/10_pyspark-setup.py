# import set-up for SPARK enn

import os

if os.environ.get('CONDA_DEFAULT_ENV') == 'spark':
    import findspark; findspark.init()
    import pyspark
    from pyspark import SparkContext
    from pyspark import SparkConf
