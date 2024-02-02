# Python website file server with analytics

This project allows you to host multiple static websites with one flask application and track visits to each site. The analytics part of this project is a WIP.

## Why would someone want to use this project?
* To host multiple static (html, css, js) websites on one server without setting up Apache/Nginx/etc for each one individually.
* To create your own web hosting service
* To track analytics of your website visits without using a 3rd party like google analytics

## Settings
Create files called secrets.py in the main directory.

In the secrets.py file you will need to tell the application your Google API keys and MySQL database information.

In the settings.py file you need to tell the application what websites you will be hosting and if you have your website in a different folder than the domain name. You can also configure the bad url, bad user agents, and user agents that are ok but dont track.

By default the application will try to use the domain as the folder name if a folder is not specified. A good use case for this is if you are on your local computer and run the flask application then the domain is 127.0.0.1:5000 but we can not use : in our folder names so our files can not be in a folder with :. Another use case is if you have multiple domains you want to point towards the same folder.


```
# secrets.py
secrets = {
    "google": {
        "client": "",
        "secret": ""
    },
    "sql": {
        "host": "127.0.0.1",
        "port": 3306,
        "db": "",
        "table": "",
        "username": "",
        "password": ""
    }
}
```

## Adding a new website
Once you have domain dns settings setup and the domain added to the websites variable in the settings.py file all you need to do is add your files to the **./websites/** folder.