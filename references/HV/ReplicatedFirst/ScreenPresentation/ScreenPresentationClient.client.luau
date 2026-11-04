 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("ContentProvider");
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local TeleportService = game:GetService("TeleportService");
local LocalPlayer = Players.LocalPlayer;
local script_Parent = script.Parent;
local table_clone_ret = table.clone(require(script_Parent.ScreenConfig));
local u1 = table_clone_ret.LoadingScreenEnabled == false;
local success, result = pcall(function() -- Line: 13
    -- upvalues: TeleportService (copy)
    return TeleportService:GetLocalPlayerTeleportData();
end);

if success then
    if type(result) == "table" then
        success = result.cohRefresh == true;
    else
        success = false;
    end;
end;

if success then
    table_clone_ret.MinimumLoadingTime = table_clone_ret.ReturnMinimumLoadingTime;
    table_clone_ret.LightingSettleTime = table_clone_ret.ReturnLightingSettleTime;
end;

local u2 = script_Parent.ScreenOverlay:Clone();
u2.Enabled = true;
u2.Parent = LocalPlayer:WaitForChild("PlayerGui");

if not u1 then
    LocalPlayer:SetAttribute("ScreenPresentationActive", true);
end;

ReplicatedFirst:RemoveDefaultLoadingScreen();
local u3 = require(script_Parent.IrisController).new(u2, table_clone_ret);
local u4 = require(script_Parent.LoadingProgress).new(u2, table_clone_ret);
local u5 = true;
local u6 = nil;
local u7 = false;
local u8 = nil;
local u9 = true;
local u10 = require(script_Parent.ReadyHandshake).new(LocalPlayer, function() -- Line: 35
    -- upvalues: u9 (ref)
    return u9;
end);

local function updateRoutePresentation() -- Line: 38
    -- upvalues: u2 (copy), u5 (ref), u1 (copy), success (copy)
    u2.Loading.Visible = u5 and not u1;
    u2.Loading.Eyebrow.Text = success and "WELCOME BACK" or "WELCOME TO";
    u2.Loading.Status.Text = success and "Joining other players…" or "Ready for the chase?";
end;

u2.Loading.Visible = u5 and not u1;
u2.Loading.Eyebrow.Text = success and "WELCOME BACK" or "WELCOME TO";
u2.Loading.Status.Text = success and "Joining other players…" or "Ready for the chase?";

if u1 then
    u3:forceOpen();
end;

local os_clock_ret = os.clock();
u2:SetAttribute("LoadingStartedAt", workspace:GetServerTimeNow());

local function essentialsReady(p11) -- Line: 49
    -- upvalues: LocalPlayer (copy)
    local ChickenOrHero = game.ReplicatedStorage:FindFirstChild("ChickenOrHero");

    if ChickenOrHero then
        ChickenOrHero = ChickenOrHero:FindFirstChild("Game");
    end;

    local Character = LocalPlayer.Character;
    local v12;

    if Character then
        v12 = Character:FindFirstChild("HumanoidRootPart");
    else
        v12 = Character;
    end;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    if game:IsLoaded() or p11 == true then
        local v13 = ChickenOrHero and (ChickenOrHero:FindFirstChild("PlayerPreferences") and (v12 and v12:IsDescendantOf(workspace)));

        if v13 then
            if Character then
                if Character.Health > 0 then
                    Character = workspace.CurrentCamera ~= nil;
                else
                    Character = false;
                end;
            end;
        else
            Character = v13;
        end;
    else
        Character = false;
    end;

    return Character;
end;

local function release() -- Line: 64
    -- upvalues: LocalPlayer (copy), essentialsReady (copy), u10 (copy)
    LocalPlayer:SetAttribute("ScreenPresentationActive", nil);

    if LocalPlayer:GetAttribute("InitialLoadingComplete") ~= true and not essentialsReady(true) then
        return;
    end;

    if LocalPlayer:GetAttribute("InitialLoadingComplete") ~= true then
        LocalPlayer:SetAttribute("InitialLoadingComplete", true);
        u10:complete();
    end;
end;

local function open(p14) -- Line: 74
    -- upvalues: u5 (ref), u6 (ref), u2 (copy), u7 (ref), LocalPlayer (copy), u3 (copy), release (copy), u8 (ref)
    if u5 or u6 ~= p14 then
        return;
    end;

    u2.Loading.Visible = false;
    local v15;

    if u7 and LocalPlayer:GetAttribute("InitialLoadingComplete") ~= true then
        u3:forceOpen();
        v15 = true;
    else
        v15 = u3:animate(true);
    end;

    if v15 and u6 == p14 then
        u6 = nil;
        release();

        if p14 and u8 then
            u8:FireServer(p14, "Shown");
        end;
    end;
