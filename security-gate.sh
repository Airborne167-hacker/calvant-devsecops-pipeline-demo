#!/bin/bash

echo "Running Multi-Layer Security Gate..."

echo "Checking container vulnerabilities..."
CRITICAL=$(trivy image calvant-secure-demo | grep CRITICAL | wc -l)

echo "Checking dependency vulnerabilities..."
DEP_VULN=$(pip-audit 2>/dev/null | wc -l)

echo "Critical container CVEs: $CRITICAL"
echo "Dependency vulnerabilities: $DEP_VULN"

if [ "$CRITICAL" -gt 0 ] || [ "$DEP_VULN" -gt 0 ]; then
    echo "❌ Deployment blocked by security gate."
    exit 1
else
    echo "✅ Deployment approved."
fi
