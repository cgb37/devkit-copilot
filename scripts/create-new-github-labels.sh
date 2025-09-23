#!/bin/bash

# Script Name: create-new-github-labels.sh
# Description: Creates a standardized set of labels for new GitHub repositories with consistent naming and best practices
# Author: charlesbrownroberts
# Date Created: 6/12/25
# Last Modified: 6/12/25

set -e  # Exit on any error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check for GitHub token
if [ -z "$GITHUB_TOKEN" ]; then
    print_warning "GITHUB_TOKEN environment variable not found."
    echo -n "Please enter your GitHub Personal Access Token: "
    read -s GITHUB_TOKEN
    echo
    if [ -z "$GITHUB_TOKEN" ]; then
        print_error "GitHub token is required. Exiting."
        exit 1
    fi
fi

# Get repository owner and name
echo -n "Enter the repository owner (username/organization): "
read REPO_OWNER

if [ -z "$REPO_OWNER" ]; then
    print_error "Repository owner is required. Exiting."
    exit 1
fi

echo -n "Enter the repository name: "
read REPO_NAME

if [ -z "$REPO_NAME" ]; then
    print_error "Repository name is required. Exiting."
    exit 1
fi

# Verify repository exists and is accessible
print_status "Verifying repository access..."
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" \
    -H "Authorization: token $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME")

if [ "$HTTP_STATUS" -eq 200 ]; then
    print_success "Repository $REPO_OWNER/$REPO_NAME is accessible."
elif [ "$HTTP_STATUS" -eq 404 ]; then
    print_error "Repository $REPO_OWNER/$REPO_NAME not found or not accessible."
    exit 1
elif [ "$HTTP_STATUS" -eq 401 ]; then
    print_error "Authentication failed. Please check your GitHub token."
    exit 1
else
    print_error "Failed to access repository. HTTP status: $HTTP_STATUS"
    exit 1
fi

# Function to create a label
create_label() {
    local name=$1
    local color=$2
    local description=$3

    print_status "Creating label: $name"

    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" \
        -X POST \
        -H "Authorization: token $GITHUB_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/labels" \
        -d "{\"name\": \"$name\", \"color\": \"$color\", \"description\": \"$description\"}")

    if [ "$HTTP_STATUS" -eq 201 ]; then
        print_success "Created label: $name"
    elif [ "$HTTP_STATUS" -eq 422 ]; then
        print_warning "Label '$name' already exists, skipping."
    else
        print_error "Failed to create label '$name'. HTTP status: $HTTP_STATUS"
    fi
}

# Main code starts here
print_status "This script will create standardized GitHub labels for your repository."
print_status "Ensure you have a GitHub Personal Access Token with 'repo' scope."
print_status "Starting label creation for $REPO_OWNER/$REPO_NAME..."
echo

# ==============================================
# CONVENTIONAL COMMIT LABELS (Primary Types)
# ==============================================
print_status "Creating Conventional Commit labels..."

create_label "feat" "0e8a16" "A new feature"
create_label "fix" "d73a4a" "A bug fix"
create_label "docs" "0075ca" "Documentation only changes"
create_label "style" "f9f9f9" "Changes that do not affect the meaning of the code (whitespace, formatting)"
create_label "refactor" "1f77b4" "A code change that neither fixes a bug nor adds a feature"
create_label "perf" "ff7f0e" "A code change that improves performance"
create_label "test" "1d76db" "Adding or correcting tests"
create_label "build" "795548" "Changes that affect the build system or external dependencies"
create_label "ci" "ff9800" "Changes to CI configuration files and scripts"
create_label "chore" "fef2c0" "Other changes that don't modify source or test files"
create_label "revert" "e91e63" "Reverts a previous commit"

# ==============================================
# CONVENTIONAL COMMIT LABELS (Extended Types)
# ==============================================
create_label "wip" "fbca04" "Work in progress (temporary; typically squashed before merging)"
create_label "init" "9c27b0" "Initial commit"
create_label "merge" "607d8b" "A merge commit"
create_label "deps" "0366d6" "Dependency updates"
create_label "security" "b60205" "Fixes related to security vulnerabilities"
create_label "infra" "5319e7" "Infrastructure-related changes (server config, cloud resources)"
create_label "release" "4caf50" "A release commit (often automated via CI tools)"
create_label "hotfix" "d73a4a" "An emergency bugfix, typically deployed directly to production"


