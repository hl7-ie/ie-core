import fs from 'node:fs';
import path from 'node:path';

const siteRoot = path.resolve(process.argv[2] ?? 'site');
const repoName = path.basename(process.cwd());

const deployments = [
  { artifactDir: siteRoot, fallbackPage: 'index.html' },
  { artifactDir: path.join(siteRoot, 'R5'), fallbackPage: path.join('R5', 'index.html') }
].filter(({ artifactDir }) => fs.existsSync(artifactDir));

const createdRedirects = new Set();

function readResource(filePath) {
  try {
    return JSON.parse(fs.readFileSync(filePath, 'utf8'));
  } catch {
    return null;
  }
}

function toSiteRelative(filePath) {
  return path.relative(siteRoot, filePath);
}

function toPosix(filePath) {
  return filePath.split(path.sep).join('/');
}

function toPublishedPath(relativeUrlPath) {
  const trimmedPath = relativeUrlPath.replace(/^\/+/, '');
  if (trimmedPath === repoName) {
    return '';
  }
  if (trimmedPath.startsWith(`${repoName}/`)) {
    return trimmedPath.slice(repoName.length + 1);
  }
  return trimmedPath;
}

function createRedirect(redirectDir, targetPath, canonicalUrl) {
  const redirectFile = path.join(redirectDir, 'index.html');
  const relativeTarget = toPosix(path.relative(redirectDir, targetPath)) || 'index.html';

  fs.mkdirSync(redirectDir, { recursive: true });
  fs.writeFileSync(
    redirectFile,
    `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Redirecting...</title>
  <meta http-equiv="refresh" content="0; url=${relativeTarget}">
  <link rel="canonical" href="${canonicalUrl}">
</head>
<body>
  <p>Redirecting to <a href="${relativeTarget}">${relativeTarget}</a>.</p>
</body>
</html>
`
  );

  createdRedirects.add(toSiteRelative(redirectFile));
}

function resolveTarget(resource, artifactDir, fallbackPage) {
  if (resource.resourceType === 'ImplementationGuide') {
    const fallbackPath = path.join(siteRoot, fallbackPage);
    return fs.existsSync(fallbackPath) ? fallbackPath : null;
  }

  const stem = `${resource.resourceType}-${resource.id}`;
  const candidates = [
    `${stem}.html`,
    `${stem}.json.html`,
    `${stem}.json`
  ];

  for (const candidate of candidates) {
    const candidatePath = path.join(artifactDir, candidate);
    if (fs.existsSync(candidatePath)) {
      return candidatePath;
    }
  }

  const fallbackPath = path.join(siteRoot, fallbackPage);
  return fs.existsSync(fallbackPath) ? fallbackPath : null;
}

for (const { artifactDir, fallbackPage } of deployments) {
  const jsonFiles = fs
    .readdirSync(artifactDir)
    .filter((fileName) => fileName.endsWith('.json'))
    .sort();

  for (const jsonFile of jsonFiles) {
    const resource = readResource(path.join(artifactDir, jsonFile));
    if (!resource?.resourceType || !resource?.id || !resource?.url) {
      continue;
    }

    const targetPath = resolveTarget(resource, artifactDir, fallbackPage);
    if (!targetPath) {
      continue;
    }

    const canonicalUrl = new URL(resource.url);
    const redirectDir = path.join(siteRoot, toPublishedPath(canonicalUrl.pathname));
    createRedirect(redirectDir, targetPath, canonicalUrl.href);

    if (resource.resourceType === 'ImplementationGuide') {
      const basePath = path.posix.dirname(path.posix.dirname(canonicalUrl.pathname));
      const baseDir = path.join(siteRoot, toPublishedPath(basePath));
      createRedirect(baseDir, path.join(siteRoot, fallbackPage), `${canonicalUrl.origin}${basePath}`);
    }
  }
}

console.log(`Created ${createdRedirects.size} canonical redirect pages under ${siteRoot}`);
