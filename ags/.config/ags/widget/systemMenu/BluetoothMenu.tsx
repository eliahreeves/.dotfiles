import { Gtk, App } from "astal/gtk3";
import AstalBluetooth from "gi://AstalBluetooth?version=0.1";
import { bind, Variable } from "astal";
import { isPrimaryClick } from "../utils/utils";
import { SystemMenuWindowName } from "./SystemMenuWindow";
import {
  getAvailableBluetoothDevices,
  getConnectedBluetoothDevices,
} from "../utils/bluetooth";
const bluetoothService = AstalBluetooth.get_default();

export default (): JSX.Element => {
  return (
    <box className={"menu-items bluetooth"} halign={Gtk.Align.FILL}>
      <DropDown />
    </box>
  );
};

function DropDown(): JSX.Element {
  const bluetoothChooserRevealed = Variable(false);

  setTimeout(() => {
    bind(App.get_window(SystemMenuWindowName)!, "visible").subscribe(
      (visible) => {
        if (!visible) {
          bluetoothChooserRevealed.set(false);
        }
      },
    );
  }, 1_000);

  return (
    <box vertical={true}>
      <box vertical={false} className="row">
        {/* <label className="systemMenuIconButton" label={"testdsf"} /> */}
        {/* <label */}
        {/*   className="labelMediumBold" */}
        {/*   halign={Gtk.Align.START} */}
        {/*   hexpand={true} */}
        {/*   label={"testkldasnkd"} */}
        {/* /> */}
        <button
          hexpand={true}
          className="icon-button"
          label={bind(bluetoothService, "isPowered").as((isEnabled) =>
            isEnabled ? "Fake Device (+1)" : "Bluetooth Disabled",
          )}
          onClicked={() => {
            bluetoothChooserRevealed.set(!bluetoothChooserRevealed.get());
          }}
        />
        <button
          className={bind(bluetoothService, "isPowered").as(
            (isEnabled) =>
              `icon-button bluetooth ${!isEnabled ? "disabled" : ""}`,
          )}
          onClick={(_, event) => {
            if (isPrimaryClick(event)) {
              bluetoothService.toggle();
            }
          }}
          tooltipText={"Toggle Bluetooth"}
        >
          <label
            label={bind(bluetoothService, "isPowered").as((isEnabled) =>
              isEnabled ? "󰂯" : "󰂲",
            )}
          />
        </button>
      </box>
      <revealer
        className="rowRevealer"
        revealChild={bluetoothChooserRevealed()}
        transitionDuration={200}
        transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
      >
        <DeviceList />
      </revealer>
    </box>
  );
}

function DeviceList(): JSX.Element {
  const deviceListBinding = Variable.derive(
    [bind(bluetoothService, "devices"), bind(bluetoothService, "isPowered")],
    () => {
      const availableDevices = getAvailableBluetoothDevices();
      const connectedDevices = getConnectedBluetoothDevices();

      if (availableDevices.length === 0) {
        return <box>No Devices</box>;
      }

      if (!bluetoothService.adapter?.powered) {
        return <box>Bluetooth Disabled</box>;
      }
      print(connectedDevices.length);
      return availableDevices.map((btDevice) => {
        return (
          <label
            valign={Gtk.Align.CENTER}
            halign={Gtk.Align.START}
            className=""
            truncate
            wrap
            label={bind(btDevice, "alias")}
          />
        );
      });
    },
  );
  return (
    <box
      className={"menu-items-section"}
      onDestroy={() => {
        deviceListBinding.drop();
      }}
    >
      <box className={"menu-content"} vertical>
        {deviceListBinding()}
      </box>
    </box>
  );
}
