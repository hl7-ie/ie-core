# Keycloak 26 – NePS Realm Setup

This directory contains the Keycloak 26 realm configuration for the **National Electronic Prescription Service (NePS)**.

## Files

| File | Purpose |
|------|---------|
| `neps-realm.json` | Keycloak 26-compatible realm export for the `neps` realm |

## Quick Start

From the repository root, run:

```bash
docker compose up -d
```

Keycloak will start on **http://localhost:8080** and automatically import the `neps` realm.

> The HAPI FHIR server starts on **http://localhost:8090/fhir** once Keycloak is healthy.

### Admin Console

- URL: http://localhost:8080/admin/master/console/
- Username: `admin`
- Password: `admin`  *(change this immediately)*

After logging in you will be prompted to change the temporary password. You can then navigate to the `neps` realm.

## Realm Contents

### Roles

| Role | Description |
|------|-------------|
| `neps-admin` | System administrator |
| `prescriber` | GP / nurse prescriber |
| `dispenser` | Dispensing pharmacist |
| `pharmacist` | Registered pharmacist |
| `patient` | Patient / service user |
| `clinical-auditor` | Read-only audit access |

### SMART on FHIR Clients

| Client ID | Type | Purpose |
|-----------|------|---------|
| `neps-prescriber-app` | Public (PKCE) | GP / prescriber SPA |
| `neps-dispenser-app` | Public (PKCE) | Pharmacy SPA |
| `neps-patient-portal` | Public (PKCE) | Patient-facing portal |
| `neps-backend-service` | Confidential | Machine-to-machine (client_credentials) |
| `neps-fhir-server` | Bearer-only | Resource server |

### Test Users

All test users have the temporary password `ChangeMe123!` — you will be prompted to set a permanent password on first login.

| Username | Role | FHIR Resource |
|----------|------|---------------|
| `neps-admin` | neps-admin | — |
| `dr-test-prescriber` | prescriber | `Practitioner/practitioner-test-001` |
| `test-dispenser` | dispenser, pharmacist | `Practitioner/practitioner-test-002` |
| `test-patient` | patient | `Patient/patient-test-001` |

## Importing the Realm Manually

If you need to import the realm through the Admin Console:

1. Go to **http://localhost:8080/admin/master/console/**
2. Click **Keycloak** (top-left) → **Create realm**
3. Click **Browse…** and select `keycloak/neps-realm.json`
4. Confirm the **Realm name** is `neps` and click **Create**

### Compatibility Notes (Keycloak 26)

The `neps-realm.json` is written for **Keycloak 26.x** and intentionally omits fields that were removed or changed in recent versions:

- No `requiredCredentials` (removed in Keycloak 20+)
- No top-level `id` UUID (Keycloak 21+ ignores or rejects mismatched IDs)
- No legacy authenticator flow references that no longer exist
- Uses `start-dev --import-realm` for automatic import

## Production Hardening

Before deploying to production:

1. Replace `KC_DB: dev-file` with a PostgreSQL connection in `docker-compose.yml`
2. Set `KC_HOSTNAME` and `KC_HOSTNAME_STRICT: "true"`
3. Enable TLS (`KC_HTTPS_*` variables or a reverse proxy)
4. Rotate all client secrets in the Admin Console
5. Remove or disable the test users
6. Set `KC_HOSTNAME_STRICT_HTTPS: "true"` and `sslRequired: "all"` in the realm
