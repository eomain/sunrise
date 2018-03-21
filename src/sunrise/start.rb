require "sunrise/project"
require "sunrise/shell"
require "sunrise/fileio"
require "sunrise/userprompt"


module Option
    Projectload = Platform::ProjectLoader.new
    PFile = Platform::ProjectLoader.getLaunchFile
    $proj = Projectload.load

    def Option.launch(opt)
        if projectExist opt
            puts "Creating new project '#{opt}'"
            projinfo = projectPrompt(opt)
            $proj = Projectload.newProject projinfo
        else
            raise "Error: cannot launch in an already existing directory"
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
            puts "Error: cannot powerup a project without '#{PFile}'"
        end
    end

    def Option.power_v
        begin
            puts "#{$proj.getName} #{$proj.getVersion}"
        rescue
            puts "Error: cannot powerup a project without '#{PFile}'"
        end

    end

    def Option.power_i
        begin
            puts "About #{$proj.getName}:"
            puts "#{$proj.getAbout}"
        rescue
            puts "Error: cannot powerup a project without '#{PFile}'"
        end
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
        unless !FileIO.exists launchpath or !FileIO.existsDir opt
            false
        else
            true
        end
    end
end
