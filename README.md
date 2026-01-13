# Dedoctive Developer Edition

The application is targeted for standalone use by developers so that they can become familiar with designing, running and testing agentic-BPMN workflows

## Prerequisites
- Docker installed on your machine
    - If it's not installed: [Docker's installation guide](https://docs.docker.com/get-started/get-docker/)

## Setup Steps:
- Create a file named `.env`, filling in the details as specified in .env.template
- To get the docker image, from a terminal execute: `docker image pull dedoctive/dedoctive-developer-edition:latest`
- To run the image execute: `./runDev.ps1`
    - This script just validates your inputs in the .env file and sets up the docker image

## Usage
- Once the docker container is running navigate to http://localhost:4000 in your browser
- You will need to login using a google account with the email you defined previously as ROOT_USER in the .env file
- If you create and save a new workflow, it is recommended to save it in the Workflows directory to avoid unexpected behaviour when referencing a workflow from within a workflow
- Stop the container with: `docker stop dedoctive-developer-edition`
- Start the container again with: `docker start dedoctive-developer-edition`