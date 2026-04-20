#!/bin/bash

echo "Running Multi-Layer Security Gate..."

echo "Checking container vulnerabilities..."
CRITICAL=$(trivy image --severity CRITICAL --format json calvant-secure-demo | jq '.Results[].Vulnerabilities | length' | awk '{sum+=$1} END {print sum}')

echo "Checking dependency vulnerabilities..."
DEP_VULN=$(pip-audit 2>/dev/null | wc -l)

echo "Critical container CVEs: $CRITICAL"
echo "Dependency vulnerabilities: $DEP_VULN"

# Allow small threshold
CRITICAL_LIMIT=2
DEP_LIMIT=0

if [ "$CRITICAL" -gt "$CRITICAL_LIMIT" ] || [ "$DEP_VULN" -gt "$DEP_LIMIT" ]; then
    echo "❌ Deployment blocked by security gate."
    exit 1
else
    echo "✅ Deployment approved."
fi
