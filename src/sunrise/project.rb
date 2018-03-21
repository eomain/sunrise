require "sunrise/shell/gitscript"
require "sunrise/fileio"
require "json"

module Platform
    class Project

        @email = ""
        @repository = ""
        @homepage = ""
        @license = ""
        @dependencies = {}
        @log

        attr_reader :container

        def initialize(name, version, main, description="", author="", date="")
            @pname = name
            @pversion = version
            @pmain = main
            @pdescription = description
            @pauthor = author
            @pdate = date
            @git = GitControl.new

            setContainer

        end

        def setContainer
            @container = {
                "name" => @pname,
                "version" => @pversion,
                "main" => @pmain,
                "description" => @pdescription,
                "author" => @pauthor,
                "date" => @pdate,
            }
        end

        def upgrade
            @git.upgrade
        end

        def push
            @git.push_remote
        end

        def update_project
            dump = JSON.parse(self.container)
            FileIO.open "", dump
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
        include FileIO
        LAUNCHFILE = "launch.json"
        SOURCEDIR = "src/"

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
                if !projdata[index].empty? and
                        projdata[index] != nil
                    dump[i] = projdata[index]
                end
                index += 1
            end

            FileIO.createDir(name)
            _launch = File.join(name, LAUNCHFILE)
            _source = File.join(name, SOURCEDIR)
            FileIO.open _launch, dump
            FileIO.createDir _source
            FileIO.open File.join(_source, dump["main"])
            @pfile = FileIO.read _launch
            puts "Project #{name} has been created!",
            "Use command 'cd #{name}' to enter the project root"
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
            path = LAUNCHFILE
            if FileIO.exists(path)
                @pfile = FileIO.read path
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
