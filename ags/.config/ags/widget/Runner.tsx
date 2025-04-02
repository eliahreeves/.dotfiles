import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import { Variable, bind } from "astal";
import { exec } from "astal/process";
import { Entry } from "astal/gtk3/widget";
import Apps from "gi://AstalApps";

const MAX_ITEMS = 8;
function hide() {
  App.get_window("Runner")!.hide();
}
// function List(): Gtk.Widget {
//   return (
//     <box orientation={1} css="background-color: transparent; padding: 0px;">
//       {options((items) =>
//         items.map((item) => (
//           <button
//             onClicked={(self) => print(self, "was clicked")}
//             cursor={"pointer"}
//           >
//             {item.name}
//           </button>
//         )),
//       )}
//     </box>
//   );
// }
//
function AppButton({ app }: { app: Apps.Application }) {
  return (
    <button
      className="AppButton"
      onClicked={() => {
        hide();
        app.launch();
      }}
    >
      <box>
        <icon icon={app.iconName} />
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

export default function Runner(): Gtk.Widget {
  const { TOP } = Astal.WindowAnchor;
  const { CENTER } = Gtk.Align;
  const apps = new Apps.Apps();
  const text = Variable("");
  const width = Variable(1000);
  const list = text((text) => apps.fuzzy_query(text).slice(0, MAX_ITEMS));
  // const display = Gdk.Display.get_default();
  // const monitor = display!.get_primary_monitor();
  // const geometry = monitor!.get_geometry();
  // const screenHeight = geometry.height;

  // function inputHandler(self: Entry) {
  //   const arg: ScriptArg = { search: self.text };
  //   const argStr = JSON.stringify(arg);
  //   const res = JSON.parse(
  //     exec(["./scripts/script.py", argStr]),
  //   ) as ScriptReturn;
  //   options.set(res.options);
  // }
  const onEnter = () => {
    apps.fuzzy_query(text.get())?.[0].launch();
    hide();
  };
  return (
    <window
      name="Runner"
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM}
      exclusivity={Astal.Exclusivity.IGNORE}
      keymode={Astal.Keymode.ON_DEMAND}
      application={App}
      onShow={(self) => {
        text.set("");
        width.set(self.get_current_monitor().workarea.width);
      }}
      onKeyPressEvent={function (self, event: Gdk.Event) {
        if (event.get_keyval()[1] === Gdk.KEY_Escape) self.hide();
      }}
    >
      <box>
        <eventbox widthRequest={width((w) => w / 2)} expand onClick={hide} />
        <box hexpand={false} vertical>
          <eventbox heightRequest={100} onClick={hide} />
          <box widthRequest={500} className="Applauncher" vertical>
            <entry
              placeholderText="Search"
              text={text()}
              onChanged={(self) => text.set(self.text)}
              onActivate={onEnter}
            />
            <box spacing={6} vertical>
              {list.as((list) => list.map((app) => <AppButton app={app} />))}
            </box>
            <box
              halign={CENTER}
              className="not-found"
              vertical
              visible={list.as((l) => l.length === 0)}
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
  return (
    <window
      className="Runner"
      name="Runner"
      anchor={TOP}
      application={App}
      keymode={Astal.Keymode.ON_DEMAND}
      layer={Astal.Layer.TOP}
      exclusivity={Astal.Exclusivity.IGNORE}
      onKeyPressEvent={function (self, event: Gdk.Event) {
        if (event.get_keyval()[1] === Gdk.KEY_Escape) self.hide();
      }}
      onShow={(self) => {
        text.set("");
        print(text.get());
        width.set(self.get_current_monitor().workarea.width);
      }}
    >
      <box>
        <eventbox widthRequest={width((w) => w / 2)} expand onClick={hide} />
        <box hexpand={true} vertical>
          <eventbox heightRequest={100} onClick={hide} />
          <box>
            <label label=" " />
            <entry
              text={text()}
              width_chars={32}
              placeholder_text="Search..."
              onChanged={(self) => text.set(self.text)}
              onActivate={onEnter}
            />
          </box>
          <box spacing={6} vertical>
            {list.as((list) => list.map((app) => <AppButton app={app} />))}
          </box>
          <eventbox expand hexpand onClick={hide} />
        </box>
        <eventbox widthRequest={width((w) => w / 2)} expand onClick={hide} />
      </box>
    </window>
  );
}
