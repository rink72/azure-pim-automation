#!/bin/bash

set -e

# Function to parse JSON using grep, sed, and awk
parse_json() {
    echo "$1" | sed 's/\\\\\//\//g' | sed 's/[{}]/''/g' | awk -v k="\"$2\"" '{n=split($0,a,","); for (i=1; i<=n; i++) if (a[i] ~ k) print a[i];}' | sed 's/\"//g' | awk -F: '{print $2}'
}

# Assigning the result of the az rest command to the policyData variable
policyData=$(az rest --method get --url "https://management.azure.com${RESOURCE_ID}/providers/Microsoft.Authorization/roleManagementPolicyAssignments?api-version=2020-10-01&\$filter=roleDefinitionId+eq+%27${ROLE_DEFINITION_ID}%27")

# Check if policyData is not empty
if [ -z "$policyData" ]; then
  echo "Error: No data retrieved from az rest command"
  exit 1
fi

# Parse the JSON and check the number of results
resultCount=$(echo "$policyData" | grep -o '"policyId"' | wc -l)

# Throw an error if there is more than one result
if [ "$resultCount" -ne 1 ]; then
  echo "Error: Expected exactly one result but found $resultCount"
  exit 1
fi

# Extract the policyId from properties.policyId
policyId=$(echo "$policyData" | sed -n 's/.*"policyId": "\([^"]*\)".*/\1/p')

# Save the data to files for debugging
echo "Policy data: $policyData" > /tmp/policyData.txt
echo "ResultCount: $resultCount" > /tmp/resultCount.txt
echo "Policy ID: $policyId" > /tmp/policyId.txt

# Output the policy ID
echo "{\"policy_id\": \"$policyId\"}"