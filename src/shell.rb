
module Shell
    class Script

        def initialize(command, var="", args="", flag="")
            setCommand command
            @flag = ""
            @args = ""
            addFlag flag
            addArg args
            setVar var
            @dir = Dir.pwd
        end

        def reset(command, var="", args="", flag="")
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
                raise "Error: #{e.message}"
            end
            puts
        end

    end
end
