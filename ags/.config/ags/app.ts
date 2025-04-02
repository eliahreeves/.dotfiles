import { App } from "astal/gtk3";
import style from "./style.scss";
import Runner from "./widget/Runner";

App.start({
  css: style,
  main() {
    // App.get_monitors().map(Menu);
    Runner();
  },
});
