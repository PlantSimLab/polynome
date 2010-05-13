# take the partial information given by the user 
# and overwrite the reverse engineered information

class PartialInput  

  # if the string given is good function data, return a hash with the functions for the variables listed, otherwise return nil
  def self.parse_into_hash s
    puts s
    functions = Hash.new

    s.each {|line|
      case line
        when /^\s*f\d+\s*=\s*(x\d+(\s*\^\s*\d+)?|(0|1))\s*((\+|\*)\s*(x\d+(\s*\^\s*\d+)?|(0|1))\s*)*\s*$/
          # we are assuming this is a correct line without checking the bounds for subscripts
          variable = line.match(/^\s*f(\d+)/)[1].to_i
          function= line.match(/^.*=\s*(.*)/)[1]
          puts "f#{variable} = #{function}"
          functions[variable] = function
          puts "overwriting function for variable #{variable}"
          next
        when /^\s*$/
          # empty lines are ok 
          next
        else 
          puts ("bad line :#{line}:")
          return nil 
      end
    }
    if functions.empty? 
      nil
    else 
      functions
    end
  end

  # overwrite all fi in multifile with functions[i]
  def self.overwrite_file(functions, myfile)
    m = Hash.new
    myfile.each_with_index{ |line, index|
      m[index] = line
    }
    m.each{ |k,v|
      match = v.match(/^\s*f(\d+)\s*=/)
      if !match.nil?
        variable = match[1].to_i
        if functions.has_key?(variable)
          m[k] = "f#{variable} = #{functions[variable]}\n"
          puts "replaced m[#{k}] with #{m[k]}"
        end
      end
    }
    m.sort.collect{|pair|pair[1]}.to_s
  end
    
end
