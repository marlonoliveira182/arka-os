---
name: recruit/recruit-gdpr
description: >
  GDPR/RGPD compliance operations for recruiting. Consent text generation,
  retention cleanup, candidate deletion, and compliance audit.
allowed-tools: [Read, Write, Edit, Bash, Grep, Glob, Agent, WebFetch, WebSearch]
---

# GDPR Compliance — `/recruit gdpr <action>`

> **Agent:** Lucia Ferreira (Recruiting Director)

## What It Does

Manages GDPR/RGPD compliance for the candidate database. Ensures all personal data handling meets European privacy regulations.

**Key Principle:** AI extracts and structures data. Humans always make hiring decisions (GDPR Art. 22).

## Actions

### `/recruit gdpr consent`

Generates consent text for career pages and application forms. Includes:
- Purpose of data collection
- AI processing disclosure (CV analysis, scoring)
- Data retention period (default: 12 months)
- Rights overview (access, rectification, erasure, portability)
- Contact information for data controller
- Third-party disclosure (if applicable)

### `/recruit gdpr cleanup`

Scans the candidate database for expired retention dates:
1. Lists candidates past `retention_until` date
2. Shows data that would be anonymized
3. Requires user confirmation before any action
4. Anonymizes approved records (removes PII, keeps anonymized stats)

### `/recruit gdpr delete <candidate>`

Right to erasure (Art. 17) for a specific candidate:
1. Locates candidate file in vault
2. Shows all data to be removed
3. Requires explicit user confirmation
4. Anonymizes the record (replaces PII with "[REDACTED]")
5. Logs the deletion for audit trail

### `/recruit gdpr audit`

Generates a compliance report:
1. **Total candidates** in database
2. **Consent status** — candidates with/without recorded consent
3. **Retention status** — active, approaching expiry (30 days), expired
4. **Processing log** — AI screening actions performed
5. **Recommendations** — compliance gaps to address

## Usage

```
/recruit gdpr consent — generate consent text for website
/recruit gdpr cleanup — scan for expired records
/recruit gdpr delete "João Silva" — erase candidate data
/recruit gdpr audit — full compliance report
```
