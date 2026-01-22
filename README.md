# Dedoctive Developer Edition

The application is targeted for standalone use by developers so that they can become familiar with designing, running and testing agentic-BPMN workflows

## Prerequisites
- Docker installed on your machine
    - If it's not installed: [Docker's installation guide](https://docs.docker.com/get-started/get-docker/)

## Setup Steps (Windows):
- To clone the DDE repo, open a command window and run `git clone https://github.com/dedoctive/DedoctiveDeveloperEdition.git`
- Navigate into the cloned folder
- Create a file named `.env` in this folder, filling in your email and API key(s) as illustrated in `.env.template`
- To get the docker image, run `docker pull dedoctive/dedoctive-developer-edition:latest`
- Open PowerShell
    - To allow locally created scripts, run `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned`
    - To validate your inputs in the `.env` file and set up the docker image, run `./runDev.ps1`
    - When prompted, allow public and private networks to access Docker Desktop Edition

## Usage
- Once the docker container is running navigate to http://localhost:4000 in your browser
- You will need to login using a google account with the email you defined previously as ROOT_USER in the .env file
- If you create and save a new workflow, it is recommended to save it in the Workflows directory to avoid unexpected behaviour when referencing a workflow from within a workflow
- Stop the container with: `docker stop dedoctive-developer-edition`
- Start the container again with: `docker start dedoctive-developer-edition`
