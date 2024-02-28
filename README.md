# pgs-action

Github Action to publish static sites to [pgs.sh](https://pgs.sh).

## Required params

- `user`: SSH User name
- `key`: Private key
- `src`: Source dir to deploy
- `project`: Project name
- `promote`: Once the files have been uploaded to `project` we will promote it
  by symbolically linking this project to it
- `retain`: Removes all projects except the last (3) recently updated projects
  that match prefix provided

## To publish

You will need to copy your ssh private key into a secret in your github repo.
This means your key will be accessible from github. It is highly recommended
that you create a separate key specifically for pico services that way you can
quickly log into pico and remove the key if there's a breach on github.

### Example

```yml
name: ci

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    name: Build and Deploy

    steps:
      - uses: actions/checkout@master

      - name: Set outputs
        id: vars
        run: echo "sha_short=$(git rev-parse --short HEAD)" >> $GITHUB_OUTPUT
      - name: publish to pgs
        uses: picosh/pgs-action@v1
        with: 
          user: erock 
          key: ${{ secrets.PRIVATE_KEY }}
          # trailing slash is critical (we use rsync)
          src: './public/'
          # create a new project on-the-fly using git commit hash
          project: 'neovimcraft-${{ steps.vars.outputs.sha_short }}'
          # once the files have been uploaded to the project above, promote the
          # production project by symbolically linking to it
          promote: 'neovimcraft'
          # keep the latest (N) updated projects matching prefix provided and delete the rest
          retain: 'neovimcraft-'
          # num of recently updated projects to keep
          retain_num: 1
```
