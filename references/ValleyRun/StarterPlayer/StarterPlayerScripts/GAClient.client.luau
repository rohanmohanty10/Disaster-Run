 

 

if not require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).GAEnabled then
    return;
end;

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local MarketplaceService = game:GetService("MarketplaceService");
local Stats = game:GetService("Stats");
local GAEvent = ReplicatedStorage:WaitForChild("GAEvent", 120);
local GA = ReplicatedStorage:FindFirstChild("GA");

if not (GAEvent and GA) then
    return;
end;

local success, result = pcall(require, GA);

if not success then
    return;
end;

local Interface = ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Interface");
local Telemetry = require(Interface:WaitForChild("Telemetry"));
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = {};

local function push(p3, p4, p5) -- Line: 40
    -- upvalues: u2 (copy), u1 (copy)
    if type(p3) ~= "string" then
        return;
    end;

    local v6;

    if p4 == nil then
        v6 = nil;
    else
        v6 = tostring(p4);
    end;

    local v7 = p3 .. "|" .. (v6 or "");
    local os_clock_ret = os.clock();

    if os_clock_ret - (u2[v7] or (-1 / 0)) < 2 or #u1 >= 24 then
        return;
    end;

    u2[v7] = os_clock_ret;
    local v8 = {};

    if type(p5) ~= "number" or p5 ~= p5 then
        p5 = nil;
    end;

    v8[1], v8[2], v8[3] = p3, v6, p5;
    table.insert(u1, v8);
end;

Telemetry.setSink(push);
task.spawn(function() -- Line: 55
    -- upvalues: u1 (copy), result (copy)
    while true do
        local v9;

        repeat
            task.wait(0.75);
            v9 = table.remove(u1, 1);
        until v9;

        pcall(result.trackInteraction, result, v9[1], v9[2], v9[3]);
    end;
end);
local success2, result2 = pcall(require, GA.Client.SessionManager);

if success2 then
    result2:start();
end;

MarketplaceService.PromptProductPurchaseFinished:Connect(function(p10, p11, p12) -- Line: 72
    -- upvalues: LocalPlayer (copy), push (copy)
    if p10 == LocalPlayer.UserId then
        push("purchase_prompt", "product:" .. tostring(p11), p12 and 1 or 0);
    end;
end);
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(p13, p14, p15) -- Line: 77
    -- upvalues: LocalPlayer (copy), push (copy)
    if p13 == LocalPlayer then
        push("purchase_prompt", "pass:" .. tostring(p14), p15 and 1 or 0);
    end;
end);
LocalPlayer:GetAttributeChangedSignal("HighPingWarning"):Connect(function() -- Line: 84
    -- upvalues: LocalPlayer (copy), push (copy)
    if LocalPlayer:GetAttribute("HighPingWarning") == true then
        local success3, result3 = pcall(LocalPlayer.GetNetworkPing, LocalPlayer);
        local v16;

        if success3 then
            v16 = math.floor(result3 * 1000);
        else
            v16 = nil;
        end;

        push("high_ping", nil, v16);
    end;
end);

local function overlayAttribute(p17) -- Line: 91
    -- upvalues: LocalPlayer (copy)
    local v18 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if v18 then
        v18 = v18:FindFirstChild("ScreenOverlay");
    end;

    if v18 then
        v18 = v18:GetAttribute(p17);
    end;

    return v18;
end;

local function ready() -- Line: 98
    -- upvalues: push (copy), LocalPlayer (copy), Interface (copy)
    local v19 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if v19 then
        v19 = v19:FindFirstChild("ScreenOverlay");
    end;

    if v19 then
        v19 = v19:GetAttribute("LoadingExit");
    end;

    local v20 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if v20 then
        v20 = v20:FindFirstChild("ScreenOverlay");
    end;

    if v20 then
        v20 = v20:GetAttribute("LoadingSeconds");
    end;

    push("client_ready", v19 or "unknown", v20);
    local success3, result3 = pcall(require, Interface.InputMode);

    if success3 then
        push("input_mode", result3.get());
        local os_clock_ret = os.clock();
        result3.Changed:Connect(function(p21) -- Line: 104
            -- upvalues: os_clock_ret (ref), push (ref)
            if os.clock() - os_clock_ret >= 60 then
                os_clock_ret = os.clock();
                push("input_mode", p21);
            end;
        end);
    end;

    local success4, result4 = pcall(function() -- Line: 111
        return UserSettings():GetService("UserGameSettings").SavedQualityLevel;
    end);

    if success4 then
        push("graphics_quality", result4.Name, result4.Value);
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        local ViewportSize = workspace_CurrentCamera.ViewportSize;
        push("screen", string.format("%dx%d", ViewportSize.X, ViewportSize.Y), (math.floor(ViewportSize.X)));
    end;
end;

if LocalPlayer:GetAttribute("ClientReady") == true then
    ready();
else
    local u22 = nil;
    u22 = LocalPlayer:GetAttributeChangedSignal("ClientReady"):Connect(function() -- Line: 127
        -- upvalues: LocalPlayer (copy), u22 (ref), ready (copy)
        if LocalPlayer:GetAttribute("ClientReady") == true then
            u22:Disconnect();
            ready();
        end;
    end);
end;

local u23 = 0;
local u24 = 0;
RunService.Heartbeat:Connect(function(p25) -- Line: 137
    -- upvalues: u23 (ref), u24 (ref)
    u23 = u23 + 1;
    u24 = u24 + p25;
end);
task.spawn(function() -- Line: 141
    -- upvalues: u24 (ref), push (copy), u23 (ref), Stats (copy)
    while true do
        task.wait(120);

        if u24 > 0 then
            push("perf", "fps", (math.floor(u23 / u24 + 0.5)));
        end;

        u23 = 0;
        u24 = 0;
        local success3, result3 = pcall(Stats.GetTotalMemoryUsageMb, Stats);

        if success3 then
            push("perf", "memory_mb", (math.floor(result3)));
        end;
    end;
end);