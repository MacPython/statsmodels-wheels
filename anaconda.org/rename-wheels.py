import os
import argparse
import glob
import datetime
import logging

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Rename wheels')
    parser.add_argument('--directory', '-d', type=str,
                        help='The directory containing the wheel(s)')
    args = parser.parse_args()
    directory = args.directory

    if not bool(directory):
        raise ValueError("directory is required")
    directory = os.path.abspath(directory)
    files = glob.glob(os.path.join(directory, "*.whl"))
    if not files:
        raise RuntimeError("No wheel files detected")
    fmt = "%Y%m%d%H%M%S"
    time = datetime.datetime.now().strftime(fmt)
    logging.basicConfig(level=logging.INFO)
    for f in files:
        base, fname = os.path.split(f)
        repl = fname
        if "+" in fname:
            start, end = fname.split("+")
            repl = "+".join((start, f"{time}_{end}"))
            target = os.path.join(base, repl)
            print(f"Renaming {f} to {target}")
            try:
                os.rename(f, target)
            except Exception as exc:
                print(str(exc))
        else:
            print(f"Not renaming {f}")
