module Config
    $LAUNCHFILE = "launch.json"

    def Config.open(path, content="")
        launchfile = File.open(path) if File::exists?($LAUNCHFILE)
        unless launchfile
            puts "Error: file '#{$LAUNCHFILE}' not found in directory #{Dir::pwd}"
            launchfile = File.open(path, "w+")
        end
        if !content.eql?("")
            json =  JSON.pretty_generate(content)
            File.write(path, json)
        end
        launchfile
    end

    def Config.read(filename)
        begin
            content = File.read(filename)
        rescue Exception => e
            puts e.message

        end
        return content
    end

    def Config.exists(filename)
        if File::exists?(filename)
            true
        else
            false
        end
    end

    def Config.createDir(dirname)
        begin
            Dir::mkdir(dirname)
        rescue Exception => e
            puts "Error: project '#{dirname}' already exists!"
        end
    end

    def Config.existsDir(dirname)
        if Dir.exists?(dirname)
            true
        else
            false
        end
    end

end