end;

local function failOpen() -- Line: 94
    -- upvalues: u6 (ref), u5 (ref), u2 (copy), u3 (copy), release (copy)
    u6 = nil;

    if not u5 then
        u2.Loading.Visible = false;
        u3:forceOpen();
        release();
    end;
end;

local function finishInitial(p16) -- Line: 102
    -- upvalues: u9 (ref), u5 (ref), u2 (copy), os_clock_ret (copy), u4 (copy), u6 (ref), u7 (ref), LocalPlayer (copy), u3 (copy), release (copy)
    if not (u9 and u5) then
        return;
    end;

    u5 = false;
    u2:SetAttribute("LoadingExit", p16);
    u2:SetAttribute("LoadingSeconds", os.clock() - os_clock_ret);
    u2.Loading.Visible = false;
    u4:destroy();

    if not (u6 or u5) then
        if u6 ~= nil then
            return;
        end;

        u2.Loading.Visible = false;
        local v17;

        if u7 and LocalPlayer:GetAttribute("InitialLoadingComplete") ~= true then
            u3:forceOpen();
            v17 = true;
        else
            v17 = u3:animate(true);
        end;

        if v17 and u6 == nil then
            u6 = nil;
            release();
        end;
    end;
end;

task.spawn(function() -- Line: 116
    -- upvalues: u9 (ref), LocalPlayer (copy), os_clock_ret (copy), table_clone_ret (copy), u7 (ref), u5 (ref), u6 (ref), u4 (copy), u2 (copy), u3 (copy), essentialsReady (copy), release (copy)
    while u9 and LocalPlayer:GetAttribute("InitialLoadingComplete") ~= true do
        if os.clock() - os_clock_ret >= table_clone_ret.InitialRecoveryTimeout then
            if not u7 then
                u7 = true;
                u5 = false;
                u6 = nil;
                u4:destroy();
                u2.Loading.Visible = false;
                u3:forceOpen();
                LocalPlayer:SetAttribute("ScreenPresentationActive", nil);
                u2:SetAttribute("LoadingExit", "TimedDismissal");
                u2:SetAttribute("LoadingSeconds", os.clock() - os_clock_ret);
            end;

            if essentialsReady(true) then
                release();

                return;
            end;
        end;

        task.wait(0.1);
    end;
end);
script.Destroying:Connect(function() -- Line: 138
    -- upvalues: u9 (ref), u4 (copy), u3 (copy), LocalPlayer (copy)
    u9 = false;
    u4:destroy();
    u3:destroy();
    LocalPlayer:SetAttribute("ScreenPresentationActive", nil);
end);
task.spawn(function() -- Line: 144
    -- upvalues: u8 (ref), u6 (ref), u5 (ref), u2 (copy), u3 (copy), release (copy), LocalPlayer (copy), table_clone_ret (copy), u9 (ref), u7 (ref), RunService (copy), open (copy), u10 (copy)
    u8 = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation"):WaitForChild("ScreenTransition");
    u8.OnClientEvent:Connect(function(p18, u19, u20, p21) -- Line: 147
        -- upvalues: u6 (ref), u5 (ref), u2 (ref), u3 (ref), release (ref), LocalPlayer (ref), table_clone_ret (ref), u9 (ref), u7 (ref), u8 (ref), RunService (ref), open (ref)
        if p18 == "Cancel" then
            u6 = nil;

            if not u5 then
                u2.Loading.Visible = false;
                u3:forceOpen();
                release();
            end;

            return;
        end;

        if p18 == "Close" then
            u6 = u19;
            LocalPlayer:SetAttribute("ScreenPresentationActive", true);
            task.delay(table_clone_ret.RecoveryTimeout, function() -- Line: 155
                -- upvalues: u9 (ref), u6 (ref), u19 (copy), u5 (ref), u2 (ref), u3 (ref), release (ref)
                if u9 and u6 == u19 then
                    u6 = nil;

                    if not u5 then
                        u2.Loading.Visible = false;
                        u3:forceOpen();
                        release();
                    end;
                end;
            end);

            if u5 or u7 and LocalPlayer:GetAttribute("InitialLoadingComplete") ~= true or u3:animate(false) and u6 == u19 then
                u8:FireServer(u19, "Closed");
            end;
        elseif p18 == "Reveal" and u6 == u19 then
            local v22 = os.clock() + table_clone_ret.PlacementTimeout;

            while true do
                local Character = LocalPlayer.Character;
                local v23;

                if Character then
                    v23 = Character:FindFirstChild("HumanoidRootPart");
                else
                    v23 = Character;
                end;

                if v23 and (typeof(u20) ~= "Vector3" or (v23.Position - u20).Magnitude < 12) and (p21 == nil or Character:GetAttribute("MovementReset") == p21) then
                    break;
                end;

                task.wait();

                if v22 <= os.clock() or u6 ~= u19 then
                    break;
                end;
            end;

            if typeof(u20) == "Vector3" and workspace.StreamingEnabled then
                pcall(function() -- Line: 182
                    -- upvalues: LocalPlayer (ref), u20 (copy), table_clone_ret (ref)
                    LocalPlayer:RequestStreamAroundAsync(u20, table_clone_ret.StreamTimeout);
                end);
            end;

            while u5 and u6 == u19 do
                task.wait(0.05);
            end;

            RunService.RenderStepped:Wait();
            RunService.RenderStepped:Wait();
            open(u19);
        end;
    end);
    u10:transferReady();
end);

