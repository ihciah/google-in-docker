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

## License

MIT