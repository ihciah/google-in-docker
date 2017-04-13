# Google Mirror in Docker

This repo is a fork of [Onemirror](https://github.com/brentybh/onemirror)

## Changes

 - Add `docker-compose.yml` to make it run simply.
 - Use customized google reverse proxy module to make it faster for users in China Mainland.
 - Add auth support.

## Usage

 - Run the following code in `bash` or `zsh`:
  ```bash
  wget -qO- https://get.docker.com/ | sudo sh
  
  sudo usermod -aG docker `whoami`
  
  sudo pip install -U docker-compose
  
  curl -L https://raw.githubusercontent.com/docker/compose/1.2.0/contrib/completion/bash/docker-compose > /etc/bash\_completion.d/docker-compose | sudo bash
  ```
 - Put your certs in `nginx/certs`, and then modify settings in `nginx/conf.d/google.conf`.
 - `docker-compose up -d`.

## Security Note

 - This proxy can be used to access any url even not google: (example)[https://g.ihc.im/!ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png](access with pwd:ice).
 - So please watch your bandwidth to avoid being abused(To build a domain whitelist may be hard and not up-to-date).
 - If you run some thing like swarm(port 2375 is exposed, which can be used to get root privilege through a simple HTTP request in my experient before), or some services not designed to all users, please make sure it cannot be connected by this docker or directly accessed. Maybe a blacklist with intranet ip should be used, which can be done using `iptables` by your own if you need.

## Demo Site

 - (g.ihc.im)[https://g.ihc.im](Directly to AWS server)
 - (g.ihcblog.com)[https://g.ihcblog.com](The same server with a Tencent CDN)
 
## License

MIT