# RAUC Docker

This build a docker image for [RAUC](https://github.com/rauc/rauc).

Example call:

```bash
docker run --user `id -u`:`id -g` -v `pwd`/input:/data/input -v `pwd`/keys:/data/keys -v `pwd`/output:/data/output axdotl/rauc:0.1 bundle --cert=/data/keys/cert.pem --key=/data/keys/key.pem /data/input/ /data/output/test-0.0.1.raucb
```
