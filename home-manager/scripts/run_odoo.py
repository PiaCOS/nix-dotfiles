#!/usr/bin/python3

import argparse
import subprocess
import sys
import time

addons = "addons/,../enterprise/"
dev = "all"
port = 8869
db = "default_db"
to_install = None
to_update = None
to_test = None
need_help = None

parser = argparse.ArgumentParser(description="odoo tooling")

parser.add_argument("--addons", action="store", dest="addons", default=addons)
parser.add_argument("--dev", action="store", dest="dev", default=dev)
parser.add_argument("--port", action="store", dest="port", default=port)
parser.add_argument("-d", action="store", dest="db", default=db)
parser.add_argument("-i", action="store", dest="to_install", default=to_install)
parser.add_argument("-u", action="store", dest="to_update", default=to_update)
parser.add_argument("--test", action="store", dest="to_test", default=to_test)
parser.add_argument("--need_help", action=argparse.BooleanOptionalAction, dest="need_help")

args = parser.parse_args()


def main():
    if not args.need_help:
        command = f"/usr/bin/python3 ./odoo-bin --addons-path={args.addons} --dev={args.dev} --http-port={args.port} -d {args.db}"
        if args.to_install:
            command += f" -i {args.to_install}"
        if args.to_update:
            command += f" -u {args.to_update}"
        if args.to_test:
            command += f" --test-tag {args.to_test}"

        proc = subprocess.Popen(command.split(), cwd="/home/odoo/Dev/odoo/community")
        proc.wait()
    else:
        print(
            """
            COMMANDS:
                 --addons "addons/,../enterprise"
                 --dev all
                 --port 8869
                 -d default_db
                 -i 'marketing_automation,sign' <-- default = None
                 -u 'marketing_automation,sign' <-- default = None
                 --test [/module][:class][.method] <-- default = None
            """
        )

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
       time.sleep(1)
       print("-- KeyboardInterrupt --")
       sys.exit(0)
