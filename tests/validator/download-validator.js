const https = require('https');
const fs = require('fs');
const path = require('path');

const VALIDATOR_URL = 'https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar';
const OUTPUT_PATH = path.join(__dirname, 'validator_cli.jar');

if (fs.existsSync(OUTPUT_PATH)) {
  console.log('FHIR Validator CLI already downloaded.');
  process.exit(0);
}

console.log('Downloading FHIR Validator CLI...');

function download(url, dest) {
  return new Promise((resolve, reject) => {
    const file = fs.createWriteStream(dest);
    https.get(url, (response) => {
      if (response.statusCode === 302 || response.statusCode === 301) {
        download(response.headers.location, dest).then(resolve).catch(reject);
        return;
      }
      response.pipe(file);
      file.on('finish', () => { file.close(); resolve(); });
    }).on('error', (err) => {
      fs.unlink(dest, () => {});
      reject(err);
    });
  });
}

download(VALIDATOR_URL, OUTPUT_PATH)
  .then(() => console.log('Downloaded validator_cli.jar'))
  .catch((err) => { console.error('Download failed:', err.message); process.exit(1); });
