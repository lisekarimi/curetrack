# 🗓️ Curetrack - Automates medication tracking and reminders

Curetrack is an automation tool that adds **medication reminders** (start date, end date, next cure, dose switch, expiration, low stock) to Google Calendar and keeps a complete **treatment history** in Notion - so patients never miss an event and history stays traceable.

<img src="https://github.com/lisekarimi/curetrack/blob/main/assets/calendar_alert.png?raw=true" width="400"/>

## 🎥 Demo

Check out the live Notion template: [Treatment Tracker Demo](https://www.notion.so/lisekarimi/Treatment-Tracker-26da61e34bdf80d6addde1fcf15f14a7)


## ✨ Features

* Automates reminders for all medication events: **start date, end date, next cure date, expiration date, switch dose date, and low stock alert**.
* Prevents duplicate alerts with Postgres.
* Keeps treatment history organized in Notion.
* Google Calendar integration ensures real-time reminders.
* Daily scheduled runs keep everything up to date.


## 🔑 Prerequisites

* **Docker Desktop** → [Download here](https://www.docker.com/products/docker-desktop/)
* **WSL (Windows Subsystem for Linux)**
* **Notion** → Create an integration at [Notion Integrations](https://www.notion.so/profile/integrations)
  * Share database access: `Database → ••• → Connections → Add your integration`
* **Google Calendar** → Create OAuth credentials in [Google Cloud Console](https://console.cloud.google.com/)
  * Redirect URL: `http://localhost:5678/rest/oauth2-credential/callback`
* **Postgres connection (inside n8n)**:
  * Host: `curetrack-db`
  * Database: `curetrack`
  * User: `curetrack`
  * Password: from `.env`
* **n8n credentials setup** → add integrations for Notion, Google Calendar, and Postgres.
* **Makefile** installed → used to run shortcuts like make up (start services) and make db (initialize database).
* Basic understanding of JSON structure and arrays.

## 📦 Tech Stack

* **n8n** → workflow automation
* **Notion** → supplements & treatment history databases
* **Postgres** → alerts storage & deduplication
* **Google Calendar** → reminders & events
* **JavaScript (inside n8n)** → normalization & logic
* **Docker + Docker Compose** → containerized deployment

## 🔒 Database Backup & Security

Curetrack provides built-in PostgreSQL backup and cleanup.

* **`make backup`** → Creates a backup in `./backups/` **and** automatically deletes backups older than 15 days.
* **`make cleanup`** → Runs cleanup only (without creating a new backup).

You can automate them with Windows Task Scheduler (or any cron/scheduler you prefer) and choose your own runtime.

For Windows Task Scheduler :

**Backup:**
```
Program/script: C:\Windows\System32\wsl.exe
Arguments: e bash -c "cd /mnt/d/workspace/pro/04_projects/portfolio/curetrack && make backup
```

**Cleanup:**
```
Program/script: C:\Windows\System32\wsl.exe
Arguments: -e bash -c "cd /mnt/d/workspace/pro/04_projects/portfolio/curetrack && make cleanup"
```

## 🚀 Quickstart

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/lisekarimi/curetrack.git
   cd curetrack
   ```

2. **Set Up Environment**:
   - Copy the `.env.example` to `.env` and fill in the required environment variables.

3. **Start services**

```bash
make up
```

* n8n → [http://localhost:5678](http://localhost:5678)
* Postgres → port `5432`

3. **Initialize database schema**

```bash
make db
```
4. **Create the alerts table**

```sql
-- Create alerts table for Curetrack
CREATE TABLE IF NOT EXISTS alerts (
  id                serial PRIMARY KEY,
  notion_id         text NOT NULL,          -- ID from Notion
  notion_name       text NOT NULL,          -- Supplement / medication name
  alert_type        text NOT NULL,          -- e.g., start_date, end_date, expiration_date, low_stock, etc.
  alert_value       text NOT NULL,          -- Description string or event date
  calendar_event_id text NOT NULL,          -- Google Calendar event ID
  alert_sent_at     timestamptz DEFAULT now()
);
```

5. **Import workflows in n8n**

   * Log into [http://localhost:5678](http://localhost:5678)
   * Create a free n8n account
   * Add credentials (Google Calendar, Notion, Postgres)
   * Create a new folder "CureTrack"
   * Import JSON workflows from `workflows/`

## 📂 Workflows

Curetrack comes with three main **n8n workflows**:
* **📧 Gmail Calendar Wipe** → deletes all events in your Google Calendar in one shot.
* **📅 Calendar Alert Mailer** → sends all medication-related events (start, end, next cure, dose switch, expiration, low stock) into Google Calendar.
* **📖 Sync Cure History** → synchronizes the Cure History database with the Complements database to track treatment cycles accurately.

## 🗄️ Notion Databases

Curetrack relies on **two Notion databases**:
* **Complements** → the master list of all supplements/medications.
* **Cure History** → tracks treatment cycles (start and end dates).

  * Example: you can start a medication, pause, then restart later — all cycles are tracked here for history and traceability.
