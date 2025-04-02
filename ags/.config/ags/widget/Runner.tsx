import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import { Variable } from "astal";
import { exec, execAsync } from "astal/process";
import Apps from "gi://AstalApps";

const MAX_ITEMS = 8;
const files = Variable<BasicFile[]>([]);
type BasicFile = { name: string; path: string };
type Item = {
  name: string;
  description?: string;
  iconName?: string;
  launch: () => void;
};

function hide() {
  App.get_window("Runner")!.hide();
  files.set([]);
}

function AppButton({ app }: { app: Item }) {
  return (
    <button
      className="AppButton"
      onClicked={() => {
        hide();
        app.launch();
      }}
    >
      <box>
        <icon icon={app.iconName ?? "applications-system"} />
        <box valign={Gtk.Align.CENTER} vertical>
          <label className="name" truncate xalign={0} label={app.name} />
          {app.description && (
            <label
              className="description"
              wrap
              xalign={0}
              label={app.description}
            />
          )}
        </box>
      </box>
    </button>
  );
}

function getDisplayPath(path: string): string {
  const split_path = path.split("/").filter(Boolean).slice(2, -1);
  const shortened_path = split_path.map((value, index) => {
    if (index >= split_path.length - 2) {
      return value;
    }
    return value.charAt(0);
  });

  return `${["~", ...shortened_path].join("/")}/`;
}

function buildList(
  search: string,
  apps: Apps.Apps,
  files: BasicFile[],
): Item[] {
  const apps_list = apps.fuzzy_query(search).slice(0, MAX_ITEMS);
  if (apps_list.length >= MAX_ITEMS) {
    return apps_list;
  }

  const file_list = files
    .filter((file) => file.name.includes(search))
    .slice(0, MAX_ITEMS - apps_list.length)
    .map((file) => {
      return {
        iconName: file.path.endsWith("/") ? "folder" : "text-x-generic",
        name: file.name,
        description: getDisplayPath(file.path),
        launch: () => {
          exec(["systemd-run", "--user", "xdg-open", file.path]);
        },
      };
    });

  // const file_list: Item[] = exec()
  //   .split("\n")
  //   .slice(0, -1)
  //   .slice(0, MAX_ITEMS - apps_list.length)
  //   .map((path) => {
  //     const split_path = path.replace(/^\/|\/$/g, "").split("/");
  //     print(split_path);
  //     return {
  //       iconName: path.endsWith("/") ? "folder" : "text-x-generic",
  //       name: split_path.slice(-1)[0],
  //       description: path,
  //       launch: () => {
  //         exec(["systemd-run", "--user", "xdg-open", path]);
  //       },
  //     };
  //   });

  const files_and_apps = [...apps_list, ...file_list];

  if (files_and_apps.length >= MAX_ITEMS) {
    return files_and_apps;
  }

  return [
    ...files_and_apps,
    {
      name: `Search: ${search}`,
      launch: () => {
        exec([
          "systemd-run",
          "--user",
          "xdg-open",
          `https://www.google.com/search?q=${encodeURIComponent(search)}`,
        ]);
      },
      description: "Search with Google",
      iconName: "system-search",
    },
  ];
}

export default function Runner(): Gtk.Widget {
  const { CENTER } = Gtk.Align;
  const apps = new Apps.Apps();
  const text = Variable("");
  const width = Variable(1000);
  const list = Variable.derive([text, files], (text, files) =>
    buildList(text, apps, files),
  );
  const onEnter = () => {
    list.get()[0]?.launch();
    hide();
  };
  const runnerWindow = (
    <window
      name="Runner"
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM}
      exclusivity={Astal.Exclusivity.IGNORE}
      keymode={Astal.Keymode.ON_DEMAND}
      application={App}
      visible={false}
      onShow={(self) => {
        execAsync('bash -c "fd -i . $HOME"').then((out) => {
          files.set(
            out
              .trim()
              .split("\n")
              .map((path) => {
                const parts = path.split("/").filter(Boolean);
                return { path: path, name: parts[parts.length - 1] ?? "" };
              }),
          );
        });
        text.set("");
        width.set(self.get_current_monitor().workarea.width);
      }}
      onKeyPressEvent={function (self, event: Gdk.Event) {
        if (event.get_keyval()[1] === Gdk.KEY_Escape) {
          self.hide();
          files.set([]);
        }
      }}
    >
      <box>
        <eventbox widthRequest={width((w) => w / 2)} expand onClick={hide} />
        <box hexpand={false} vertical>
          <eventbox heightRequest={100} onClick={hide} />
          <box widthRequest={500} className="Applauncher" vertical>
            <box className="search">
              <icon icon="system-search-symbolic" />
              <entry
                hexpand
                placeholderText="Search"
                text={text()}
                onChanged={(self) => text.set(self.text)}
                onActivate={onEnter}
              />
            </box>
            <box spacing={6} vertical>
              {list((list) => list.map((app) => <AppButton app={app} />))}
            </box>
            <box
              halign={CENTER}
              className="not-found"
              vertical
              visible={list((l) => l.length === 0)}
            >
              <icon icon="system-search-symbolic" />
              <label label="No match found" />
            </box>
          </box>
          <eventbox expand onClick={hide} />
        </box>
        <eventbox widthRequest={width((w) => w / 2)} expand onClick={hide} />
      </box>
    </window>
  );
  return runnerWindow;
}
