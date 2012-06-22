**SymbolTable** is a handy little Ruby class that was conceived from the union
of `Hash` and `Symbol`. SymbolTable directly extends `Hash`, but it stores all
keys internally as symbols. Any key that cannot be converted to a `Symbol` is
not valid.

While this may seem restrictive, it does have the nice side effect of making
all keys slightly more memorable and usable. For example, values may be set
and retrieved using any key that resolves to the same symbol.

```ruby
h = Hash.new
h[:a] = 1
h[:a]       # => 1
h['a']      # => nil
h.a         # => NoMethodError: undefined method `a' for {}:Hash

require 'symboltable'

t = SymbolTable.new
t[:a] = 1
t[:a]       # => 1
t['a']      # => 1
t.a         # => 1
t.b = 2     # => 2
```

Also, because `SymbolTable` subclasses `Hash`, you get all the nice methods of
`Hash` for free.

```ruby
t.keys      # => [:a, :b]
t.values    # => [1, 2]

t.merge!('c' => 3, :d => 4)
t.keys      # => [:a, :b, :c, :d]
t.values    # => [1, 2, 3, 4]

t.each do |k, v|
  puts "#{k} = #{v}"
end
```

You get the idea. This kind of data structure is mainly useful for large
configuration objects and the like, where you want to store a bunch of data and
you don't want to have to remember later how you stored it.

## Why?

Mainly just for fun, and because I sometimes miss the automatic and ubiquitous
type conversion you get in PHP.

## Installation

Using [RubyGems](http://rubygems.org):

    $ sudo gem install symboltable

From a local copy:

    $ git clone git://github.com/mjijackson/symboltable.git
    $ cd symboltable
    $ rake package && sudo rake install

## License

Copyright 2012 Michael Jackson

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

The software is provided "as is", without warranty of any kind, express or
implied, including but not limited to the warranties of merchantability,
fitness for a particular purpose and non-infringement. In no event shall the
authors or copyright holders be liable for any claim, damages or other
liability, whether in an action of contract, tort or otherwise, arising from,
out of or in connection with the software or the use or other dealings in
the software.
