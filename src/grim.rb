# -*- encoding: UTF-8 -*-
require "rubygems"
require "psych"

class Hash
  def >>( k )
    self.fetch(k)
  end
end

def loadYamlFile( path )
    data = nil
    File.open( path, "r", encoding: "UTF-8" ) do | file |
        fileText = file.read
        begin
            data = Psych.load(fileText)
        rescue Psych::SyntaxError => ex
            $stderr << ex.message
            gets
        end
    end
    return data
end

class File
    def to_a
        self.read.split("\n")
    end
end

class String
    def all_blink?
        self.each_char do |ch|
            case ch
            when "\n", " ", "\r", "\t"
                next
            else
                return false
            end
        end
        return true
    end
end

module Path
    EN = '../res/en/'
    TW = './tw/'
    CN = '../res/cn/'
    TEXT = './text/'
end

def txtFileNameList( path )
    files = Array.new()
    Dir.foreach( path ) do |fileName|
        files << fileName if fileName.end_with?(".txt")
    end
    return files
end

def makeFileMap( filePath )
    filemap = Hash.new
    File.open( filePath, "r", encoding:"UTF-8") do |file|
        lines = file.read.split("\n")
        for i in (0 .. lines.size-1)
            str = lines[i].strip
            next if not validString(str)
            filemap[i] = str
        end
    end
    return filemap
end
