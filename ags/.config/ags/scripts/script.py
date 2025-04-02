#!/bin/python3
import sys
import json
import subprocess


def get_filtered_apps(search_term):
    try:
        # Pipe fd output into rg
        cmd = "fd '\\.desktop$' /usr/share/applications ~/.local/share/applications"
        result = subprocess.run(
            cmd, shell=True, stdout=subprocess.PIPE, text=True, check=True
        )

        desktop_files = result.stdout.strip().split("\n")
        apps = []
        for file in desktop_files:
            name = None
            exec_path = None
            icon = None
            with open(file, "r", encoding="utf-8") as file:
                for line in file:
                    line = line.strip()
                    if line.startswith("Name=") and not name:
                        name = line.split("=", 1)[1]
                    elif line.startswith("Exec=") and not exec_path:
                        exec_path = line.split("=", 1)[1]
                    elif line.startswith("Icon=") and not icon:
                        icon = line.split("=", 1)[1]
            if name and exec_path and name.lower().startswith(search_term.lower()):
                apps.append(
                    {
                        "name": name,
                        "exec": exec_path,
                        "strIcon": icon is None,
                        "icon": icon if icon else "󰣆 ",
                    }
                )
        return apps

    except subprocess.CalledProcessError:
        return []


def main():
    json_arg = json.loads(sys.argv[1])
    search = json_arg["search"] if json_arg["search"] is not None else ""

    results = get_filtered_apps(search)
    data = {"options": results, "close": False}
    print(json.dumps(data))


if __name__ == "__main__":
    main()
