# wan-monitor-host
WAN monitoring service with speedtest/ping done directly on host 

![](https://i.imgur.com/fbSUBcq.png)

### How to get started:
1. Install or compile speedtest-cli https://github.com/sivel/speedtest-cli
1. Configure your environment within `config.ini`
2. Setup environmental variables & cron `bash setup-env.sh`
3. Start your containers `sudo docker-compose up -d`
4. After Grafana is up run `./setup-grafana.sh`
5. Go to http://localhost:8080 and login to Grafana using your username & password (default admin:password123)
6. Go to Dashboards -> Manage<br/>
![](https://i.imgur.com/uRt18fP.png)
7. Choose WAN Monitoring

### Quick start:
```
git clone https://github.com/sivel/speedtest-cli.git
cd speedtest-cli
python setup.py install
cd ..
bash setup-env.sh
sudo docker-compose up -d
sleep 30
./setup-grafana.sh
```


#### Example of gathered data:

![](https://i.imgur.com/fUrOOhe.png)

#### Tested on:
- Docker version 20.10.3
- docker-compose version 1.28.2
- Manjaro Nibia 20.2.1
- curl 7.75.0
- ping from iputils s20200821
- speedtest-cli 2.1.2
- cronie 1.5.5


#### Based on images:
- grafana/grafana:latest
- quay.io/influxdb/influxdb:2.0.4
- nginx:alpine


#### This project was first based on these blog posts:
- https://nbailey.ca/post/wan-speedtest-elasticsearch/
- https://nbailey.ca/post/wan-ping-monitor-influxdb/
