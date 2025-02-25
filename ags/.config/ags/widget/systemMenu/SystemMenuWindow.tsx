import { App, Astal } from "astal/gtk3";
// import Wp from "gi://AstalWp";
import { Gtk, Gdk } from "astal/gtk3";
import PowerProfiles from "./PowerProfiles";
import BluetoothMenu from "./BluetoothMenu";
export const SystemMenuWindowName = "systemMenuWindow";

export default function () {
  // const { audio } = Wp.get_default()!;

  let window: Gtk.Window;

  return (
    <window
      exclusivity={Astal.Exclusivity.NORMAL}
      anchor={
        Astal.WindowAnchor.TOP |
        Astal.WindowAnchor.RIGHT |
        Astal.WindowAnchor.BOTTOM
      }
      layer={Astal.Layer.TOP}
      css={`
        background: transparent;
      `}
      name={SystemMenuWindowName}
      application={App}
      margin={8}
      keymode={Astal.Keymode.ON_DEMAND}
      visible={false}
      onKeyPressEvent={function (self, event: Gdk.Event) {
        if (event.get_keyval()[1] === Gdk.KEY_Escape) {
          self.hide();
        }
      }}
      setup={(self) => {
        window = self;
      }}
    >
      <box vertical={true}>
        <box vertical={true} className="window">
          <scrollable
            className="scrollWindow"
            vscroll={Gtk.PolicyType.AUTOMATIC}
            propagateNaturalHeight={true}
            widthRequest={400}
          >
            <box vertical={true}>
              <box css={"margin-top: 15px;"} />
              <BluetoothMenu />
              <box css={"margin-top: 15px;"} />
              <PowerProfiles />
              <box css={"margin-top: 15px;"} />
            </box>
          </scrollable>
        </box>
        <box vexpand={true} />
      </box>
    </window>
  );
}
