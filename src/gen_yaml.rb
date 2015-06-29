# -*- encoding: UTF-8 -*-
require "./grim"


def makeInfo(fileName, state: "未翻譯", comment: "無")
return %Q[
#--------------------------------------------------------#
# 資訊->狀態的種類："已審核"、"未翻譯"、"翻譯中"、"待審核" #
#--------------------------------------------------------#
資訊 :
    檔名 : #{fileName}
    狀態 : #{state}
    註解 : >-
        #{comment}
#--------------------------------------------------------#
內文 :
]
end

def makeLineYaml( line , en , cn )
    return %Q[
#------------- 第 #{line+1} 行 -------------#
    #{line} :
        原文 : >-
            #{en}
        譯文 : >-
            #{cn}]
end

def validString( str )
    return false if str.all_blink?
    return false if str.empty?
    return false if str[0] == "#"
    return true
end

def makeYaml( )
    txtFileNameList(Path::EN).each do |fileName|
        enFileMap = makeFileMap(Path::EN + fileName)
        cnFileMap = makeFileMap( Path::CN + fileName)
        str = makeInfo(fileName)
        enFileMap.each_pair do |k,v|
            next if not validString(v)
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
