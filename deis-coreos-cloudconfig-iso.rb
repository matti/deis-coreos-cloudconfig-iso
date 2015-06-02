require 'sinatra'
require 'active_support/all'

$stdout.sync = true

post "/configdrive.iso" do
  ip_address = params[:ip]
  ssh_key = params[:ssh_key]
  etcd_url = params[:etcd_url]

  halt 500, "ip, ssh_key and etcd_url are needed as form fields" unless ip_address && ssh_key && etcd_url

  ssh_key_file = params[:ssh_key][:tempfile]
  ssh_key_contents = ssh_key_file.read
  ssh_key_contents.strip!

  user_data_contents = if params[:template] && params[:template][:tempfile]
    params[:template][:tempfile].read
  else
    File.read "./user_data.template"
  end

  user_data_contents.gsub! "#cloud-config\n---\n", "#cloud-config\n---\nssh_authorized_keys:\n  - #{ssh_key_contents}\n"
  user_data_contents.gsub! "$private_ipv4", ip_address
  user_data_contents.sub! /discovery: http.*/, "discovery: #{etcd_url}"

  File.write "./user_data", user_data_contents

  ok = system "./makedrive.sh"

  if ok
    send_file "./configdrive.iso"
  else
    halt 500, "error"
  end
end
