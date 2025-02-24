import { App, Astal } from "astal/gtk3"
// import EndpointControls from "./EndpointControls";
import Wp from "gi://AstalWp"
import { bind } from "astal"
import { Gtk, Gdk } from "astal/gtk3"
// import { getMicrophoneIcon, getVolumeIcon } from "../utils/audio";
import PowerOptions from "./PowerOptions";
import PowerProfiles from "./PowerProfiles";
// import ThemeOptions from "./ThemeOptions";
// import MediaPlayers from "./MediaPlayers";
// import NotificationHistory from "./NotificationHistory";
import NetworkControls from "./NetworkControls";
import BluetoothControls from "./BluetoothControls";
import Divider from "../common/Divider";

export const SystemMenuWindowName = "systemMenuWindow"

export default function () {
  const { audio } = Wp.get_default()!

  let window: Gtk.Window

  return <window
    exclusivity={Astal.Exclusivity.NORMAL}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT | Astal.WindowAnchor.BOTTOM}
    layer={Astal.Layer.TOP}
    css={`background: transparent;`}
    name={SystemMenuWindowName}
    application={App}
    margin={5}
    keymode={Astal.Keymode.ON_DEMAND}
    visible={false}
    onKeyPressEvent={function (self, event: Gdk.Event) {
      if (event.get_keyval()[1] === Gdk.KEY_Escape) {
        self.hide()
      }
    }}
    setup={(self) => {
      window = self
    }}>
    <box
      vertical={true}>
      <box
        vertical={true}
        setup={(self) => {
          setTimeout(() => {
            bind(window, "hasToplevelFocus").subscribe((hasFocus) => {
              if (hasFocus) {
                self.className = "focusedWindow"
              } else {
                self.className = "window"
              }
            })
          }, 1_000)
        }}>
        <scrollable
          className="scrollWindow"
          vscroll={Gtk.PolicyType.AUTOMATIC}
          propagateNaturalHeight={true}
          widthRequest={400}>
          <box
            vertical={true}>
            <box css={"margin-top: 15px;"} />
            <NetworkControls />
            <BluetoothControls />
            {/* <EndpointControls */}
            {/*   defaultEndpoint={audio.default_speaker} */}
            {/*   endpointsBinding={bind(audio, "speakers")} */}
            {/*   getIcon={getVolumeIcon} /> */}
            {/* <EndpointControls */}
            {/*   defaultEndpoint={audio.default_microphone} */}
            {/*   endpointsBinding={bind(audio, "microphones")} */}
            {/*   getIcon={getMicrophoneIcon} /> */}
            <box css={"margin-top: 20px;"} />
            <PowerProfiles />
            <box css={"margin-top: 20px;"} />
            <PowerOptions />
            <box css={"margin-top: 15px;"} />
            {/* <NotificationHistory /> */}
          </box>
        </scrollable>
      </box>
      <box
        vexpand={true} />
    </box>
  </window>
}
