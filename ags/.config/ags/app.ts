import { App } from "astal/gtk3"
import style from "./scss/main.scss"
import SystemMenuWindow from "./widget/systemMenu/SystemMenuWindow";
// import Hyprland from "gi://AstalHyprland"

App.start({
  css: style,
  main() {
    // const hyprland = Hyprland.get_default()
    // const mainMonitor = hyprland.monitors.find((monitor) => monitor.id === 0)
    SystemMenuWindow()
  },
})
