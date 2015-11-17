memcached Cookbook
==================
This cookbook install and configure memcached.

Requirements
------------
None.

Attributes
----------
```json
{
  "memcached": {
    "conf": {
      "port": "..",
      "max_conn": "..",
      "cache_size": "..",
      "listen_ip": ".."
    }
  }
}
```
There are more attributes which can be changed, check `attributes/default.rb`.

Usage
-----
#### memcached::default
Just include `memcached` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[memcached]"
  ]
}
```

Contributing
------------
Need help for testing following best practises, if you can help you are welcome!

License and Authors
-------------------
License: MIT

Authors:

Simone Dall'Angelo
