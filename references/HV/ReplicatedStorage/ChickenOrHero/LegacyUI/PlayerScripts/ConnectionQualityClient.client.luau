 

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local ConnectionQualityConfig = require(game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Game"):WaitForChild("ConnectionQualityConfig"));
local ServerBrowser = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ServerBrowser");
local Panel = ServerBrowser:WaitForChild("Panel");
local u1 = 0;
local u2 = nil;
local u3 = true;
local u4 = {};

local function visible() -- Line: 15
    -- upvalues: u3 (ref), LocalPlayer (copy), ServerBrowser (copy), Panel (copy)
    local v5 = u3;

    if v5 then
        if script.Parent == nil or (LocalPlayer.Parent == nil or LocalPlayer:GetAttribute("ServerBrowserOpen") ~= true) then
            v5 = false;
        else
            v5 = ServerBrowser.Enabled and Panel.Visible;
        end;
    end;

    return v5;
end;

local function clearWarning() -- Line: 24
    -- upvalues: u1 (ref), LocalPlayer (copy)
    u1 = 0;
    LocalPlayer:SetAttribute("HighPingWarning", false);
end;

local function stop() -- Line: 29
    -- upvalues: u2 (ref), u1 (ref), LocalPlayer (copy)
    if u2 then
        task.cancel(u2);
        u2 = nil;
    end;

    u1 = 0;
    LocalPlayer:SetAttribute("HighPingWarning", false);
end;

local function u8() -- Line: 38
    -- upvalues: u2 (ref), ConnectionQualityConfig (copy), u3 (ref), LocalPlayer (copy), ServerBrowser (copy), Panel (copy), u1 (ref), u8 (ref)
    u2 = task.delay(ConnectionQualityConfig.PingSampleSeconds, function() -- Line: 39
        -- upvalues: u2 (ref), u3 (ref), LocalPlayer (ref), ServerBrowser (ref), Panel (ref), u1 (ref), ConnectionQualityConfig (ref), u8 (ref)
        u2 = nil;
        local v6 = u3;

        if v6 then
            if script.Parent == nil or (LocalPlayer.Parent == nil or LocalPlayer:GetAttribute("ServerBrowserOpen") ~= true) then
                v6 = false;
            else
                v6 = ServerBrowser.Enabled and Panel.Visible;
            end;
        end;

        if not v6 then
            u1 = 0;
            LocalPlayer:SetAttribute("HighPingWarning", false);

            return;
        end;

        local success, result = pcall(function() -- Line: 45
            -- upvalues: LocalPlayer (ref)
            return LocalPlayer:GetNetworkPing() * 1000;
        end);

        if success and (type(result) == "number" and (result == result and (result ~= (1 / 0) and result >= ConnectionQualityConfig.HighPingMs))) then
            u1 = math.min(ConnectionQualityConfig.HighPingSamples, u1 + 1);
            LocalPlayer:SetAttribute("HighPingWarning", u1 >= ConnectionQualityConfig.HighPingSamples);
        else
            u1 = 0;
            LocalPlayer:SetAttribute("HighPingWarning", false);
        end;

        local v7 = u3;

        if v7 then
            if script.Parent == nil or (LocalPlayer.Parent == nil or LocalPlayer:GetAttribute("ServerBrowserOpen") ~= true) then
                v7 = false;
            else
                v7 = ServerBrowser.Enabled and Panel.Visible;
            end;
        end;

        if v7 then
            u8();

            return;
        end;

        u1 = 0;
        LocalPlayer:SetAttribute("HighPingWarning", false);
    end);
end;

local function updateSampling() -- Line: 62
    -- upvalues: u3 (ref), LocalPlayer (copy), ServerBrowser (copy), Panel (copy), u2 (ref), u1 (ref), u8 (ref)
    local v9 = u3;

    if v9 then
        if script.Parent == nil or (LocalPlayer.Parent == nil or LocalPlayer:GetAttribute("ServerBrowserOpen") ~= true) then
            v9 = false;
        else
            v9 = ServerBrowser.Enabled and Panel.Visible;
        end;
    end;

    if v9 then
        if not u2 then
            u1 = 0;
            LocalPlayer:SetAttribute("HighPingWarning", false);
            u8();
        end;

        return;
    end;

    if u2 then
        task.cancel(u2);
        u2 = nil;
    end;

    u1 = 0;
    LocalPlayer:SetAttribute("HighPingWarning", false);
end;

local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("ServerBrowserOpen");
table.insert(u4, AttributeChangedSignal:Connect(updateSampling));
local PropertyChangedSignal = ServerBrowser:GetPropertyChangedSignal("Enabled");
table.insert(u4, PropertyChangedSignal:Connect(updateSampling));
local PropertyChangedSignal2 = Panel:GetPropertyChangedSignal("Visible");
table.insert(u4, PropertyChangedSignal2:Connect(updateSampling));
script.Destroying:Connect(function() -- Line: 74
    -- upvalues: u3 (ref), u2 (ref), u1 (ref), LocalPlayer (copy), u4 (copy)
    u3 = false;

    if u2 then
        task.cancel(u2);
        u2 = nil;
    end;

    u1 = 0;
    LocalPlayer:SetAttribute("HighPingWarning", false);

    for _, v in u4 do
        v:Disconnect();
    end;

    table.clear(u4);
end);
u1 = 0;
LocalPlayer:SetAttribute("HighPingWarning", false);
local v10 = u3;

if v10 then
    if script.Parent == nil or (LocalPlayer.Parent == nil or LocalPlayer:GetAttribute("ServerBrowserOpen") ~= true) then
        v10 = false;
    else
        v10 = ServerBrowser.Enabled and Panel.Visible;
    end;
end;

if v10 then
    if not u2 then
        u1 = 0;
        LocalPlayer:SetAttribute("HighPingWarning", false);
        u8();
    end;
else
    if u2 then
        task.cancel(u2);
        u2 = nil;
    end;

    u1 = 0;
    LocalPlayer:SetAttribute("HighPingWarning", false);
end;