if u1 then
    while u9 and (u5 and not essentialsReady()) do
        task.wait();
    end;

    if u9 then
        u4:destroy();
        u5 = false;
        u2.Loading.Visible = false;
        u3:forceOpen();
        u2:SetAttribute("LoadingExit", "Skipped");
        u2:SetAttribute("LoadingSeconds", os.clock() - os_clock_ret);
        u2:SetAttribute("LoadingReadyAt", workspace:GetServerTimeNow());
        release();
    end;

    return;
end;

local function preload() -- Line: 215
    -- upvalues: os_clock_ret (copy), table_clone_ret (copy), u9 (ref), u5 (ref), essentialsReady (copy), u2 (copy), LocalPlayer (copy), RunService (copy)
    local u24 = os_clock_ret + table_clone_ret.LoadingTimeout;

    while u9 and (u5 and (not essentialsReady() and os.clock() < u24)) do
        task.wait(0.05);
    end;

    if not (u9 and (u5 and essentialsReady())) then
        return;
    end;

    u2:SetAttribute("PreloadTotal", 0);
    u2:SetAttribute("PreloadFailed", 0);
    u2:SetAttribute("PreloadSucceeded", true);
    u2:SetAttribute("PreloadCompleted", 0);
    u2:SetAttribute("PreloadTimedOut", false);
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if Character and (workspace.StreamingEnabled and os.clock() < u24 - 1) then
        pcall(function() -- Line: 232
            -- upvalues: LocalPlayer (ref), Character (copy), u24 (copy)
            local Position = Character.Position;
            local v25 = u24 - os.clock();
            LocalPlayer:RequestStreamAroundAsync(Position, (math.min(1, v25)));
        end);
    end;

    RunService.RenderStepped:Wait();
    RunService.RenderStepped:Wait();
end;

local u26 = false;
local u27 = false;
task.spawn(function() -- Line: 243
    -- upvalues: preload (copy), u27 (ref), u26 (ref)
    local v28, v29 = xpcall(preload, debug.traceback);

    if not v28 then
        u27 = true;
        warn("Screen presentation loading:", v29);
    end;

    u26 = true;
end);
local v30 = nil;

while u9 and u5 do
    local os_clock_ret2 = os.clock();

    if (u26 or os_clock_ret2 - os_clock_ret >= table_clone_ret.LoadingTimeout) and essentialsReady() then
        v30 = v30 or os_clock_ret2;
    else
        v30 = nil;
    end;

    if v30 and (os_clock_ret2 - os_clock_ret >= table_clone_ret.MinimumLoadingTime and os_clock_ret2 - v30 >= table_clone_ret.LightingSettleTime) then
        break;
    end;

    task.wait(0.05);
end;

if u9 and u5 then
    u2:SetAttribute("LoadingExit", u27 and "Recovered" or (u26 and not u2:GetAttribute("PreloadTimedOut") and "Ready" or "AssetTimeout"));
    u2:SetAttribute("LoadingReadyAt", workspace:GetServerTimeNow());
    local success2, result2 = pcall(function() -- Line: 277
        -- upvalues: u4 (copy)
        u4:complete();
    end);

    if not success2 then
        warn("Loading finish recovered:", result2);
    end;

    finishInitial(u2:GetAttribute("LoadingExit"));
end;