# Chamberlain/Liftmaster MyQ

Ruby gem to control a Chamberlain/Liftmaster MyQ system.

Partial documentation of the API is available at http://docs.unofficialliftmastermyq.apiary.io/

Notes: the original project (pfeffed/liftmaster_myq) went inactive since Nov 2013, I forked it here to maintain/improve it.

## Installation

Add this line to your application's Gemfile:

    gem 'liftmaster_myq'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install liftmaster_myq-X.X.X.gem (Note: X.X.X should be changed to the current version number)

## Usage

To create the gem:

	$ gem build /path/to/liftmaster_myq/liftmaster_myq.gemspec

To instantiate the system:

	$ require 'liftmaster_myq'
	$ system = LiftmasterMyq::System.new('your_username','your_password')

To see your device list in all it's ruby glory:

	$ system.gateways
	$ system.garage_doors
	$ system.garage_doors.count

Have fun with:

	$ system.garage_doors[0].open
	$ system.garage_doors[0].close
	$ system.garage_doors[0].status

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
