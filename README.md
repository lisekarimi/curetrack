# 🗓️ CureTrack - Developer Setup

Automated medication tracking and reminder tool built with n8n, Notion, and Google Calendar.

🌐 **[View our website](https://curetrack.lisekarimi.com)**

## 🚀 Quick Start

### Prerequisites
* **Docker Desktop** + **WSL** (Windows) or Docker on Linux/Mac
* **Notion** account + integration token
* **Google Calendar** OAuth credentials
* **PostgreSQL** database (local or cloud)
* **n8n** (local or cloud hosting like Hostinger)

### Setup Order

1. **Install n8n**:
   - Local: `npm install n8n -g && n8n start`
   - Cloud: Deploy to Hostinger or similar
   - Access: [http://localhost:5678](http://localhost:5678)

2. **Create n8n Credentials**:
   - Notion integration
   - Google OAuth (Calendar API)
   - PostgreSQL connection

3. **Clone & Setup Project**:
   ```bash
   git clone https://github.com/lisekarimi/curetrack.git
   cd curetrack
   cp .env.example .env  # Fill in your credentials
   ```

4. **Start Services**:
   ```bash
   make up
   ```

5. **Initialize Database**:
   ```bash
   make db
   ```

6. **Import Workflows**:
   - Download JSON files from [workflows/](https://github.com/lisekarimi/curetrack/tree/main/workflows)
   - Import into n8n: Create folder "CureTrack" → Import workflows

## 📂 Workflows

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

## 🔧 Commands

- `make up` → Start services
- `make db` → Initialize database
- `make backup` → Backup database
- `make cleanup` → Clean old backups
