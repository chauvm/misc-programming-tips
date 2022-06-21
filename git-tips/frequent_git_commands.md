

### Squash commits
```
git rebase -i HEAD~10
```

### Remove top commit
```
git reset --soft "HEAD^"
```

### Copy files from another branch
```
git checkout otherbranch myfile.txt

git checkout <commit_hash> <relative_path_to_file_or_dir>

git show commit_id:path/to/file > path/to/file
```
