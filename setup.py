from setuptools import setup, find_namespace_packages
import os

directory = os.path.dirname(os.path.realpath(__file__))


setup(
    packages=find_namespace_packages(),
	entry_points={
		'console_scripts': [
			'freefang-qt = freefang_qt.main:main',
		],
	},
	package_data={"freefang_qt": [os.path.join(directory, "freefang_qt/qml/*")]},
)
