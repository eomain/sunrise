require "sunrise/shell"
require "sunrise/fileio"

    class GitControl
        @currbranch

        def initialize(branchname="")
            @gitshell = GitShell.new
            unless branchname.empty?
                @gitshell.set_branch branchname
                @gitshell.git_checkout branchname
                @currbranch = branchname
            end
        end

        def upgrade
            @gitshell.git_commit_all
        end

        def push_remote(location="")
            @gitshell.upgrade
            unless location.empty?
                @gitshell.set_location location
            end
            @gitshell.git_remote
        end

    end


    class GitShell < Shell::Script

        @gitcommand = "git"
        @@branch = "master"
        @@location = "origin"

        def git_init
            puts "Initializing Git repository"
            run("init")
            puts "Completed!"
        end

        def git_checkout(branch)
            run("checkout", branch)
            @@branch = branch
        end

        def git_remote
            run("remote #{@@location} #{@@branch}")
        end

        def git_commit_all
            run("add", ".")
            run("commit")
            puts "Successfully committed to #{$branch}"
        end

        def run(var, args="", flag="")
            command = @gitcommand
            reset(command, var, args="", flag="")
            execute
        end

        def has_git
            FileIO.existsDir ".git"
        end

        def set_branch(name)
            @@branch = name
        end

        def set_location(name)
            @@location
        end

        def initialize
            @gitcommand = "git"
            super(@gitcommand)
            unless has_git
                git_init
            end
        end

    end
