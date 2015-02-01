-- AutoUpdater
local version = "Beta"


local autoupdateenabled = true
local UPDATE_SCRIPT_NAME = "AhriX"
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/ajgoreq/BoL/master/AhriX.lua"
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

-- Lib Updater
local REQUIRED_LIBS = {
	["SxOrbWalk"] = "https://raw.githubusercontent.com/Superx321/BoL/master/common/SxOrbWalk.lua"
	}

local DOWNLOADING_LIBS, DOWNLOAD_COUNT = false, 0

function AfterDownload()
	DOWNLOAD_COUNT = DOWNLOAD_COUNT - 1
	if DOWNLOAD_COUNT == 0 then
		DOWNLOADING_LIBS = false
		print("<b><font color=\"#6699FF\">Required libraries downloaded successfully, please reload (double F9).</font>")
	end
end

for DOWNLOAD_LIB_NAME, DOWNLOAD_LIB_URL in pairs(REQUIRED_LIBS) do
	if FileExist(LIB_PATH .. DOWNLOAD_LIB_NAME .. ".lua") then
		require(DOWNLOAD_LIB_NAME)
	else
		DOWNLOADING_LIBS = true
		DOWNLOAD_COUNT = DOWNLOAD_COUNT + 1
		DownloadFile(DOWNLOAD_LIB_URL, LIB_PATH .. DOWNLOAD_LIB_NAME..".lua", AfterDownload)
	end
end


if FileExist(LIB_PATH.."SxOrbWalk.lua") then
	SxOrbloaded = true
end 
require "Collision"

--[[Encrypt by me]]--
assert(load(Base64Decode("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IHggBAIgICB6IAQHICAgYWhyaXh3IAQDICAgX1cgBAMgICBfUSAEECAgIG1pbmlvbkNvbGxpc2lvbiAEAyAgIF9FICAgICAJICAgICABAwEHAQEBBQEgAQQBAgEGICAgICAgICAgICAgICAgIGwgICByICAgICADKSAgIAYgxZQgDEBAIOKAoOKCrMWUIB3igqzigqwBRsWUxZQgWEAgIBcgIOKCrANAICADIOKCrCAJICAgBiDFlCAMQEAg4oCgIMOBIB3igqzigqwBRsWUxZQgWEAgIBcgIOKCrANAICADIOKCrCAJICABBiDFlCAMQEAg4oCgQMOBIB3igqzigqwBRsWUxZQgWEAgIBcgIOKCrANAICADIOKCrCAJIOKCrAEGIMWUIAxAQCDigKDigqzDgSAd4oKs4oKsAUbFlMWUIFhAICAXICDigqwDQCAgAyDigqwgCSAgAh8g4oKsIAcgICAEByAgIG15SGVybyAEDCAgIENhblVzZVNwZWxsIAQDICAgX1EgBAYgICBSRUFEWSAEAyAgIF9XIAQDICAgX0UgBAMgICBfUiAgICAgBSAgIAEgICABAQECAQMgICAgICAgICAgICAgICAgdCAgIMKBICAgICAFISAgIAYgQCAMQEAgHUAgAQYgQCAH4oKsQCAbQCAgFyAg4oKsHyDigqwgRsWUQCDigqwgICBd4oKsIAFbICAgF+KCrATigqxFIOKCrCBbICAgF8WUA+KCrEYgQSDigqwgICBd4oKsIAHigKYgIAEZ4oKs4oKsIBdAAuKCrEZAQSBH4oKsw4EgR+KCrMOBIFsgICAXIAHigqxGxZRBIOKAoCBCIMOHQEIgB8KBQiBdQCACHyDigqwgCyAgIAQDICAgdHMgBAcgICB1cGRhdGUgBAcgICB0YXJnZXQgBAwgICBWYWxpZFRhcmdldCAEDCAgIEdldERpc3RhbmNlIAQMICAgQ29uZmlnYWhyaXggBAcgICBoYXJhc3MgBA0KICAgQ2FzdFNwZWxsIAQDICAgX1EgBAIgICB4IAQCICAgeiAgICAgAyAgICAgASABBCAgICAgICAgICAgICAgICABICAgASAgICAgICAgICAgICAgICAg"), nil, "bt", _ENV))()
	--End
