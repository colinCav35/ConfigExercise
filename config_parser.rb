

class ConfigParser
  @@true_values = [ "true", "on", "yes" ]
  @@false_values = [ "false", "off", "no" ]

  def initialize(filename)
    @filename = filename
  end

  def read_config()
    configuration = {}
    line_number = 0

    File.foreach(@filename) do |line|
      line_number += 1

      # remove comments and newline
      line = line.strip.slice(0, line.index('#')) if line.index('#')

      # ignore comment only or blank lines
      next if line.length == 0

      # split each line on the = and strip whitespace
      if line.index('=')
        key = line.slice(0, line.index("=")).strip
        value = line.slice(line.index("=") + 1 .. -1).strip

        # parse value type and add to config hash
        configuration[key] = parse_input_type(value)
      else
        raise IOError.new("Parser error on line #{line_number}")
      end
    end

    return configuration
  end

  private

  def parse_input_type(input)
    return input.to_i if input.to_i.to_s == input # integers
    return input.to_f if input.to_f.to_s == input # floats
    return true if @@true_values.include? input.downcase # boolean true
    return false if @@false_values.include? input.downcase # boolean false

    return input # string
  end
end
