# Nitro starter

Look at the [nitro quick start](https://nitro.unjs.io/guide#quick-start) to learn more how to get started.

rsync -avz --progress /home/yoav/pigafetta/.output yoav@raspberrypi.local:/home/yoav/del

# pull prod from github to raspi
```
git clone --no-checkout https://github.com/arikhativa/pigafetta.git
cd pigafetta
git config core.sparseCheckout true
echo ".output" >> .git/info/sparse-checkout
echo "scripts" >> .git/info/sparse-checkout
first time:
    git checkout main
auto pull:
    git fetch
    git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)

```

# setup systemd
```
sudo vim /etc/systemd/system/deno-task.service
ExecStart=/home/yoav/.deno/bin/deno task --config /home/yoav/pigafetta/.output/deno.json start
sudo systemctl daemon-reload
sudo systemctl restart deno-task.service
```
