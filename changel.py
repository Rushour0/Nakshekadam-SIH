import os
replacement = """final List<double> tempDimensions = [MediaQuery.of(context).size.width,MediaQuery.of(context).size.height];
    final double screenHeight = tempDimensions[0] > tempDimensions[1] ? tempDimensions[0] : tempDimensions[1];
    final double screenWidth = tempDimensions[0] > tempDimensions[1] ? tempDimensions[1] : tempDimensions[0];"""
for dname, dirs, files in os.walk("./lib"):
    for fname in files:
        fpath = os.path.join(dname, fname)
        print(fpath)
        with open(fpath,"r") as f:
            s = f.read()
        s = s.replace("""double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;""", replacement)
        with open(fpath, "w") as f:
            f.write(s)