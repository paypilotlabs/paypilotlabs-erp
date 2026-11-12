# PayPilotLabs ERP

One system to run the money, stock and work of a business: accounting, selling, buying, inventory, manufacturing and projects.

By [PayPilotLabs](https://paypilotlabs.com). Support and requests: https://paypilotlabs.com/roadmap/

## What it does

- **Accounting**: chart of accounts, sales and purchase invoices, payments, journal entries, bank reconciliation, budgets, tax rules and financial reports.
- **Selling**: customers, quotations, sales orders, delivery notes, point of sale and a customer portal.
- **Buying**: suppliers, requests for quotation, purchase orders and purchase receipts.
- **Stock**: items, warehouses, stock movements, batches and serial numbers, and stock valuation.
- **Manufacturing**: bills of materials, work orders, job cards, production plans and subcontracting.
- **Projects**: projects, tasks and timesheets, with billing from tracked time.
- **Assets**: fixed assets, depreciation and maintenance.
- **After-sales**: support issues, service level agreements and maintenance schedules.
- **Quality**: quality inspections and goals.
- **Customer relations**: leads, opportunities and campaigns.

## How it helps your business

- Sales, buying, stock and accounts live in one place, so you enter each fact once.
- You can see who owes you money and whom you owe.
- Stock counts update as goods move, so you know what you have before you promise it.
- Each invoice and payment posts to the books as it happens, which keeps month-end work short.
- Production plans show which materials you need before you start a job.
- Time tracked on a project can go straight onto the customer's invoice.

## How it fits with other PayPilotLabs products

- It runs on **paypilotlabs-framework**, the base every PayPilotLabs product uses.
- It also needs **paypilotlabs-payments**, which connects payment gateways.
- It does not need any other PayPilotLabs product. The image is built from this repo plus those two (see `docker/apps.json`).

## Run it

PayPilotLabs ERP runs as a PayPilotLabs framework v16 site in Docker: MariaDB 11.8, Redis, and an image holding the framework, payments and ERP.

1. The image pulls this repo and its companions (`paypilotlabs-framework`, `paypilotlabs-payments`) from `github.com/paypilotlabs`; app branches are set in `docker/apps.json`, and the framework branch in `docker/build.sh`.
2. Build the image: `./docker/build.sh` (add `GITHUB_TOKEN=<token>` only if the repos are private). It tags `paypilotlabserp:<git commit>` (push that one to ECR) and `paypilotlabserp:latest`.
3. Start it: `docker compose -f docker/docker-compose.yml up -d`
4. Watch the first-run setup: `docker compose -f docker/docker-compose.yml logs -f create-site` (wait for it to exit 0).
5. Open http://erp.localhost:8080 and log in as `Administrator` / `admin`. Change the password straight away.

Stop with `docker compose -f docker/docker-compose.yml down` (add `-v` to delete the data).

## Licence

GPL-3.0. See [license.txt](license.txt) for the full terms. Based on open-source work by others; see [NOTICE.md](NOTICE.md) for credits.
