# Agent Operational Guidelines for homebrew-tap

This repository governs the **homebrew-tap** platform component.

## Dev Commands
* Setup environment: `make setup`
* Run test suite: `make test`
* Run lint checks: `make lint`
* Build artifacts: `make build`

## Safety & Geofence Boundaries
* Zero active static keys committed in this repository.
* OIDC authentication federated roles strictly required for deployment promotions.
