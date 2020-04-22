#!/usr/bin/python3

import sys
import subprocess
import importlib

module_list = ["cython"]

class PythonInstaller():
    def __init__(self):
        print("=============================================\n" \
              "            start setup python env           \n" \
              "=============================================\n")

    def install_modules(self, modules: list):
        print("Prepare python environment:")
        for module in modules:
            print(f"\tmodule: {module}")
            try:
                importlib.import_module(module)
                print(f"\t\t{module} found\t[yes]")
            except ModuleNotFoundError:
                print(f"\t\t{module} found\t[no]")
                print(f"\t\ttry to install {module}...")
                self._install(module)
            except Exception as e:
                print("A unknown Error has occurred:")
                print(e)
                exit(-1)

    def _install(self, module: str):
        if subprocess.call(['pip3','install', module]) == 0:
            print("\t\tInstallation of module successfull.")
        else:
            print("\t\tInstallation of module failed!")


if __name__ == "__main__":
    installer = PythonInstaller()
    installer.install_modules(module_list)
