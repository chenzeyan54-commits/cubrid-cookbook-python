#!/usr/bin/env bash
# Stage repo docs into docs/ for the mkdocs site. Sources of truth stay at
# their repo locations; run before `mkdocs build` (CI docs.yml and `make docs`).

set -euo pipefail
cd "$(dirname "$0")/.."

stage() {
  src="$1"; dst="$2"
  if [ -f "$src" ]; then
    mkdir -p "$(dirname "$dst")"
    sed -e 's|\(\.\./\)*GETTING_STARTED\.md|getting-started.md|g' \
        -e 's|\(\.\./\)*SUPPORT_MATRIX\.md|support-matrix.md|g' \
        -e 's|\(\.\./\)*KNOWN_ISSUES\.md|known-issues.md|g' \
        -e 's|\(\.\./\)*CHANGELOG\.md|changelog.md|g' \
        -e 's|\(\.\./\)*fundamentals/pycubrid/README\.md|fundamentals-pycubrid.md|g' \
        -e 's|\(\.\./\)*fundamentals/sqlalchemy/README\.md|fundamentals-sqlalchemy.md|g' \
        -e 's|\(\.\./\)*fundamentals/pandas/README\.md|fundamentals-pandas.md|g' \
        -e 's|\(\.\./\)*fundamentals/parameterized-queries/README\.md|fundamentals-parameterized-queries.md|g' \
        -e 's|\(\.\./\)*fundamentals/README\.md|fundamentals.md|g' \
        -e 's|\(\.\./\)*performance/README\.md|performance.md|g' \
        -e 's|\(\.\./\)*pitfalls/README\.md|pitfalls.md|g' \
        -e 's|\(\.\./\)*templates/api-service-fastapi/README\.md|template-api-service-fastapi.md|g' \
        -e 's|\(\.\./\)*templates/async-worker/README\.md|template-async-worker.md|g' \
        -e 's|\(\.\./\)*templates/batch-etl/README\.md|template-batch-etl.md|g' \
        -e 's|\(\.\./\)*templates/dashboard/README\.md|template-dashboard.md|g' \
        -e 's|\(\.\./\)*templates/django/README\.md|template-django.md|g' \
        -e 's|\(\.\./\)*templates/flask/README\.md|template-flask.md|g' \
        -e 's|\(\.\./\)*templates/ai-agent/README\.md|template-ai-agent.md|g' \
        -e 's|\](\(\.\./\)*README\.md)|](catalog.md)|g' \
        "$src" > "$dst"
  else
    echo "stage-docs: missing $src — skipping" >&2
  fi
}

stage README.md                                  docs/catalog.md
stage GETTING_STARTED.md                         docs/getting-started.md
stage SUPPORT_MATRIX.md                          docs/support-matrix.md
stage KNOWN_ISSUES.md                            docs/known-issues.md
stage CHANGELOG.md                               docs/changelog.md
stage fundamentals/README.md                     docs/fundamentals.md
stage fundamentals/pycubrid/README.md            docs/fundamentals-pycubrid.md
stage fundamentals/sqlalchemy/README.md          docs/fundamentals-sqlalchemy.md
stage fundamentals/pandas/README.md              docs/fundamentals-pandas.md
stage fundamentals/parameterized-queries/README.md docs/fundamentals-parameterized-queries.md
stage performance/README.md                      docs/performance.md
stage pitfalls/README.md                         docs/pitfalls.md
stage templates/api-service-fastapi/README.md    docs/template-api-service-fastapi.md
stage templates/async-worker/README.md           docs/template-async-worker.md
stage templates/batch-etl/README.md              docs/template-batch-etl.md
stage templates/dashboard/README.md              docs/template-dashboard.md
stage templates/django/README.md                 docs/template-django.md
stage templates/flask/README.md                  docs/template-flask.md
stage templates/ai-agent/README.md                 docs/template-ai-agent.md

# Exclude internal planning pages from published site
rm -f docs/PRD.md docs/prd.md