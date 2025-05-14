#!/bin/bash

# Truncate the quarkiverse-mapping.properties file
truncate -s 0 quarkiverse-mapping.properties
# Iterate through all Quarkiverse repositories and generate a mapping file
gh repo list quarkiverse --jq '.[].nameWithOwner' --topic quarkus-extension --json nameWithOwner --no-archived -L 1000 |  sort | while read repo; do
  # Get the groupId from the pom.xml file
  groupId=$(gh api -H "Accept: application/vnd.github.raw" /repos/$repo/contents/pom.xml 2>/dev/null | xmllint --xpath "//*[local-name()='project']/*[local-name()='groupId']/text()" - 2>/dev/null)
  # If the groupId is not empty, print the repository name
  if [ -n "$groupId" ]; then
    # Print the repository name and the groupId
    echo -e "$repo=$groupId"
    # Append the repository name and the groupId to the quarkiverse-mapping.properties file
    echo -e "$repo=$groupId" >> quarkiverse-mapping.properties
  fi
done
# Truncate the quarkiverse-app-mapping.properties file
truncate -s 0 quarkiverse-app-mapping.properties
# Iterate through all Quarkiverse app repositories and generate a mapping file
gh repo list quarkiverse --jq '.[].nameWithOwner' --topic quarkus-app --json nameWithOwner --no-archived -L 1000 |  sort | while read repo; do
  # Get the groupId from the pom.xml file
  groupId=$(gh api -H "Accept: application/vnd.github.raw" /repos/$repo/contents/pom.xml 2>/dev/null | xmllint --xpath "//*[local-name()='project']/*[local-name()='groupId']/text()" - 2>/dev/null)
  # If the groupId is not empty, print the repository name
  if [ -n "$groupId" ]; then
    # Print the repository name and the groupId
    echo -e "$repo=$groupId"
    # Append the repository name and the groupId to the quarkiverse-mapping.properties file
    echo -e "$repo=$groupId" >> quarkiverse-app-mapping.properties
  fi
done


