# pgs-action

Github Action to publish static sites to [pgs.sh](https://pgs.sh).

## Required params

- `key`: Private key
- `cert_pubkey`: Certified public key used with SSH certificates
- `src`: Source dir to deploy
- `project`: Project name
- `promote`: Once the files have been uploaded to `project` we will promote it
  by symbolically linking this project to it
- `retain`: Removes all projects except the last (N) recently updated projects
  that match prefix provided
- `retain_num`: The latest updated number of projects to keep (default: 1)

## To publish

You will need to copy your ssh private key into a secret in your github repo.
This means your key will be accessible from github. It is highly recommended
that you create a separate key specifically for pico services that way you can
quickly log into pico and remove the key if there's a breach on github.

https://pico.sh/faq#can-i-associate-multiple-ssh-keypairs-to-a-single-account

## Usage - Basic

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
        uses: picosh/pgs-action@v3
        with:
          key: ${{ secrets.PRIVATE_KEY }}
          src: './public/' # trailing slash is important (we use rsync)
          project: 'neovimcraft' # update or create a new project on-the-fly
```

## Usage - Site promotion and retention policy

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
        uses: picosh/pgs-action@v3
        with: 
          key: ${{ secrets.PRIVATE_KEY }}
          src: './public/'
          project: 'neovimcraft-${{ steps.vars.outputs.sha_short }}'
          # once the files have been uploaded to the project above, promote the
          # production project by symbolically linking to the project we just created
          promote: 'neovimcraft'
          # keep the latest (N) updated projects matching prefix provided and delete the rest
          retain: 'neovimcraft-'
          # retention policy: num of recently updated projects to keep
          retain_num: 1
```

## Usage - SSH Certificate Authentication

https://pico.sh/access-control

If you are using SSH certificates for access control then you need to add your certified pubkey in addition to your bot's private key.

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
        uses: picosh/pgs-action@v3
        with:
          key: ${{ secrets.PRIVATE_KEY }}
          cert_pubkey: ${{ secrets.CERT_PUBKEY }}
          src: './public/' # trailing slash is important (we use rsync)
          project: 'neovimcraft' # update or create a new project on-the-fly
```
