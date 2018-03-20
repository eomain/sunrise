module Config
    $LAUNCHFILE = "launch.json"

    def Config.open(path, content="")
        begin
            launchfile = File.open(path) if File::exists?(path)
            unless launchfile
                puts "Error: file '#{$LAUNCHFILE}' not found in directory #{Dir::pwd}"
                launchfile = File.open(path, "w+")
            end
            if !content.eql?("")
                json =  JSON.pretty_generate(content)
                File.write(path, json)
            end
            launchfile
        rescue Exception => e
            print "Error: #{e.message}"
        end
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
