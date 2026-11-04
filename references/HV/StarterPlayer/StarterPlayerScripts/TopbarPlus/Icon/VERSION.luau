 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=92368439343389

-- ! Source from the asset above; the game may have edited it since.

--[[
--!strict
-- LOCAL
local VERSION = {}



-- SHARED
VERSION.appVersion = "v3.5.0"
VERSION.latestVersion = nil :: string?



-- FUNCTIONS
function VERSION.getLatestVersion(): string?
	local DEVELOPMENT_PLACE_ID = 117501901079852
	local latestVersion = VERSION.latestVersion
	if latestVersion then
		return latestVersion
	end
	local placeName = ""
	while true do
		local success, hdDevelopmentDetails = pcall(function()
			return game:GetService("MarketplaceService"):GetProductInfoAsync(DEVELOPMENT_PLACE_ID)
		end)
		if success and hdDevelopmentDetails then
			placeName = hdDevelopmentDetails.Name
			break
		end
		task.wait(1)
	end
	-- Roblox translates the place name for different languages so only the digits can be trusted
	local versionNumbers = string.match(placeName, "(%d+%.%d+%.%d+)")
	latestVersion = if versionNumbers then "v"..versionNumbers else nil
	VERSION.latestVersion = latestVersion
	return latestVersion
end

function VERSION.getAppVersion()
	return VERSION.appVersion
end

function VERSION.isUpToDate()
	local latestVersion = VERSION.getLatestVersion()
	local appVersion = VERSION.getAppVersion()
	return latestVersion ~= nil and latestVersion == appVersion
end



return VERSION

]]

 

local u1 = {
    appVersion = "v3.4.0",
    latestVersion = nil
};

function u1.getLatestVersion() -- Line: 14
    -- upvalues: u1 (copy)
    local latestVersion = u1.latestVersion;

    if latestVersion or u1.checked then
        return latestVersion;
    end;

    u1.checked = true;
    local v2 = "";

    for i = 1, 4 do
        local success, result = pcall(function() -- Line: 25
            return game:GetService("MarketplaceService"):GetProductInfo(117501901079852);
        end);

        if success and result then
            v2 = result.Name;
            break;
        end;

        if i == 4 then
            warn("TopbarPlus could not check for a newer version: " .. tostring(result));

            return nil;
        end;

        task.wait(2 ^ i);
        local _ = i;
    end;

    local string_match_ret = string.match(v2, "^TopbarPlus (.*)$");

    if string_match_ret then
        string_match_ret = string_match_ret:gsub("%s+", "");
    end;

    u1.latestVersion = string_match_ret;

    return string_match_ret;
end;

function u1.getAppVersion() -- Line: 46
    -- upvalues: u1 (copy)
    return u1.appVersion;
end;

function u1.isUpToDate() -- Line: 50
    -- upvalues: u1 (copy)
    local LatestVersion = u1.getLatestVersion();
    local AppVersion = u1.getAppVersion();

    return LatestVersion == nil and true or LatestVersion == AppVersion;
end;

return u1;