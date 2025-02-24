import { Astal, Gdk } from 'astal/gtk3';
export const isPrimaryClick = (event: Astal.ClickEvent): boolean => event.button === Gdk.BUTTON_PRIMARY;
