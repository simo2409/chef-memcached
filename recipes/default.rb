#
# Cookbook Name:: memcached
# Recipe:: default
#
# Copyright 2015, Simone Dall Angelo
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

# Install it
package 'memcached' do
  action :install
end

# Setup config file
template node["memcached"]["conf"]["path"] do
  source "memcached.conf.erb"
  owner 'root'
  group 'root'
end

# Create /var/run/memcached
directory File.dirname(node["memcached"]["conf"]["pid_file"]) do
  action :create
  owner 'nobody'
  group 'nobody'
  mode 0777
end

# FIX to solve a problem on server reboot (while memcached is running)
file "/etc/tmpfiles.d/memcached.conf" do
  owner 'root'
  group 'root'
  content "# systemd tmpfile settings for memcached
# See tmpfiles.d(5) for details

d #{File.dirname(node["memcached"]["conf"]["pid_file"])} 0777 nobody nobody -
"
end

# Enable and start it
service 'memcached' do
  action [:enable, :restart]
end
