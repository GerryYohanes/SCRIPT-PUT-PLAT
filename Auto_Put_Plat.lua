WorldPlat = {}
IdDoorWorldPlat = ""
WorldStoragePlat = " "
IdDoorStoragePlat = ""
LinkWebhook = ""
local bot = getBot() 
bot:setInterval(Action.move,0.025)
bot:setInterval(Action.collect,0.025)
local function warp(world,door)
       bot:warp(world,door)
       sleep(math.random(3,6)*1000)
      while bot.status ~= 1 do
          sleep(50)
       end
end
local function place(id,x,y)
      bot:place(bot.x+x,bot.y+y,id)
end
local function findItem(item)
     return bot:getInventory():findItem(item)
end
local function punch(x,y)
      bot:hit(bot.x + x, bot.y + y)
end
local function Webhooks(message)
    local webhook = Webhook.new(LinkWebhook)
    webhook.embed1.use = true
    webhook.embed1.title = "Auto Put Plat"
    webhook.embed1.description = message
    webhook:send()
end
local function Send(status,botstat)
    Webhooks("Bot : "..bot.name.."\n"..
    "Bot Status : "..botstat.."\n"..
    "World : " ..bot:getWorld().name.."\n"..
    "Status : "..status.."\n")
    
end
local function PutPlat()
    for y = 2,52,2 do 
        for x = 1,98 do
            if bot:getWorld():getTile(x,y).fg == 0 then
                while findItem(102) == 0 do
                    CurWorld = bot:getWorld().name

                    warp(WorldStoragePlat,IdDoorStoragePlat)
                    warp(WorldStoragePlat,IdDoorStoragePlat)
                    bot.auto_collect = true 
                    while findItem(102) == 0 do 
                        bot:collectByID(102)
                        sleep(500)
                    end
                    bot.auto_collect = false
                    warp(CurWorld,IdDoorWorldPlat)
                    warp(CurWorld,IdDoorWorldPlat)
                end
                bot:findPath(x,y-1)
                while bot:getWorld():getTile(x,y).fg == 0 do
                    place(102,0,1)
                    sleep(250)
                end
            end
        end
    end
end
local function IsDonePuttingPlat()
    for y = 2,52,2 do 
        for x = 1,98 do
            if bot:getWorld():getTile(x,y).fg == 0 then
                return false
            end
        end
    end
    return true
end

for i = 1,#WorldPlat do
    warp(WorldPlat[i],IdDoorWorldPlat)
        warp(WorldPlat[i],IdDoorWorldPlat)
        if  IsDonePuttingPlat() == false then
            Send("Start Putting Plat","Online")
            while true do
                if bot.status == 1 then 
                    Send("Stopping  Progress","Offline")
                    while bot.status ~= 1 do
                        sleep(50)
                    end 
                    Send("Starting Progress","Online")
                end
                while bot:getWorld().name ~= WorldPlat[i]:upper() and bot.status == 1 or bot:getWorld():getTile(bot.x,bot.y).fg == 6 do
                    print("warping ",bot:getWorld().name ~= WorldPlat[i]:upper(),bot:getWorld():getTile(bot.x,bot.y).fg == 6)
                    warp(WorldPlat[i],IdDoorWorldPlat)
                end
                while bot.status == 1 and bot:getWorld().name == WorldPlat[i]:upper() and IsDonePuttingPlat() == false do 
                    PutPlat()
                end
                if IsDonePuttingPlat() then
                    break
                end
            end
        end
        if IsDonePuttingPlat() then
            Send("Done Putting Plat","Online")
        end
end
bot:stopScript()