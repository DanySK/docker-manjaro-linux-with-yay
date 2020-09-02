# Manjaro Linux virtual machine for teaching

I'm tired of stuff not working with Windows and dual boots are apparently not a thing in my university,
VMs drain too many resources,
some students have Linux/Mac PCS...
So I adopted docker

## Run on linux

```bash
docker run --rm --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" -it
```

## Run on Windows 10

TBD

## Run on Mac OS X

TBD
