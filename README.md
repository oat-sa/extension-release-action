# Tao release docker action

This action used to release tao extension

## Inputs

### `github_token`

**Required**

Version released

## Example usage

uses: oat-sa/conventional-commit-action@v0
with:
  github_token: ${{ secrets.GITHUB_TOKEN }}