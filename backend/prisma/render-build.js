const { spawnSync } = require('node:child_process');
const { existsSync, readFileSync } = require('node:fs');
const { resolve } = require('node:path');

const databaseName = 'ai_business_suite';

function readDatabaseUrlFromDotEnv() {
  const envPath = resolve(process.cwd(), '.env');
  if (!existsSync(envPath)) return undefined;

  const line = readFileSync(envPath, 'utf8')
    .split(/\r?\n/)
    .find((item) => item.trim().startsWith('DATABASE_URL='));
  if (!line) return undefined;

  return line.substring('DATABASE_URL='.length).trim();
}

function normalizeMongoUrl(url) {
  if (!url) return url;
  const trimmed = url.trim();
  const quote = trimmed.startsWith('"') || trimmed.startsWith("'") ? trimmed[0] : '';
  const unquoted = quote ? trimmed.slice(1, -1) : trimmed;

  if (!unquoted.startsWith('mongodb://') && !unquoted.startsWith('mongodb+srv://')) {
    return unquoted;
  }

  const [base, query] = unquoted.split('?', 2);
  const lastSegment = base.substring(base.lastIndexOf('/') + 1);
  if (lastSegment.trim().length > 0) return unquoted;

  return `${base.replace(/\/+$/, '')}/${databaseName}${query ? `?${query}` : ''}`;
}

function run(command, args, env) {
  console.log(`\n> ${command} ${args.join(' ')}`);
  const result = spawnSync(command, args, {
    env,
    shell: true,
    stdio: 'inherit',
  });

  if (result.status !== 0) {
    process.exit(result.status || 1);
  }
}

const sourceDatabaseUrl = process.env.DATABASE_URL || readDatabaseUrlFromDotEnv();
const normalizedDatabaseUrl = normalizeMongoUrl(sourceDatabaseUrl);
const env = {
  ...process.env,
  DATABASE_URL: normalizedDatabaseUrl,
};

if (!normalizedDatabaseUrl) {
  console.warn('DATABASE_URL is not set. Prisma db push will fail until it is configured.');
} else if (normalizedDatabaseUrl !== sourceDatabaseUrl) {
  console.log(`DATABASE_URL did not include a database name. Using /${databaseName} for Prisma build steps.`);
}

run('npx', ['prisma', 'generate'], env);
run('npx', ['prisma', 'db', 'push', '--skip-generate'], env);
run('npx', ['nest', 'build'], env);
