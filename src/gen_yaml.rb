# -*- encoding: UTF-8 -*-
require "./grim"


def makeLineYaml( line , en , cn )
    return %Q[
#-------------------------------#
    #{line} :
        原文 : >-
            #{en}
        譯文 : >-
            #{cn}]
end

def validString( str )
    return false if str.all_blink?
    return false if str.empty?
    return true
end

def makeYaml( )
    txtFileNameList(Path::EN).each do |fileName|
        enFileMap = makeFileMap(Path::EN + fileName)
        cnFileMap = makeFileMap( Path::CN + fileName)
        str = ""
        str << "#{fileName} :\n"
        enFileMap.each_pair do |k,v|
            str << makeLineYaml( k, v, cnFileMap[k] )
        end
        yamlPath = Path::TEXT + fileName[0..-4] + "yml"
        File.open( yamlPath , "w", encoding:"UTF-8") do |file|
            file.write(str)
        end
    end
end

makeYaml()

puts "wtf"
