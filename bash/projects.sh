#!/bin/bash

build_projects() {
    local projects_file="$ROOT_DIR/projects.json"
    local projectData = $(jq -r --arg name "$2" '.[$name].root' "$projects_file")
}