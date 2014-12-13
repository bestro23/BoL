local version = "2.22"


local autoupdateenabled = true
local UPDATE_SCRIPT_NAME = "PotionActivator"
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/ajgoreq/BoL/master/PotionActivator.lua"
local UPDATE_FILE_PATH = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH

local ServerData
if autoupdateenabled then
	GetAsyncWebResult(UPDATE_HOST, UPDATE_PATH, function(d) ServerData = d end)
	function update()
		if ServerData ~= nil then
			local ServerVersion
			local send, tmp, sstart = nil, string.find(ServerData, "local version = \"")
			if sstart then
				send, tmp = string.find(ServerData, "\"", sstart+1)
			end
			if send then
				ServerVersion = tonumber(string.sub(ServerData, sstart+1, send-1))
			end

			if ServerVersion ~= nil and tonumber(ServerVersion) ~= nil and tonumber(ServerVersion) > tonumber(version) then
				DownloadFile(UPDATE_URL.."?nocache"..myHero.charName..os.clock(), UPDATE_FILE_PATH, function () print("<font color=\"#FF0000\"><b>"..UPDATE_SCRIPT_NAME..":</b> successfully updated. Reload (double F9) Please. ("..version.." => "..ServerVersion..")</font>") end)     
			elseif ServerVersion then
				print("<font color=\"#FF0000\"><b>"..UPDATE_SCRIPT_NAME..":</b> You have got the latest version: <u><b>"..ServerVersion.."</b></u></font>")
			end		
			ServerData = nil
		end
	end
	AddTickCallback(update)
end

function OnLoad()
  Config:addParam("ahp", "AutoHealthPotions", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("U"))
  Config:addParam("amp", "AutoManaPotions", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("U"))
  Config:addParam("aza", "AutoZhonya", SCRIPT_PARAM_ONKEYTOGGLE, false, string.byte("U"))
end

function OnTick()
 if (Config.ahp) then
    if myHero.health < 200 then
        local hpPot = GetInventorySlotItem(2003)
        if (hpPot ~= nil and myHero:CanUseSpell(hpPot) == READY)
            then CastSpell(hpPot)
        end
    end
 end
  if (Config.amp) then
    if myHero.mana < 200 then
        local manaPot = GetInventorySlotItem(2004)
        if (manaPot ~= nil and myHero:CanUseSpell(manaPot) == READY)
            then CastSpell(manaPot)
        end
    end
	end
	 if (Config.aza) then
		if myHero.health < 100 then
        local zhonya = GetInventorySlotItem(3157)
        if (zhonya ~= nil and myHero:CanUseSpell(zhonya) == READY)
            then CastSpell(zhonya)
        end
    end
end
end
