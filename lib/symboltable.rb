# A Symbols-only Hash for Ruby.
#
# http://mjijackson.com/symboltable
class SymbolTable < Hash
  def initialize(hash=nil)
    super()
    merge!(hash) unless hash.nil?
  end

  # Returns +true+ if the given key may be used in this table.
  def valid_key?(key)
    key.respond_to?(:to_sym)
  end

  # Returns +true+ if this table contains the given +key+.
  def key?(key)
    valid_key?(key) && super(key.to_sym)
  end

  # Retrieves the value of the given +key+.
  def [](key)
    super(key.to_sym) if valid_key?(key)
  end

  # Sets the value of the given +key+ to +val+.
  def store(key, val)
    if valid_key?(key)
      val = SymbolTable.new(val) if Hash === val && !(SymbolTable === val)
      super(key.to_sym, val)
    end
  end

  alias []= store

  # Merges the values from +other_hash+ into this table.
  def merge!(other_hash)
    raise ArgumentError unless Hash === other_hash
    other_hash.each do |k, v|
      if block_given? && key?(k)
        self[k] = yield(k, self[k], v)
      else
        self[k] = v
      end
    end
  end

  alias update merge!

  # Allows values to be retrieved and set using Ruby's dot method syntax.
  def method_missing(sym, *args)
    if sym.to_s =~ /(.+)=$/
      self[$1] = args[0]
    elsif args.empty?
      self[sym]
    else
      super(sym, *args)
    end
  end
end
