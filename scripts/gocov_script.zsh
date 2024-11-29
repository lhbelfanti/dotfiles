#!/bin/zsh

# Initialize variables
GOCOVPATH="$HOME/go/coverage"
covignore_file=""
coverage_tmp="$GOCOVPATH/codecov.out.tmp"
coverage_out="$GOCOVPATH/codecov.out"

# Parse parameters
while getopts ":f:" opt; do
  case $opt in
    f)
      covignore_file="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Run tests and capture output and errors
echo "Running tests..."
go test ./... -covermode=atomic -coverprofile=$coverage_tmp -coverpkg=./... -count=1 -race -timeout=30m -shuffle=on 2>&1


# Filter coverage if -f is provided
if [ -n "$covignore_file" ]; then
  files_ignored_from_report=$(awk '/^ignore:/ {flag=1; next} /^$/{flag=0} flag {print}' "$covignore_file")
  echo "\nFiles ignored from the report:\n $files_ignored_from_report"

  # Extract ignore paths from $covignore_file
  ignore_paths=$(awk '/^ignore:/ {flag=1; next} /^$/{flag=0} flag {print}' "$covignore_file" | awk -F'"' '{gsub(/\*/, "", $2); print $2}' | sed 's/"/\\"/g')

  # Format ignore paths into patterns for grep
  ignore_patterns=$(echo "$ignore_paths" | awk '{print $0}' | paste -sd "\n" -)

  # Save ignore patterns to a temporary file for grep
  ignore_file=$(mktemp)
  echo "$ignore_patterns" > "$ignore_file"

  # Remove ignored lines from the coverage report
  grep -E -v -f "$ignore_file" "$coverage_tmp" > "$coverage_out"

  # Clean up temporary file
  rm "$ignore_file"
else
  mv $coverage_tmp $coverage_out
fi


# Generate and open coverage report
go tool cover -html=$coverage_out -o $GOCOVPATH/codecov.html
open $GOCOVPATH/codecov.html