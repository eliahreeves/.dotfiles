
import { Gtk } from "astal/gtk3"
import AstalPowerProfiles from 'gi://AstalPowerProfiles?version=0.1';
import { bind } from 'astal';
import { isPrimaryClick } from "../utils/utils";
const powerProfilesService = AstalPowerProfiles.get_default();
type ProfileType = 'balanced' | 'power-saver' | 'performance';

function getBorderRadius(index: number): string {
  if (index == 0) {
    return "border-radius: 10px 0 0 10px;"
  } else if (index == 2) {
    return "border-radius: 0 10px 10px 0"
  }
  return "border-radius: 0;";
}

export default function () {
  const icons = {
    balanced: ' ',
    'power-saver': ' ',
    performance: '󱐋',
  }
  const powerProfiles = powerProfilesService.get_profiles();
  return (<box
    vertical={false}
    className="row"
    halign={Gtk.Align.CENTER}>
    {powerProfiles.map((powerProfile: AstalPowerProfiles.Profile, index: number) => {
      const profileType = powerProfile.profile as ProfileType;

      return (
        <button
          css={getBorderRadius(index)}
          className={bind(powerProfilesService, 'activeProfile').as(
            (active) => `power-profile-button ${profileType}${active === powerProfile.profile ? '-active' : ''}`,
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
