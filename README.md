# deis-coreos-cloudconfig-iso

Create deis.io CoreOS config drives for vmware ESXi installations

## Use the Heroku deployment

	curl -X POST -F ssh_key=@/Users/mpa/.ssh/id_rsa.pub -F ip=192.168.0.20 -F etcd_url="https://discovery.etcd.io/asdfasdfasdfasdfasdfasdf" -F mac_address="00:50:56:AA:AA:AA" -F dns_primary=8.8.8.8 -F dns_secondary=8.8.4.4 -F gateway_ip=192.168.3.1 https://deis-coreos-cloudconfig-iso.herokuapp.com/configdrive.iso -O

	curl -X POST -F ssh_key=@/Users/mpa/.ssh/id_rsa.pub -F ip=192.168.0.20 -F template=@/Users/mpa/dev/deis/contrib/coreos/user_data -F etcd_url="https://discovery.etcd.io/asdfasdfasdfasdfasdfasdf" https://deis-coreos-cloudconfig-iso.herokuapp.com/configdrive.iso -O

## Deploy to heroku

	heroku create
	heroku buildpacks:set https://github.com/ddollar/heroku-buildpack-multi.git
	git push heroku master


## Local e2e dev with (installs mkisofs)

	heroku docker:start

And then test with:

	curl -X POST -F ssh_key=@/Users/mpa/.ssh/id_rsa.pub -F ip=192.168.0.20 -F etcd_url="http://lolcat/com" 192.168.59.103:3000/configdrive.iso -O


NOTE: Do not deploy with docker, but with git push heroku master (heroku does not install mkisofs this way)
