require 'test_helper'
require 'lib/functionparser/partial_input'
require 'pp'

class TestPartialInput < ActiveSupport::TestCase
  
  def test_dummy_partial
    assert true
  end

  def test_read_line
    f = "this is line 1
this is line 2
this is line 3"
    f.each_with_index { |line,i| 
      line_number = line.match(/(\d+)/)[1].to_i
      assert_equal(i+1, line_number)
    }
  end

  correct = "f2 = x1+x4
f1 = x3^2 +x1*x1
f4=x1+x3^2
f2=    0"


  def test_parser_on_empty_input
    correct = ""
    functions = PartialInput.parse_into_hash correct
    assert_nil functions
  end
  
  def test_parser_on_correct_input
    correct = "f2 = x1+x4
f1 = x3^2 +x1*x1
  f4 =x1+x3^2
f2=   x2"
    f = PartialInput.parse_into_hash correct
    assert_not_nil( f, "no hash")
    assert_not_nil( f[1], "f1 empty")
    assert_not_nil(f[2], "f2 empty")
    assert_equal( "x2", f[2], "f[2] not what we expected")
    assert_nil(f[3], "f3 set")
    assert_not_nil(f[4], "f4 empty")
  end
  
  def test_parser_on_correct_input_with_constant
    correct = "f2 = x1+x4+1
f1 = x3^2 +0 +1 +x1*1*x1
f4=1+x1+x3^2
f3 = 1+0*1+   1 *0
f2=    0"
    assert_not_nil PartialInput.parse_into_hash correct
  end
  
  def test_parser_on_false_input
    incorrect = "Hello!"
    assert_nil (PartialInput.parse_into_hash incorrect)
  end

  def test_overwrite_file
    correct = "f1 = x1+x4"
    myfile = "f1 = x1
f2 = x1

f1 = x1
f2 = x1

f1 = x1
f2 = x1"
  f = PartialInput.parse_into_hash correct
  out = PartialInput.overwrite_file(f, myfile)
  assert_equal( "f1 = x1+x4
f2 = x1

f1 = x1+x4
f2 = x1

f1 = x1+x4
f2 = x1", out) 
  end
  
end
