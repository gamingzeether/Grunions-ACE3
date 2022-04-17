#!/usr/bin/env python3

import os
import sys
import subprocess

def build_release(projectpath):
    os.chdir(projectpath)
    
    print("Compiling SQF")
    compiler_exe = os.path.join(projectpath, "ArmaScriptCompiler.exe")
    ret = subprocess.call([compiler_exe], cwd=projectpath, stdout=False)
    print("")
    
    ret = subprocess.call(["hemtt.exe", "build", "--force", "--release"], stderr=subprocess.STDOUT)
    print(ret)
    
    sqfcpath = os.path.join(projectpath, "tools\\clean_sqfc.py")
    exec(open(sqfcpath).read())


def main():
    scriptpath = os.path.realpath(__file__)
    projectpath = os.path.dirname(os.path.dirname(scriptpath))
    os.chdir(projectpath)
    
    
    releasespath = os.path.join(projectpath, "releases")
    for root, _dirs, files in os.walk(releasespath, False):
        for file in files:
            filepath = os.path.join(root, file)
            os.remove(filepath)
        for dir in _dirs:
            dirpath = os.path.join(root, dir)
            os.rmdir(dirpath);
    
    # build no medical
    print("Building no medical")
    subprocess.call(["git", "checkout", "master"])
    build_release(projectpath)
    for item in os.listdir(releasespath):
        itempath = os.path.join(releasespath, item)
        if os.path.isfile(itempath):
            os.rename(itempath, itempath[:-4] + "_NoMed.zip")
        else:
            os.rename(itempath, itempath + "_NoMed")
    
    # build medical
    print("Building medical")
    subprocess.call(["git", "rebase", "master", "medical"])
    build_release(projectpath)
    
    # reset
    subprocess.call(["git", "checkout", "master"])


if __name__ == "__main__":
    sys.exit(main())
