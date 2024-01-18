# Buzz It

A free, online and open-source buzzer system.

# Gallery

<img style="width:30%" src="https://github.com/AlexisL61/BuzzIt/assets/30233189/9de0560f-f8df-40cd-aa11-07b2082751aa">
<img style="width:30%" src="https://github.com/AlexisL61/BuzzIt/assets/30233189/36098ad1-0f65-437b-86fc-70d89b69f033">
<img style="width:30%" src="https://github.com/AlexisL61/BuzzIt/assets/30233189/d1a639ef-cc7c-4360-a83d-9d6c6135dc79">

# Directories

- `buzzer` : contains the source code for the web app and the mobile app
- `server` : contains the source code for the server

# Installation

## Client

You can download the app on Android by downloading the buzzer_android.apk file in the latest release : https://github.com/AlexisL61/BuzzIt/releases

The app is not available on the play store. This is due to a new rule on the store : we need at least 20 users testing the app for at least 14 days to publish the app. If you want to help, you can add a message in the issue : https://github.com/AlexisL61/BuzzIt/issues/1

## Server

The server can be launched using a files in the [docker](https://github.com/AlexisL61/BuzzIt/tree/main/docker) folder.

After downloading these files run : 

```sh
cp .env.dist .env
```

Replace the content of the .env file following your server configuration

Next, run this command to launch the server : 

```sh
docker compose up -d
```
