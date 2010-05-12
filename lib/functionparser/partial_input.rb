# take the partial information given by the user 
# and overwrite the reverse engineered information

class PartialInput  
  def self.parse s
    s.each {|line|
      case line
        when /^\s*f\d+\s*=\s*(x\d+(\s*\^\s*\d+)?|(0|1))\s*((\+|\*)\s*(x\d+(\s*\^\s*\d+)?|(0|1))\s*)*\s*$/
          # we are assuming this is a correct line without checking the bounds for subscripts
          input_f = true 
          variable = line.match(/^\s*f(\d+)/)[1]
          puts ("overwriting function for variable #{variable}")
          next
        when /^\s*$/
          next
        else 
          puts ("bad line")
          return false
      end
    }
    true 
  end
end
