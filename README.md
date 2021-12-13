# Borsh::Rb

Unofficial implementation of Borsh serializer https://borsh.io/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'borsh-rb'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install borsh-rb

## Usage

include `Borsh` module and define serialisation schema 

```
class User
  include Borsh
  
  borsh id: :string, type: :u8, key: 32, admin: :borsh
  
  def id
    'test'
  end
  
  def type
    1
  end
  
  def key
    'abcd'
  end
  
  admin
    return unless admin?
    
    User.new
  end  
end
```

Serialize as: `User.new.to_borsh`

Supported types: `:string, :u8, :u16, :u32, :u64, :borsh`
Integer as a type is supported to validate preserialized values (for ex. public key)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/2rba/borsh-rb.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
