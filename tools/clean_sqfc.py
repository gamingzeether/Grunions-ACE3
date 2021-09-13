#!/usr/bin/env python3

import os
import os.path

def main():
    module_root_parent = "P:\\z\\ace"
    
    for root, _dirs, files in os.walk(module_root_parent):
        for file in files:
            if file.endswith(".sqfc"):
                os.remove(os.path.join(root, file))

if __name__ == "__main__":
    main()
