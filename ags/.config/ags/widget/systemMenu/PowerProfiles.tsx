
import { Gtk } from "astal/gtk3"
import AstalPowerProfiles from 'gi://AstalPowerProfiles?version=0.1';
import { bind } from 'astal';
import { isPrimaryClick } from "../utils/utils";
const powerProfilesService = AstalPowerProfiles.get_default();
type ProfileType = 'balanced' | 'power-saver' | 'performance';
export default function () {
  const icons = {
    balanced: '',
    'power-saver': '',
    performance: '󱐋',
  }
  const powerProfiles = powerProfilesService.get_profiles();
  return (<box
    vertical={false}
    className="row"
    halign={Gtk.Align.CENTER}>
    {powerProfiles.map((powerProfile: AstalPowerProfiles.Profile) => {
      const profileType = powerProfile.profile as ProfileType;

      return (
        <button
          className={bind(powerProfilesService, 'activeProfile').as(
            (active) => `${profileType} power-profile-item ${active === powerProfile.profile ? 'active' : ''}`,
          )}
          onClick={(_, event) => {
            if (isPrimaryClick(event)) {
              powerProfilesService.activeProfile = powerProfile.profile;
            }
          }}
        >
          {icons[profileType] || icons.balanced}
        </button>
      );
    })}
  </box>)
}

// V<button
//     className="systemMenuIconButton"
//     label=""
//     // setup={(self) => self.hook(powerprofiles.get_active_profile(), ()=>)}
//     onClicked={() => {
//       execAsync("uwsm stop")
//       powerprofiles.set_active_profile("balanced")
//     }} />
//   <button
//     className="systemMenuIconButton"
//     label=""
//     onClicked={() => {
//       powerprofiles.set_active_profile("balanced")
//     }} />
//   <button
//     className="systemMenuIconButton"
//     label="󱐋"
//     onClicked={() => {
//       powerprofiles.set_active_profile("performance")
//
//     }} />
//
