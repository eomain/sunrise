
module FileIO

    def FileIO.open(path, content="")
        begin
            launchfile = File.open(path) if File::exists?(path)
            unless launchfile
                launchfile = File.open(path, "w+")
            end
            if !content.eql?("")
                json =  JSON.pretty_generate(content)
                File.write(path, json)
            end
            launchfile
        rescue Exception => e
            raise "Error: #{e.message}"
        end
    end

    def FileIO.read(filename)
        begin
            content = File.read(filename)
        rescue Exception => e
            raise e.message

        end
        return content
    end

    def FileIO.exists(filename)
        if File::exists?(filename)
            true
        else
            false
        end
    end

    def FileIO.createDir(dirname)
        begin
            Dir::mkdir(dirname)
        rescue Exception => e
            raise "Error: project '#{dirname}' already exists!"
        end
    end

    def FileIO.existsDir(dirname)
        if Dir.exists?(dirname)
            true
        else
            false
        end
    end

end
