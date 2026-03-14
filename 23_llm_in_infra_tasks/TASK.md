Step 1: Deploy your own n8n installation

Instructions available at:

https://docs.n8n.io/hosting/installation/server-setups/docker-compose/

Step 2: Create a Google Form

Create a form with the following fields:

* Name (required)
* Email (required)
* Request type (dropdown list)
* Problem description / comment
* Priority (Low / Medium / High)

Step 3: Creating a Telegram Bot

You can use an existing one

* Create a bot via BotFather
* Get the Bot Token
* Add the bot to a group or use a personal chat
* Get the chat_id

Step 4: Building an n8n workflow

Build a workflow that:

* is triggered when a user fills out the form
* sends a Telegram message about the ticket creation

Requirements:

* Email deduplication should occur
* Retry mechanism for Telegram API errors
* Status storage in the database

