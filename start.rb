require "./shell"
require "./setup"
require "./io"


module Option
    Projectload = Platform::ProjectLoader.new
    $proj = Projectload.load

    def Option.launch(opt)
        if projectExist opt
            puts "Creating new project '#{opt}'"
            projinfo = getProjectInfo(opt)
            $proj = Projectload.newProject projinfo
        else
            puts "Error: cannot launch in an already existing directory"
        end
    end

    def Option.power(opt)
        begin
            puts "Powering up #{$proj.getName} engine...."
            pargs = opt
            if opt == nil
                pargs = ""
            end
            cshell = Shell::Script.new("ruby", $proj.getMain, args=pargs)
            puts "\tPreparing for take off => #{cshell.getVar}"
            cshell.execute
            puts "Powering down #{$proj.getName} engine...."
        rescue Exception => e
            puts "Error: cannot powerup a project without '#{Platform::ProjectLoader.getLaunchFile}'"
        end
    end

    def Option.power_v
        puts "#{$proj.getName} #{$proj.getVersion}"
    end

    def Option.power_i
        puts "About #{$proj.getName}:"
        puts "#{$proj.getAbout}"
    end

    def Option.land
        puts "This feature is currently unavailable"
    end

    def Option.log
        puts "This feature is currently unavailable"
    end

    def Option.doc
        puts "Generating docs for '#{$proj.getName}'...."
    end

    def Option.upgrade
        puts "Commiting all changes to #{$proj.getName}"
    end

    def Option.projectExist(opt)
        launchpath = File.join(opt, Platform::ProjectLoader.getLaunchFile)
        unless !Config.exists launchpath or !Config.existsDir opt
            false
        else
            true
        end
    end
end

def getProjectInfo(name)
    begin

    print "Enter the software version(default is '0.0.1') : "
    version = STDIN.gets.chomp

    print "Enter main project filename(default is main.rb) : "
    main = STDIN.gets.chomp

    puts "Enter your project description: "
    description = STDIN.gets.chomp

    print "Enter the name of the author: "
    author = STDIN.gets.chomp

    time = Time.new
    date = time.strftime("%d-%m-%Y %H:%M:%S")
    puts date

    puts "These settings can be modified later in the file 'launch.json'"

    rescue Exception => e
        puts e.message
    end

    return name, version, main, description, author, date
end
