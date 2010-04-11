lib = File.dirname(File.dirname(__FILE__)) + '/lib'
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'test/unit'
require 'symboltable'

class SymbolTableTest < Test::Unit::TestCase

  def test_empty
    t = SymbolTable.new

    assert_equal(nil, t[:a])
    assert_equal(nil, t['a'])
  end

  def test_bracket
    t = SymbolTable.new

    t[:a] = 1
    assert_equal(1, t[:a])
    assert_equal(1, t['a'])

    t['b'] = 1
    assert_equal(1, t[:b])
    assert_equal(1, t['b'])
  end

  def test_store
    t = SymbolTable.new

    t.store(:a, 1)
    assert_equal(1, t[:a])
    assert_equal(1, t['a'])

    t.store('b', 1)
    assert_equal(1, t[:b])
    assert_equal(1, t['b'])
  end

  def test_update
    t = SymbolTable.new

    t.update(:a => 1)
    assert_equal(1, t[:a])
    assert_equal(1, t['a'])

    t.update('b' => 1)
    assert_equal(1, t[:b])
    assert_equal(1, t['b'])
  end

  def test_merge!
    t = SymbolTable.new

    t.merge!(:a => 1)
    assert_equal(1, t[:a])
    assert_equal(1, t['a'])

    t.merge!('b' => 1)
    assert_equal(1, t[:b])
    assert_equal(1, t['b'])
  end

  def test_method_missing
    t = SymbolTable.new

    t.a = 1
    assert_equal(1, t[:a])
    assert_equal(1, t['a'])
    assert_equal(1, t.a)
  end

  def test_nested_tables
    t = SymbolTable.new

    t[:a] = {:a => 1}
    assert_equal(1, t.a[:a])
    assert_equal(1, t.a['a'])

    t[:a] = {'a' => 1}
    assert_equal(1, t.a[:a])
    assert_equal(1, t.a['a'])
  end

  def test_key?
    t = SymbolTable.new

    t[:a] = 1
    assert(t.key?(:a))
    assert(t.key?('a'))
  end

  def test_new
    t = SymbolTable[:a, 1]

    assert_equal(1, t[:a])
    assert_equal(1, t['a'])
  end

  def test_merge
    t = SymbolTable.new
    t[:a] = 1
    b = t.merge(:a => 2)

    assert_equal([:a], t.keys)
    assert_equal([1],  t.values)
    assert_equal([:a], b.keys)
    assert_equal([2],  b.values)
  end

end
