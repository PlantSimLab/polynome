# take the partial information given by the user 
# and overwrite the reverse engineered information

class PartialInput  

  # if the string given is good function data, return a hash with the functions for the variables listed, otherwise return nil
  def self.parse_into_hash s
    puts s
    functions = Hash.new
    function_list_state = false
    function_state = false
    variable = 0
    s.each {|line|
      line.gsub!(/\s/, '')
      # we are assuming this is a correct line without checking the bounds for subscripts
      #when /^\s*f\d+\s*=\s*(x\d+(\s*\^\s*\d+)?|(0|1))\s*((\+|\*)\s*(x\d+(\s*\^\s*\d+)?|(0|1))\s*)*\s*$/
      if line.match /^f(\d+)=(.*)$/
        variable = $1.to_i
        puts "starting with variable #{variable}"
        functions[variable] = ""
        line = $2
        puts "This is the rest of the line #{line}"
        function_state = true
      end
      if line.match /(\{)/
        puts "this should be {: #{$1}"
        function_list_state = true
      end
      if (function = line.match /((x\d+(\^\d+)?)|0|1)((\+|\*)((x\d+(\^\d+)?)|0|1))*(\#\d+)?/ )
        puts "Found function #{function}"
        puts function.to_s
        pp function
        puts variable
        if !function_state
          puts "some error..." 
          return nil
        end
        functions[variable] = functions[variable] + function.to_s # +"\n"
        puts "functions[variable]: #{functions[variable]}"
      end
      if line.match /\}\s*$/
        if !function_list_state
          puts "there is a closing } without being opened before"
          return nil
        end
        function_list_state = false
        function_state = false
      end
#      when /^\s*$/   # empty lines are ok 
#        next
#      else 
#        puts "bad line :#{line}:"
#        return nil 
#      end
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
