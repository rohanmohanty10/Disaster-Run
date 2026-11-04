  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Configs.SalaryConfig);
require(ReplicatedStorage.Shared.Popup);
local LocalPlayer = Players.LocalPlayer;
local u1 = nil;

local function getPlayerAvatar() -- Line: 14
    -- upvalues: u1 (ref), Players (copy), LocalPlayer (copy)
    if u1 then
        return u1;
    end;

    local success, result = pcall(function() -- Line: 16
        -- upvalues: Players (ref), LocalPlayer (ref)
        return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150);
    end);

    if not (success and result) then
        return "";
    end;

    u1 = result;

    return result;
end;

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local v2 = Knit.CreateController({
    Name = "NelLeagueController"
});

local function commas(p3) -- Line: 38
    local v4 = tonumber(p3) or 0;
    local math_floor_ret = math.floor(v4);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

local function yenStr(p5) -- Line: 43
    -- upvalues: commas (copy)
    return string.format("¥ %s", commas(p5));
end;

function v2.KnitStart(p6) -- Line: 50
    -- upvalues: PlayerGui (copy)
    local NelLeague = PlayerGui:FindFirstChild("NelLeague");

    if NelLeague then
        NelLeague.Enabled = false;
    end;
end;

return v2;