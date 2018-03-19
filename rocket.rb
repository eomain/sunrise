$LOAD_PATH << '.'
require "./shell"
require "./start"

BEGIN {
    puts "Sunrise: the Ruby project manager"
}

COMMANDRUBY = ['-a', '-c', '-C', '-d', '-f', '-e', '-h', '-I', '-L', '-k',
                '-n', '-o', '-p', '-r', 's', '-T', '-v', '-x', 'y', '--copyright',
                '--debug', '--help', '--version', '--verbose', '--yydebug']

VERSION = "0.0.1"
COMMANDLIST = ["launch", "land", "log", "power", "help" "doc", "upgrade, version"]
COMMANDDESC = {"launch" => "Launch a new project",
                "land" => "Build the current project",
                "log" => "Display log file of the current project",
                "help" => "Display this message",
                "power" => "Powerup an existing project",
                "doc" => "Generate docs for existing project",
                "upgrade" => "Commit all changes to git repository",
                "version" => "Display the version of this program"}

def help
    puts "Usage:"
    COMMANDDESC.each_key do |i|
        puts "\t#{i}\t\t#{COMMANDDESC[i]}"
    end
end

ROCKETERR = "Sunrise:"

def argError
    puts "#{ROCKETERR} command '#{COMMAND}' missing expected [argument]"
end


COMMAND = ARGV[0]
OPTIONS = ARGV[1]
EXTRA = ARGV[2]


case COMMAND
when "launch"
    if OPTIONS

        case OPTIONS
        when "-o"
        else
            Option.launch OPTIONS
        end
    else
        argError
    end
when "power"

    case OPTIONS
    when "-v"
        Option.power_v
    when "-i"
        Option.power_i
    when nil
        if COMMANDRUBY.each do |i|
            if EXTRA == i
                true
            else
                false
            end
        end
    end
        Option.power OPTIONS
    else
        help
    end
when "land"
    Option.land
when "log", "-l"
    Option.log
when "doc"
    Option.doc
when "upgrade", "-u"
    Option.upgrade
when "version", "-v"
    puts "Sunrise #{VERSION}"
when "help"
    help
else
    if COMMAND != nil
        puts "Error: unknown command '#{COMMAND}', try typing 'help' for info on usage"
    else
        help
    end
end
