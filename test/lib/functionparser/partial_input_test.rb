require 'test_helper'
require 'lib/functionparser/partial_input'

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
    assert PartialInput.parse correct
  end
  
  def test_parser_on_correct_input
    correct = "f2 = x1+x4
f1 = x3^2 +x1*x1
f4=x1+x3^2
f2=   x2"
    assert PartialInput.parse correct
  end
  
  def test_parser_on_correct_input_with_constant
    correct = "f2 = x1+x4+1
f1 = x3^2 +0 +1 +x1*1*x1
f4=1+x1+x3^2
f3 = 1+0*1+   1 *0
f2=    0"
    assert PartialInput.parse correct
  end
  
  def test_parser_on_false_input
    incorrect = "Hello!"
    assert !(PartialInput.parse incorrect)
  end
  
end
