  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalizationService = game:GetService("LocalizationService");
local Players = game:GetService("Players");
game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Popup = require(ReplicatedStorage.Shared.Popup);
local FormatNumber = require(ReplicatedStorage.Shared.FormatNumber);
local RunService = game:GetService("RunService");
local environment = require(ReplicatedStorage.Shared.environment);
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local v2 = { "BR", "AQ", "AR", "BO", "CL", "CO", "EC", "FK", "GF", "GY", "PY", "PE", "SR", "UY", "VE" };
local v3 = { "BD", "BT", "IO", "BN", "KH", "CN", "CX", "CC", "HK", "IN", "ID", "LA", "MO", "MY", "MV", "MN", "MM", "NP", "PK", "PH", "SG", "LK", "TW", "TH", "TL", "VN", "KP", "AS", "AU", "CK", "FJ", "PF", "TF", "GU", "HM", "KI", "KR", "MH", "FM", "NR", "NC", "NZ", "NU", "NF", "MP", "PW", "PN", "SB", "WS", "TK", "TO", "TV", "UM", "VU", "WF", "JP" };

for _, v in { "US", "CA", "AI", "AG", "AW", "BB", "BM", "DM", "GD", "JM", "MS", "PR", "BL", "KN", "LC", "MF", "PM", "VC", "SX", "TC", "TT", "VG", "VI", "BZ", "BQ", "CR", "CW", "DO", "SV", "GP", "GT", "HT", "MQ", "MX", "AN", "NI", "PA", "CU" } do
    u1[v] = "NA";
end;

for _, v in v2 do
    u1[v] = "SA";
end;

for _, v in v3 do
    u1[v] = "ASIA";
end;

local function detectRegion() -- Line: 31
    -- upvalues: LocalizationService (copy), LocalPlayer (copy), u1 (copy)
    local success, result = pcall(function() -- Line: 32
        -- upvalues: LocalizationService (ref), LocalPlayer (ref)
        return LocalizationService:GetCountryRegionForPlayerAsync(LocalPlayer);
    end);

    return success and result and (u1[result] or "EU") or "EU";
end;

local v4 = Knit.CreateController({
    Name = "RankedController"
});
local u5 = "TEST";
local u6 = false;
local u7 = 0;
local u8 = "";
local u9 = nil;
local u10 = nil;
local u11 = nil;

local function formatTime(p12) -- Line: 55
    local math_floor_ret = math.floor(p12 / 60);
    local math_floor_ret2 = math.floor(p12 % 60);

    return string.format("%02d:%02d", math_floor_ret, math_floor_ret2);
end;

function v4.IsQueued(p13) -- Line: 61
    -- upvalues: u6 (ref)
    return u6;
end;

local function showQueueUI(p14) -- Line: 65
    -- upvalues: u9 (ref), LocalPlayer (copy), u8 (ref), u10 (ref), RunService (copy), u6 (ref), u7 (ref), FormatNumber (copy)
    if not u9 then
        u9 = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("QueueUI");
    end;

    if not u9 then
        return;
    end;

    u8 = p14 or "";
    u9.Matchmaking.Title.Text = "Searching for Ranked " .. u8;
    u9.Matchmaking.Time.Text = "00:00";
    u9.Enabled = true;

    if u10 then
        u10:Disconnect();
    end;

    u10 = RunService.Heartbeat:Connect(function() -- Line: 80
        -- upvalues: u6 (ref), u7 (ref), u9 (ref), FormatNumber (ref)
        if not u6 then
            return;
        end;

        local v15 = tick() - u7;
        local math_floor_ret = math.floor(v15);
        u9.Matchmaking.Time.Text = FormatNumber.AdaptiveClockString(math_floor_ret, true);
    end);
end;

local function hideQueueUI() -- Line: 87
    -- upvalues: u10 (ref), u9 (ref)
    if u10 then
        u10:Disconnect();
        u10 = nil;
    end;

    if u9 then
        u9.Enabled = false;
    end;
end;

function v4.GetRegion(p16) -- Line: 97
    -- upvalues: environment (copy), u5 (ref)
    return environment.env == "Dev" and "TEST" or u5;
end;

function v4.KnitStart(p17) -- Line: 102
    -- upvalues: u11 (ref), Knit (copy), u5 (ref), LocalizationService (copy), LocalPlayer (copy), u1 (copy), u6 (ref), u7 (ref), showQueueUI (copy), u10 (ref), u9 (ref), Popup (copy)
    u11 = Knit.GetService("RankedService");
    local success, result = pcall(function() -- Line: 32
        -- upvalues: LocalizationService (ref), LocalPlayer (ref)
        return LocalizationService:GetCountryRegionForPlayerAsync(LocalPlayer);
    end);
    u5 = success and result and (u1[result] or "EU") or "EU";
    u11.QueueStatus:Connect(function(p18, p19) -- Line: 106
        -- upvalues: u6 (ref), u7 (ref), showQueueUI (ref), u10 (ref), u9 (ref), Popup (ref), LocalPlayer (ref)
        if p18 ~= "Queued" then
            if p18 == "Cancelled" then
                u6 = false;

                if u10 then
                    u10:Disconnect();
                    u10 = nil;
                end;

                if u9 then
                    u9.Enabled = false;
                end;

                if p19 then
                    Popup.Popup(LocalPlayer, p19);

                    return;
                end;
            else
                if p18 == "MatchFound" then
                    u6 = false;

                    if u10 then
                        u10:Disconnect();
                        u10 = nil;
                    end;

                    if u9 then
                        u9.Enabled = false;
                    end;

                    Popup.Popup(LocalPlayer, "Match found!");

                    return;
                end;

                if p18 == "Teleporting" then
                    u6 = false;

                    if u10 then
                        u10:Disconnect();
                        u10 = nil;
                    end;

                    if u9 then
                        u9.Enabled = false;
                    end;

                    Popup.Popup(LocalPlayer, "Teleporting to match...");

                    return;
                end;

                if p18 == "Failed" then
                    u6 = false;

                    if u10 then
                        u10:Disconnect();
                        u10 = nil;
                    end;

                    if u9 then
                        u9.Enabled = false;
                    end;

                    Popup.Popup(LocalPlayer, p19 or "Failed to queue");
                end;
            end;

            return;
        end;

        u6 = true;
        u7 = tick();
        showQueueUI(p19);
    end);

    if not u9 then
        u9 = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("QueueUI");
    end;

    if u9 then
        u9.Enabled = false;
        local ExitQueue = u9.Matchmaking:FindFirstChild("ExitQueue");

        if ExitQueue then
            ExitQueue.Activated:Connect(function() -- Line: 137
                -- upvalues: u6 (ref), u11 (ref)
                if u6 then
                    u11:LeaveQueue();
                end;
            end);
        end;
    end;
end;

function v4.ShowQueueUI(p20, p21) -- Line: 146
    -- upvalues: u6 (ref), u7 (ref), showQueueUI (copy)
    u6 = true;
    u7 = tick();
    showQueueUI(p21);
end;

function v4.HideQueueUI(p22) -- Line: 152
    -- upvalues: u10 (ref), u9 (ref)
    if u10 then
        u10:Disconnect();
        u10 = nil;
    end;

    if u9 then
        u9.Enabled = false;
    end;
end;

return v4;