#!/usr/bin/env python3

import os
import sys
import subprocess

projectpath = ""
releasespath = ""
forcebuilt = False

def build_release():
    global forcebuilt
    os.chdir(projectpath)
    
    if not forcebuilt:
        print("Compiling SQF")
        compiler_exe = os.path.join(projectpath, "ArmaScriptCompiler.exe")
        ret = subprocess.call([compiler_exe], cwd=projectpath, stdout=False)
        print("")
    
        ret = subprocess.call(["hemtt.exe", "build", "--force", "--release"], stderr=subprocess.STDOUT)
        print(ret)
        forcebuilt = True
    else:
        ret = subprocess.call(["hemtt.exe", "build", "--release"], stderr=subprocess.STDOUT)
        print(ret)


def rename_builds(end):
    for item in os.listdir(releasespath):
        if not "ver" in item:
            itempath = os.path.join(releasespath, item)
            if os.path.isfile(itempath):
                os.rename(itempath, itempath[:-4] + "_ver_" + end + ".zip")
            else:
                os.rename(itempath, itempath + "_ver_" + end)


def build_variant(name, branchname, nameshort):
    print("Building " + name)
    subprocess.call(["git", "rebase", "master", branchname])
    build_release()
    rename_builds(nameshort)


def main():
    global projectpath
    global releasespath
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
    
    # build variants
    build_variant("No Medical", "master", "NoMed")
    build_variant("Medical", "medical", "Med")
    build_variant("Clientside", "clientside", "Clientside")
    
    # reset
    subprocess.call(["git", "checkout", "master"])
    sqfcpath = os.path.join(projectpath, "tools\\clean_sqfc.py")
    exec(open(sqfcpath).read())


if __name__ == "__main__":
    sys.exit(main())
