# pgs-publish-action

Action to publish static site to [pgs.sh](https://pgs.sh).

## Required params

- `user`: SSH User name
- `key`: Private key
- `src`: Source dir to deploy
- `project`: Project name

## To publish

You will need to copy your ssh private key into a secret in your github repo.
This means your key will be accessible from github.  It is highly recommended
that you create a separate key specifically for github that way the private key
will only have access to your account if there is a breach on github.

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

      - name: publish to pgs
        uses: picosh/pgs-publish-action@main
        with: 
          user: erock 
          key: ${{ secrets.PRIVATE_KEY }}
          src: './public/*'
          project: 'neovimcraft'
```
