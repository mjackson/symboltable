# A Hash that forces all keys to be symbols.
#
# See http://github.com/mjijackson/symboltable for more information.
class SymbolTable < Hash

  def initialize(hash=nil)
    super()
    merge!(hash) unless hash.nil?
  end

  # Returns +true+ if the given key may be used in this table.
  def valid_key?(key)
    key.respond_to?(:to_sym)
  end

  def key?(key)
    super(key) || (valid_key?(key) && super(key.to_sym))
  end

  def [](key)
    super(key.to_sym) if valid_key?(key)
  end

  def store(key, val)
    if valid_key?(key)
      val = SymbolTable.new(val) if Hash === val && !(SymbolTable === val)
      super(key.to_sym, val)
    end
  end
  alias :[]= :store

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
  alias :update :merge!

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
