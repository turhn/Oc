# Oc

DigitalOcean commandlien tools

## Installation

Add this line to your application's Gemfile:

    gem 'oc'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oc

## Droplets
<pre>
  Droplet List
	$ oc show [TRUE]

  Create New Droplet
	$ oc droplets new [DROPLET_NAME] [SIZE_ID] [IMAGE_ID] [REGION_ID]

  Reboot Droplet
  $ oc droplets reboot [DROPLET_ID]

  Droplet Power Cycle
	$ oc droplets cycle [DROPLET_ID]

  Power Down Droplet
	$ oc droplets down [DROPLET_ID]

  Power Off Droplet
	$ oc droplets off [DROPLET_ID]

  Power On Droplet
	$ oc droplets on [DROPLET_ID]

  Reset Droplet Password
	$ oc droplets reset_password [DROPLET_ID]

  Resize Droplet
	$ oc droplets resize [DROPLET_ID] [SIZE_ID]

  Snapshot
	$ oc droplets snaphot [DROPLET_ID] [SNAPSHOT_NAME]

  Restore Droplet
	$ oc droplets restore [DROPLET_ID] [IMAGE_ID]

  Rebuild Droplet
	$ oc droplets rebuild [DROPLET_ID] [IMAGE_ID]

  Rename Droplet
  $ oc droplets rename [DROPLET_ID] [NEW_NAME]
</pre>
## SSH
<pre>
  SSH Key List
  $ oc ssh keys

  Add SSH Key
  $ oc ssh add [KEY_NAME] [KEY_PUB]

  Show SSH Key
  $ oc ssh show [KEY_ID]

  Edit SSH Key
  $ oc ssh edit [KEY_ID] [KEY_NAME] [KEY_PUB]

  Destroy SSH Key
  $ oc ssh destroy [KEY_ID]
</pre>
## Regions
<pre>
  Region List
  $ oc regions
</pre>
## Sizes
<pre>
  Size List
  $ oc sizes
</pre>
## Images
<pre>
  Show Images
  $ co images [true]

  Show Image
  $ oc images show [IMAGE_ID]

  Destroy Image
  $ oc images destroy [IMAGE_ID]

  Transfer Image
  $ oc images transfer [IMAGE_ID] [REGION_ID]
</pre>


## Information
<pre>
  Show API Key and Client ID
  $ co info show

  Change Information
  $ co info change
</pre>

## Contributing

1. Fork it ( http://github.com/<my-github-username>/oc/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
