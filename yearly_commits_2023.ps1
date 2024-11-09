# Start date - 1st Jan 2023
$start_date = Get-Date -Year 2023 -Month 1 -Day 1
# Total days in the year
$total_days = 365

# Loop for each day of the year
for ($i = 0; $i -lt $total_days; $i++) {
    # Calculate date for each commit
    $commit_date = $start_date.AddDays($i)
    $formatted_date = $commit_date.ToString("yyyy-MM-ddTHH:mm:ss")

    # Check if it's Saturday or Sunday
    if ($commit_date.DayOfWeek -eq 'Saturday' -or $commit_date.DayOfWeek -eq 'Sunday') {
        # Get commit ID for that specific date
        $commit_id = git log --pretty=format:"%H" --since="$commit_date 00:00:00" --until="$commit_date 23:59:59" -n 1
        
        if ($commit_id) {
            # Revert the commit to remove it
            git revert --no-commit $commit_id
        }
    }
}

# Commit the reverts for all weekend commits
git commit -m "Remove weekend commits"

# Push changes (use --force if needed)
git push origin master --force