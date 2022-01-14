# Example of using VScode DevContainer 
This is the example project template for using VS Code Dev Container with Ruby on Rails. As its the sample template to kick start it may require alot of customization to match your needs. So please feel free to change on your end.

## Prequesties
- Docker & Docker has to be installed
- Remote Containers extension for VS Code to be installed

## Steps to follow
- Clone this Repo 
- COPY .env.example inside `.devcontainer/` folder to root and name to `.env`

- Open folder in VScode Click Ctrl+Shift+p and type `Rebuild and reopen this folder in Container `
- Then stretch your legs if you connection is slow and go for a walk.

## After Re Opening
- open new terminal in VSCode 
- type `rails --version`
- once you see the rails version , then you can start working inside container.

## Changing Environment Variables and Args
There are two places that you can make adjustment to Ruby version, Node Version , 
- `devcontainer.json` is for vscode related container configurations 
- `.env` for docker-compose configurations


