# -*- encoding: UTF-8 -*-
require "./grim"

def makeTwText()
    Dir.mkdir(Path::TW) unless File.exists?(Path::TW)
    txtFileNameList(Path::EN).each do |fileName|
        yaml = loadYamlFile( Path::TEXT + fileName[0..-4] + "yml" )
        outFile = File.new( Path::TW + fileName, "w", encoding: "UTF-8" )
        enText = File.new( Path::EN + fileName, "r", encoding: "UTF-8").to_a
        if yaml == false
            puts fileName
        end
        yaml["內文"].each_pair do |k,v|
            enText[k] = v["譯文"]
        end
        outStr = ""
        enText.each do |line|
            outStr << "#{line}\n"
        end
        outFile.write(outStr)
        outFile.close
    end
end

makeTwText()
