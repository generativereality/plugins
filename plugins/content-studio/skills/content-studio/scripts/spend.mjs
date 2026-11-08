#!/usr/bin/env node
// Per-piece spend ledger (references/costs-and-licences.md). No dependencies.
//   node spend.mjs add <dir> --model M --usd 0.05 [--seconds 23] [--out file] [--note "..."] [--local]
//   node spend.mjs total <dir> [--budget 5]      exit 3 when over budget
import { appendFileSync, existsSync, readFileSync } from 'node:fs';
import { join } from 'node:path';

const [cmd, dir, ...rest] = process.argv.slice(2);
const opt = {};
for (let i = 0; i < rest.length; i++) {
  const k = rest[i].replace(/^--/, '');
  if (rest[i + 1] !== undefined && !rest[i + 1].startsWith('--')) opt[k] = rest[++i];
  else opt[k] = true;
}
if (!cmd || !dir) { console.error('usage: spend.mjs add|total <dir> [...]'); process.exit(2); }
const file = join(dir, 'spend.jsonl');

if (cmd === 'add') {
  if (!opt.model || opt.usd === undefined) { console.error('add needs --model and --usd'); process.exit(2); }
  const row = {
    at: new Date().toISOString(), model: opt.model, usd: Number(opt.usd),
    seconds: opt.seconds ? Number(opt.seconds) : null, out: opt.out || null,
    note: opt.note || null, local: !!opt.local,
  };
  if (Number.isNaN(row.usd)) { console.error('--usd must be a number'); process.exit(2); }
  appendFileSync(file, JSON.stringify(row) + '\n');
  console.log(JSON.stringify(row));
} else if (cmd === 'total') {
  const rows = existsSync(file)
    ? readFileSync(file, 'utf8').split('\n').filter(Boolean).map((l) => JSON.parse(l)) : [];
  const by = {}; let usd = 0; let secs = 0;
  for (const r of rows) {
    usd += r.usd; secs += r.seconds || 0;
    by[r.model] ??= { calls: 0, usd: 0 };
    by[r.model].calls++; by[r.model].usd += r.usd;
  }
  for (const [m, v] of Object.entries(by)) console.log(`${m}\t${v.calls} calls\t$${v.usd.toFixed(3)}`);
  console.log(`TOTAL\t${rows.length} calls\t$${usd.toFixed(3)}\t${Math.round(secs)} s`);
  if (opt.budget !== undefined) {
    const b = Number(opt.budget);
    if (usd > b) { console.log(`OVER BUDGET by $${(usd - b).toFixed(3)}: stop and say so`); process.exit(3); }
    console.log(`within budget ($${(b - usd).toFixed(3)} left)`);
  }
} else { console.error(`unknown command ${cmd}`); process.exit(2); }