# Core development labels
create_label "bug" "d73a4a" "Something isn't working"
create_label "enhancement" "a2eeef" "New feature or request"
create_label "feature" "0e8a16" "New feature implementation"
create_label "fix" "fbca04" "Bug fix"
create_label "documentation" "0075ca" "Improvements or additions to documentation"
create_label "duplicate" "cfd3d7" "This issue or pull request already exists"
create_label "invalid" "e4e669" "This doesn't seem right"
create_label "wontfix" "ffffff" "This will not be worked on"
create_label "question" "d876e3" "Further information or discussion needed"

# Development areas
create_label "backend" "1d76db" "Backend development"
create_label "frontend" "bfd4f2" "Frontend development"
create_label "api" "0052cc" "API related changes"
create_label "database" "c5def5" "Database related changes"
create_label "ui" "e99695" "User interface changes"

# Process and workflow labels
create_label "ready-for-review" "0e8a16" "Ready for code review"
create_label "work-in-progress" "fbca04" "Work in progress, not ready for review"
create_label "dependencies" "0366d6" "Pull requests that update a dependency file"

# Quality and security
create_label "security" "d73a4a" "Security-related issues or fixes"
create_label "performance" "0075ca" "Performance optimization"
create_label "testing" "1d76db" "Testing-related changes"
create_label "breaking-change" "b60205" "Breaking changes that affect compatibility"

# Infrastructure
create_label "infrastructure" "5319e7" "Infrastructure and deployment related"

# Priority levels
create_label "high-priority" "d73a4a" "High priority issue"
create_label "medium-priority" "fbca04" "Medium priority issue"
create_label "low-priority" "0e8a16" "Low priority issue"

# Community labels
create_label "good-first-issue" "7057ff" "Good for newcomers"
create_label "help-wanted" "008672" "Extra attention is needed"

# Story points (Agile estimation)
create_label "story-points-0" "f9f9f9" "0 story points"
create_label "story-points-1" "c2e0c6" "1 story point"
create_label "story-points-2" "bfd4f2" "2 story points"
create_label "story-points-3" "d1ecf1" "3 story points"
create_label "story-points-5" "fef2c0" "5 story points"
create_label "story-points-8" "f7c6c7" "8 story points"
create_label "story-points-13" "e99695" "13 story points"
create_label "story-points-20" "d73a4a" "20 story points"

# Core AI/ML
create_label "ai" "ff6b35" "Artificial intelligence related"
create_label "machine-learning" "4285f4" "Machine learning functionality"
create_label "llm" "9c27b0" "Large language model integration"
create_label "embeddings" "673ab7" "Vector embeddings and similarity"
create_label "prompt-engineering" "ff9800" "Prompt design and optimization"

# AI Frameworks
create_label "langchain" "1976d2" "LangChain framework"
create_label "langgraph" "388e3c" "LangGraph workflow engine"
create_label "pydantic-ai" "e91e63" "Pydantic AI framework"

# AI Development Areas
create_label "agents" "795548" "AI agent development"
create_label "rag" "607d8b" "Retrieval-Augmented Generation"
create_label "fine-tuning" "ff5722" "Model fine-tuning and training"
create_label "evaluation" "3f51b5" "Model evaluation and metrics"
create_label "data-pipeline" "009688" "Data processing and pipelines"
create_label "model-ops" "ff6f00" "Model operations and deployment"

# Python specific
create_label "python" "3776ab" "Python language specific"
create_label "async" "ffc107" "Asynchronous programming"
create_label "packaging" "8bc34a" "Python packaging and distribution"
create_label "environment" "cddc39" "Environment and dependency management"

# AI-specific workflow
create_label "experiment" "e1bee7" "Experimental features or research"
create_label "dataset" "4caf50" "Dataset related changes"
create_label "model-update" "ff9800" "Model version updates"
create_label "inference" "2196f3" "Model inference and serving"

echo
print_success "Label creation completed for $REPO_OWNER/$REPO_NAME!"
print_success "Created labels include:"
print_success "  ✓ Conventional Commit types (feat, fix, docs, style, refactor, etc.)"
print_success "  ✓ Extended Conventional Commit types (wip, deps, security, hotfix, etc.)"
print_success "  ✓ Development workflow labels"
print_success "  ✓ Priority and sizing labels"
print_success "  ✓ Community and contribution labels"
print_status "You can view your labels at: https://github.com/$REPO_OWNER/$REPO_NAME/labels"

echo
print_status "💡 Pro tip: Use these conventional commit labels to:"
print_status "   • Automatically categorize PRs based on commit messages"
print_status "   • Generate changelogs with tools like conventional-changelog"
print_status "   • Trigger semantic versioning with tools like semantic-release"