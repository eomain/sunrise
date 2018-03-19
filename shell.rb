require "io"
require "json"

module Platform
    class Project

        def initialize(name, version, main, description="", author="", date="")
            @pname = name
            @pversion = version
            @pmain = main
            @pdescription = description
            @pauthor = author
            @pdate = date
        end

        def getName
            @pname
        end

        def getMain
            @pmain
        end

        def getVersion
            @pversion
        end

        def getAbout
            @pdescription
        end

        def getAuthor
            @pauthor
        end

        def getDate
            @pdate
        end
    end

    class ProjectLoader
        include Config
        LAUNCHFILE = "launch.json"

        def newProject(projdata)
            name = projdata[0]
            dump = {"name" => name,
                    "version" => "0.0.1",
                    "main" => "main.rb",
                    "description" => "",
                    "author" => "",
                    "date" => "",}

            index = 0
            dump.each_key do |i|
                if dump[i].eql?("") and
                        !projdata[index].eql?("") and
                        !projdata[index] == nil
                    dump[i] = projdata[index]
                end
                index += 1
            end

            Config.createDir(name)
            dir = name + "/"
            Config.open LAUNCHFILE, dump
            Config.open "main.rb"
            @pfile = Config.read LAUNCHFILE
            getProject @pfile
        end

        def getProject(json)
            conf = JSON.parse(json)
            return Project.new(conf["name"],
                conf["version"],
                conf["main"],
                conf["description"],
                conf["author"],
                conf["date"])
        end

        def load
            pname = "rocket"
            path = LAUNCHFILE
            if Config.exists(path)
                @pfile = Config.read path
                getProject @pfile
            else
                return nil
            end
        end

        def getProjectFile
            @pfile
        end

        def ProjectLoader.getLaunchFile
            LAUNCHFILE
        end

        private :getProject

    end

end

module Shell
    class Script

        def initialize(command, var, args="", flag="")
            setCommand command
            @flag = ""
            @args = ""
            addFlag flag
            addArg args
            setVar var
            @dir = Dir.pwd
        end

        def reset(command, var, args="", flag="")
            setCommand command
            setVar var
            addFlag flag
            addArg args
        end

        def setCommand(command)
            @command = " " + command + " "
        end

        def setVar(var)
            @var = var
        end

        def addFlag(flag, opt="")
            if !flag.eql?("")
                if !opt.eql?("")
                    opt += " "
                end
                @flag += " -" + flag + " " + opt
            end
        end

        def setArgs(args)
            @args = args
        end

        def addArg(arg)
            @args += " " + arg + " "
        end

        def getCommand
            @command
        end

        def getVar
            @var
        end

        def getDir
            @dir
        end

        def execute
            puts
            command = @command + @flag + @var + @args
            begin
                system(command)
            rescue Exception => e
                puts "Error: #{e.message}"
            end
            puts
        end

    end
end
