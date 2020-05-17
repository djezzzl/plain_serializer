# PlainSerializer

[![Gem Version](https://badge.fury.io/rb/plain_serializer.svg)](https://badge.fury.io/rb/plain_serializer)
[![CircleCI](https://circleci.com/gh/djezzzl/plain_serializer/tree/master.svg?style=svg)](https://circleci.com/gh/djezzzl/plain_serializer/tree/master)
[![Maintainability](https://api.codeclimate.com/v1/badges/a99db929535f2ce7f24c/maintainability)](https://codeclimate.com/github/djezzzl/plain_serializer/maintainability)

The gem provides plain DSL to serialize objects of any kind.

It includes features such as:
- [Nested serialization](#nested-serialization)
- [Pre-defined groups](#pre-defined-groups)
- [Output modification](#output-modification)
- [Self serialization](#self-serialization)

Output is `Hash` object which means you can convert it easily to anything you want.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'plain_serializer'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install plain_serializer

## Usage

Imagine you have an object which has few simple attributes, something like the following:

```ruby
user = OpenStruct.new(name: 'John Doe', age: 30)
``` 

You can define your serializer like:

```ruby
class UserSerializer < PlainSerializer::Base
  define_attribute :name
  define_attribute :age 
end
```

When you need to serialize your object, you can do it as simple as this:

```ruby
serializer = UserSerializer.setup(:name, :age)

# for single object
p serializer.serialize(user)
# => {:name=>"John Doe", :age=>30}

# for collection of objects
p serializer.serialize_collection([user])
# => [{:name=>"John Doe", :age=>30}]
```

### Nested Serialization

```ruby
user = OpenStruct.new(
  account: OpenStruct.new(name: 'USA'),
  properties: [
    OpenStruct.new(code: 'property1'),
    OpenStruct.new(code: 'property2')
  ]
)

class PropertySerializer < PlainSerializer::Base
  define_attribute :code
end

class AccountSerializer < PlainSerializer::Base
  define_attribute :name
end

class UserSerializer < PlainSerializer::Base
  define_serializer :account, AccountSerializer
  define_collection_serializer :properties, PropertySerializer
end

serializer = UserSerializer.setup(account: :name, properties: :code)
p serializer.serialize(user) 
# => {:account=>{:name=>"USA"}, :properties=>[{:code=>"property1"}, {:code=>"property2"}]}
```

### Pre-defined groups

```ruby
user = OpenStruct.new(
  name: 'John Doe',
  age: '30',
  account: OpenStruct.new(name: 'USA')
)

class AccountSerializer < PlainSerializer::Base
  define_attribute :name
end

class UserSerializer < PlainSerializer::Base
  define_attribute :name
  define_attribute :age

  define_group :personal, [:age, account: :name]

  define_serializer :account, AccountSerializer
end

serializer = UserSerializer.setup(:name, :personal)
p serializer.serialize(user)
# => {:name=>"John Doe", :age=>"30", :account=>{:name=>"USA"}}
```

### Output modification

```ruby
user = OpenStruct.new(name: 'John Doe')

class UserSerializer < PlainSerializer::Base
  define_attribute :name
end

serializer = UserSerializer.setup(:name)

p(serializer.serialize(user) do |output|
  output[:anything] = 'anything_you_want_here'
end)
# => {:name=>"John Doe", :anything=>"anything_you_want_here"} 
```

### Self serialization

```ruby
user = OpenStruct.new(
  birthday: DateTime.now
)

class DateTimeSerializer < PlainSerializer::Base
  def serialize(entity)
    entity.iso8601
  end
end

class UserSerializer < PlainSerializer::Base
  define_serializer :birthday, DateTimeSerializer
end

serializer = UserSerializer.setup(:birthday)
p serializer.serialize(user)
# => {:birthday=>"2020-05-17T11:46:40+02:00"}

p DateTimeSerializer.setup.serialize(DateTime.now)
# => "2020-05-17T11:46:40+02:00"
```

## Development

After checking out the repo, run `bundle install` to install dependencies. 
Then, run `rake spec` to run the tests. 

To install this gem onto your local machine, run `bundle exec rake install`. 

To release a new version, update the version number in `version.rb`, and then 
run `bundle exec rake release`, which will create a git tag for the version, 
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/djezzzl/plain_serializer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/djezzzl/plain_serializer/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PlainSerializer project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/djezzzl/plain_serializer/blob/master/CODE_OF_CONDUCT.md).
