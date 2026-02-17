# 🗓️ CureTrack

Automated medication tracking and reminder tool built with n8n, Notion, and Google Calendar.

🌐 **[View our website](https://curetrack.lisekarimi.com)**

## 🚀 Quick Start

### Prerequisites
* **Docker Desktop** + **WSL** (Windows) or Docker on Linux/Mac
* **Notion** account + integration token
* **Google Calendar** OAuth credentials
* **PostgreSQL** database (local or cloud)
* **n8n** (local or cloud hosting like Hostinger)

## 📂 Workflows

- Download JSON files from [workflows/](https://github.com/lisekarimi/curetrack/tree/main/workflows)
- Import into n8n: Create folder "CureTrack" → Import workflows

* **📧 Gmail Calendar Wipe** → deletes all calendar events
* **📅 Calendar Alert Mailer** → sends medication events to Google Calendar
* **📖 Sync Cure History** → synchronizes treatment cycles
* **🔄 End Cycle Auto-Update** → auto-updates stock and resets cycles

## 🗄️ Database Schema

```sql
CREATE TABLE IF NOT EXISTS alerts (
  id                serial PRIMARY KEY,
  notion_id         text NOT NULL,
  notion_name       text NOT NULL,
  alert_type        text NOT NULL,
  alert_value       text NOT NULL,
  calendar_event_id text NOT NULL,
  alert_sent_at     timestamptz DEFAULT now()
);
```
