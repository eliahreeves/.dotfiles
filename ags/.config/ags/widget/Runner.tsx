import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import { Variable } from "astal";
import { exec, execAsync } from "astal/process";
import Apps from "gi://AstalApps";
import { Parser } from "./expr-eval";

const MAX_ITEMS = 8;
type BasicFile = { name: string; path: string };
type Item = {
	name: string;
	description?: string;
	iconName?: string;
	launch: () => void;
};

function hide() {
	App.get_window("Runner")!.hide();
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

function evaluateExpression(input: string): number | null {
	try {
		const res = Parser.evaluate(input);
		return res != null && typeof res === "number" && !isNaN(res) ? res : null;
	} catch {
		return null;
	}
}

function buildList(
	search: string,
	apps: Apps.Apps,
	files: BasicFile[],
): Item[] {
	const math_res = evaluateExpression(search);
	const math_res_good = math_res != null;
	const apps_list: Item[] = apps
		.fuzzy_query(search)
		.slice(0, math_res_good ? MAX_ITEMS - 1 : MAX_ITEMS);
	const math_res_str = math_res_good ? `${math_res}` : "";
	const apps_calc_list = math_res_good
		? [
			{
				name: math_res_str,
				description: "Copy to Clipboard",
				launch: () => {
					Gtk.Clipboard.get_default(Gdk.Display.get_default()!)!.set_text(
						math_res_str,
						math_res_str.length,
					);
				},
				iconName: "accessories-calculator",
			},
			...apps_list,
		]
		: apps_list;
	if (apps_calc_list.length >= MAX_ITEMS) {
		return apps_calc_list;
	}

	const file_list = files
		.filter((file) => file.name.includes(search))
		.slice(0, MAX_ITEMS - apps_calc_list.length)
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

	const files_and_apps = [...apps_calc_list, ...file_list];

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
					"brave",
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
	const files = Variable<BasicFile[]>([]);
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
				// execAsync('bash -c "fd -i . $HOME"').then((out) => {
				//   files.set(
				//     out
				//       .trim()
				//       .split("\n")
				//       .map((path) => {
				//         const parts = path.split("/").filter(Boolean);
				//         return { path: path, name: parts[parts.length - 1] ?? "" };
				//       }),
				//   );
				// });
				width.set(self.get_current_monitor().workarea.width);
			}}
			onKeyPressEvent={function (self, event: Gdk.Event) {
				if (event.get_keyval()[1] === Gdk.KEY_Escape) {
					self.hide();
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
	runnerWindow.connect("hide", () => {
		text.set("");
		files.set([]);
	});
	return runnerWindow;
}
