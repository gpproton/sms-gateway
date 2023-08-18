# SMS Gateway (PlaySMS/Kannel)

## Bootstrap setup

```bash
sudo rm -rf .docker && \
cp kannel.sample.conf kannel.conf
```

## Adjust kannel configuration

Apply necessary update to kannel.conf

```bash
docker-compose up
```

Then visit address => http://localhost/

## Check Bearer status

```bash
curl http://localhost:13000/cgi-bin/status?password=playsms
```

## Send using SMSBox service

```bash
curl http://localhost:13131/cgi-bin/sendsms?username=playsms&password=playsms&to=234xxxxxxxxxx3&text=Hello+world
```

## PlaySMS API sample

```bash
curl -v http://localhost/index.php?app=ws&u=admin&h=e81ac2b29e89a5d2573fc985691712a6&op=pv&to=234xxxxxxxxxx3&msg=test+only
```

