# jcgpl_portfolio

A new Flutter project.

# Full Redeploy Workflow

Every update becomes:

flutter build web --release --base-href /jcgpl_portfolio/
Remove-Item docs -Recurse -Force -ErrorAction Ignore
Copy-Item build/web docs -Recurse
git add .
git commit -m "added new features"
git push
