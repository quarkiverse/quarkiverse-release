#!/bin/bash

# Iterate through all Quarkiverse repositories and generate a mapping file
gh repo list quarkiverse --jq '.[].nameWithOwner' --topic quarkus-extension --json nameWithOwner --no-archived -L 1000 |  sort | while read repo; do
  groupId=$(gh api -H "Accept: application/vnd.github.raw" /repos/$repo/contents/pom.xml 2>/dev/null | xmllint --xpath "//*[local-name()='project']/*[local-name()='groupId']/text()" - 2>/dev/null)
  # If the groupId is not empty, print the repository name
  if [ -n "$groupId" ]; then
    echo -e "$repo=$groupId" >> quarkiverse-mapping.properties
  fi
done

