 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ChickenOrHero = ReplicatedStorage:WaitForChild("ChickenOrHero");

if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).Cutscenes ~= true then
    return;
end;

local Game = ChickenOrHero:WaitForChild("Game");
local CutsceneEvent = Game:WaitForChild("CutsceneEvent", 10);

while not CutsceneEvent do
    warn("[Cutscene] still waiting for ReplicatedStorage.ChickenOrHero.Game.CutsceneEvent");
    CutsceneEvent = Game:WaitForChild("CutsceneEvent", 30);
end;

local EclipseCutscene = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("EclipseCutscene"));

local function preload(u1) -- Line: 37
    -- upvalues: EclipseCutscene (copy)
    task.spawn(function() -- Line: 38
        -- upvalues: EclipseCutscene (ref), u1 (copy)
        local v2, v3 = EclipseCutscene.preload(u1);

        if not v2 then
            warn("[Cutscene] couldn\'t load " .. tostring(u1) .. ": " .. tostring(v3));
        end;
    end);
end;

local function play(p4) -- Line: 46
    -- upvalues: EclipseCutscene (copy), ReplicatedStorage (copy)
    if type(p4) ~= "table" or (type(p4.Name) ~= "string" or type(p4.StartAt) ~= "number") then
        return;
    end;

    local v5 = type(p4.Seconds) ~= "number" and 60 or p4.Seconds;
    local u6 = p4.StartAt + v5;
    local v7 = p4.StartAt + 8;

    if v7 < workspace:GetServerTimeNow() then
        EclipseCutscene.giveUp("Late", u6);

        return;
    end;

    local u8 = false;
    local task_delay = task.delay;
    local v9 = v7 - workspace:GetServerTimeNow();
    local v10 = task_delay(math.max(0, v9), function() -- Line: 62
        -- upvalues: u8 (ref), EclipseCutscene (ref), u6 (copy)
        u8 = true;
        EclipseCutscene.giveUp("Late", u6);
    end);
    local v11, v12 = EclipseCutscene.load(p4.Name);

    if u8 then
        return;
    end;

    task.cancel(v10);

    if not v11 then
        warn("[Cutscene] couldn\'t load " .. p4.Name .. ": " .. tostring(v12));
        EclipseCutscene.giveUp("Missing", u6);

        return;
    end;

    if v7 < workspace:GetServerTimeNow() then
        EclipseCutscene.giveUp("Late", u6);

        return;
    end;

    local play = EclipseCutscene.play;
    local Name = p4.Name;
    local v13 = {
        FromStart = true,
        StartAt = math.max(p4.StartAt, workspace:GetServerTimeNow()),
        GiveUpAt = v7,
        FightAt = u6,
        Seconds = v5
    };
    local v14;

    if type(p4.HandBack) == "number" then
        v14 = p4.HandBack;
    else
        v14 = nil;
    end;

    v13.HandBack = v14;
    local v15;

    if typeof(p4.Cast) == "Instance" then
        v15 = p4.Cast;
    else
        v15 = ReplicatedStorage:FindFirstChild("CutsceneCast");
    end;

    v13.Cast = v15;
    local v16;

    if type(p4.Order) == "table" then
        v16 = p4.Order;
    else
        v16 = nil;
    end;

    v13.Order = v16;
    local v17;

    if type(p4.Keep) == "table" then
        v17 = p4.Keep;
    else
        v17 = nil;
    end;

    v13.Keep = v17;
    local v18;

    if type(p4.Hide) == "table" then
        v18 = p4.Hide;
    else
        v18 = nil;
    end;

    v13.Hide = v18;
    local v19, v20 = play(Name, v13);

    if not v19 then
        warn("[Cutscene] couldn\'t play " .. p4.Name .. ": " .. tostring(v20));
        EclipseCutscene.giveUp("Missing", u6);
    end;
end;

CutsceneEvent.OnClientEvent:Connect(function(p21, u22) -- Line: 100
    -- upvalues: EclipseCutscene (copy), play (copy)
    if p21 == "Preload" and type(u22) == "string" then
        task.spawn(function() -- Line: 38
            -- upvalues: EclipseCutscene (ref), u22 (copy)
            local v23, v24 = EclipseCutscene.preload(u22);

            if not v23 then
                warn("[Cutscene] couldn\'t load " .. tostring(u22) .. ": " .. tostring(v24));
            end;
        end);

        return;
    end;

    if p21 ~= "Cover" then
        if p21 == "Play" then
            play(u22);

            return;
        end;

        if p21 == "Stop" then
            EclipseCutscene.stop(u22 == "Error" and "Error" or nil);
        end;

        return;
    end;

    local v25 = type(u22) ~= "table" and {} or u22;
    local cover = EclipseCutscene.cover;
    local v26;

    if type(v25.Limit) == "number" then
        v26 = v25.Limit;
    else
        v26 = nil;
    end;

    local v27;

    if type(v25.Fade) == "number" then
        v27 = v25.Fade;
    else
        v27 = nil;
    end;

    local v28;

    if type(v25.Until) == "number" then
        v28 = v25.Until;
    else
        v28 = nil;
    end;

    cover(v26, v27, v28);
end);