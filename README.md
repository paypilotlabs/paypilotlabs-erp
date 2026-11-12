# PayPilotLabs ERP

Business management: accounting, invoicing, buying and selling, inventory, manufacturing, projects and assets.

By [PayPilotLabs](https://paypilotlabs.com). Support and requests: https://paypilotlabs.com/roadmap/

## Run it

PayPilotLabs ERP runs as a Frappe v16 site in Docker: MariaDB 11.8, Redis, and an image holding frappe + payments + erpnext.

1. The image pulls this repo and its companions (`paypilotlabs-framework`, `paypilotlabs-payments`) from `github.com/paypilotlabs`; branches are set in `docker/apps.json` and `FRAPPE_BRANCH`.
2. Build the image: `./docker/build.sh` (add `GITHUB_TOKEN=<token>` only if the repos are private) It tags `paypilotlabserp:<git commit>` (push that one to ECR) and `paypilotlabserp:latest`.
3. Start it: `docker compose -f docker/docker-compose.yml up -d`
4. Watch the first-run setup: `docker compose -f docker/docker-compose.yml logs -f create-site` (wait for it to exit 0).
5. Open http://erp.localhost:8080 and log in as `Administrator` / `admin`. Change the password straight away.

Stop with `docker compose -f docker/docker-compose.yml down` (add `-v` to delete the data).
See NOTICE.md for the licence and origin.

## Licence

GPL-3.0. Based on the open-source Frappe project (erpnext v16.54.0); see [NOTICE.md](NOTICE.md) for the origin and attribution, and the licence file in this folder for the full terms.
