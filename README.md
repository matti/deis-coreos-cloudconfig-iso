# deis-coreos-cloudconfig-iso

Use the Heroku deployment

	curl -X POST -F ssh_key=@/Users/mpa/.ssh/id_rsa.pub -F ip=192.168.0.20 -F etcd_url="https://discovery.etcd.io/asdfasdfasdfasdfasdfasdf" http://deis-coreos-cloudconfig-iso.herokuapp.com/configdrive.iso

Local e2e dev with (installs mkisofs)

	heroku docker:start

And then test with:

	curl -X POST -F ssh_key=@/Users/mpa/.ssh/id_rsa.pub -F ip=192.168.0.20 -F etcd_url="http://lolcat/com" 192.168.59.103:3000/configdrive.iso


Do not deploy with docker, but with git push heroku master (heroku does not install mkisofs this way)
