// tools/rules.js on a window of a tools/layout.json, as the editor runs it, with
// the parts where the scan saw them: each problem on a line, each tab's.
//   node tests/rules_run.js layout.json WindowName
const fs = require("fs");
const source = fs.readFileSync(__dirname + "/../tools/rules.js", "utf8").replace(".pragma library", "");
const check = new Function(source + "; return check;")();
const layout = JSON.parse(fs.readFileSync(process.argv[2], "utf8"));
const window = layout.windows[process.argv[3]];
for (const view of (window && window.views) || []) {
	const f = view.rect, top = f[1] + f[3], parts = {};
	for (const [name, part] of Object.entries(window.parts)) {
		const seen = !part.tabs || part.tabs.includes(view.key);
		if (part.rect && seen) {
			const r = part.rect, left = r[0] - f[0], y = top - (r[1] + r[3]);
			parts[name] = Object.assign({}, part, { left, top: y, right: left + r[2], bottom: y + r[3] });
		}
	}
	for (const problem of check({ parts, view, rules: layout.rules, unit: parseFloat(layout.unit), origin: [f[0], top] }))
		console.log(problem.text);
}
