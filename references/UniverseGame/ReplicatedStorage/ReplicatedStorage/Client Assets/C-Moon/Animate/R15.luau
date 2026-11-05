  

 

local Parent = script.Parent;
local Parent2 = Parent.Parent;
local Humanoid = Parent2:WaitForChild("Humanoid");
local u1 = "Standing";
local success, result = pcall(function() -- Line: 7
    return UserSettings():IsUserFeatureEnabled("UserNoUpdateOnLoop");
end);
local u2 = success and result;
local success2, result2 = pcall(function() -- Line: 9
    return UserSettings():IsUserFeatureEnabled("UserAnimationSpeedDampening");
end);
local u3 = success2 and result2;
local success3, result3 = pcall(function() -- Line: 12
    return UserSettings():IsUserFeatureEnabled("UserAnimateScriptEmoteHook");
end);
local u4 = success3 and result3;
local ScaleDampeningPercent = Parent:FindFirstChild("ScaleDampeningPercent");
local u5 = "";
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = 1;
local u10 = nil;
local u11 = nil;
local u12 = {};
local u13 = {
    idle = { {
            id = "http://www.roblox.com/asset/?id=507766666",
            weight = 1
        }, {
            id = "http://www.roblox.com/asset/?id=507766951",
            weight = 1
        }, {
            id = "http://www.roblox.com/asset/?id=507766388",
            weight = 9
        } },
    walk = { {
            id = "http://www.roblox.com/asset/?id=507777826",
            weight = 10
        } },
    run = { {
            id = "http://www.roblox.com/asset/?id=507767714",
            weight = 10
        } },
    swim = { {
            id = "http://www.roblox.com/asset/?id=507784897",
            weight = 10
        } },
    swimidle = { {
            id = "http://www.roblox.com/asset/?id=507785072",
            weight = 10
        } },
    jump = { {
            id = "http://www.roblox.com/asset/?id=507765000",
            weight = 10
        } },
    fall = { {
            id = "http://www.roblox.com/asset/?id=507767968",
            weight = 10
        } },
    climb = { {
            id = "http://www.roblox.com/asset/?id=507765644",
            weight = 10
        } },
    sit = { {
            id = "http://www.roblox.com/asset/?id=2506281703",
            weight = 10
        } },
    toolnone = { {
            id = "http://www.roblox.com/asset/?id=507768375",
            weight = 10
        } },
    toolslash = { {
            id = "http://www.roblox.com/asset/?id=522635514",
            weight = 10
        } },
    toollunge = { {
            id = "http://www.roblox.com/asset/?id=522638767",
            weight = 10
        } },
    wave = { {
            id = "http://www.roblox.com/asset/?id=507770239",
            weight = 10
        } },
    point = { {
            id = "http://www.roblox.com/asset/?id=507770453",
            weight = 10
        } },
    dance = { {
            id = "http://www.roblox.com/asset/?id=507771019",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=507771955",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=507772104",
            weight = 10
        } },
    dance2 = { {
            id = "http://www.roblox.com/asset/?id=507776043",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=507776720",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=507776879",
            weight = 10
        } },
    dance3 = { {
            id = "http://www.roblox.com/asset/?id=507777268",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=507777451",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=507777623",
            weight = 10
        } },
    laugh = { {
            id = "http://www.roblox.com/asset/?id=507770818",
            weight = 10
        } },
    cheer = { {
            id = "http://www.roblox.com/asset/?id=507770677",
            weight = 10
        } }
};
local u14 = {
    wave = false,
    point = false,
    dance = true,
    dance2 = true,
    dance3 = true,
    laugh = false,
    cheer = false
};
local u15 = false;
local u16 = {};
local success4, _ = pcall(function() -- Line: 105
    -- upvalues: u15 (ref)
    u15 = UserSettings():IsUserFeatureEnabled("UserPreloadAnimations");
end);

if not success4 then
    u15 = false;
end;

math.randomseed(tick());

function findExistingAnimationInSet(p17, p18)
    if p17 == nil or p18 == nil then
        return 0;
    end;

    for i = 1, p17.count do
        if p17[i].anim.AnimationId == p18.AnimationId then
            return i;
        end;
    end;

    return 0;
end;

function configureAnimationSet(u19, u20)
    -- upvalues: u12 (copy), Parent (copy), u15 (ref), u16 (copy), Humanoid (copy)
    if u12[u19] ~= nil then
        for _, v in pairs(u12[u19].connections) do
            v:disconnect();
        end;
    end;

    u12[u19] = {};
    u12[u19].count = 0;
    u12[u19].totalWeight = 0;
    u12[u19].connections = {};
    local u21 = true;
    local success5, _ = pcall(function() -- Line: 141
        -- upvalues: u21 (ref)
        u21 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    u21 = not success5 and true or u21;
    local v22 = Parent:FindFirstChild(u19);

    if u21 and v22 ~= nil then
        table.insert(u12[u19].connections, v22.ChildAdded:connect(function(p23) -- Line: 149
            -- upvalues: u19 (copy), u20 (copy)
            configureAnimationSet(u19, u20);
        end));
        table.insert(u12[u19].connections, v22.ChildRemoved:connect(function(p24) -- Line: 150
            -- upvalues: u19 (copy), u20 (copy)
            configureAnimationSet(u19, u20);
        end));

        for _, child in pairs(v22:GetChildren()) do
            if child:IsA("Animation") then
                local Weight = child:FindFirstChild("Weight");
                local v25 = Weight == nil and 1 or Weight.Value;
                u12[u19].count = u12[u19].count + 1;
                local count = u12[u19].count;
                u12[u19][count] = {};
                u12[u19][count].anim = child;
                u12[u19][count].weight = v25;
                u12[u19].totalWeight = u12[u19].totalWeight + u12[u19][count].weight;
                table.insert(u12[u19].connections, child.Changed:connect(function(p26) -- Line: 166
                    -- upvalues: u19 (copy), u20 (copy)
                    configureAnimationSet(u19, u20);
                end));
                table.insert(u12[u19].connections, child.ChildAdded:connect(function(p27) -- Line: 167
                    -- upvalues: u19 (copy), u20 (copy)
                    configureAnimationSet(u19, u20);
                end));
                table.insert(u12[u19].connections, child.ChildRemoved:connect(function(p28) -- Line: 168
                    -- upvalues: u19 (copy), u20 (copy)
                    configureAnimationSet(u19, u20);
                end));
            end;
        end;
    end;

    if u12[u19].count <= 0 then
        for i, v in pairs(u20) do
            u12[u19][i] = {};
            u12[u19][i].anim = Instance.new("Animation");
            u12[u19][i].anim.Name = u19;
            u12[u19][i].anim.AnimationId = v.id;
            u12[u19][i].weight = v.weight;
            u12[u19].count = u12[u19].count + 1;
            u12[u19].totalWeight = u12[u19].totalWeight + v.weight;
        end;
    end;

    if u15 then
        for _, v in pairs(u12) do
            for i = 1, v.count do
                if u16[v[i].anim.AnimationId] == nil then
                    Humanoid:LoadAnimation(v[i].anim);
                    u16[v[i].anim.AnimationId] = true;
                end;
            end;
        end;
    end;
end;

function configureAnimationSetOld(u29, u30)
    -- upvalues: u12 (copy), Parent (copy), u15 (ref), Humanoid (copy)
    if u12[u29] ~= nil then
        for _, v in pairs(u12[u29].connections) do
            v:disconnect();
        end;
    end;

    u12[u29] = {};
    u12[u29].count = 0;
    u12[u29].totalWeight = 0;
    u12[u29].connections = {};
    local u31 = true;
    local success5, _ = pcall(function() -- Line: 214
        -- upvalues: u31 (ref)
        u31 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    u31 = not success5 and true or u31;
    local v32 = Parent:FindFirstChild(u29);

    if u31 and v32 ~= nil then
        table.insert(u12[u29].connections, v32.ChildAdded:connect(function(p33) -- Line: 222
            -- upvalues: u29 (copy), u30 (copy)
            configureAnimationSet(u29, u30);
        end));
        table.insert(u12[u29].connections, v32.ChildRemoved:connect(function(p34) -- Line: 223
            -- upvalues: u29 (copy), u30 (copy)
            configureAnimationSet(u29, u30);
        end));
        local v35 = 1;

        for _, child in pairs(v32:GetChildren()) do
            if child:IsA("Animation") then
                table.insert(u12[u29].connections, child.Changed:connect(function(p36) -- Line: 227
                    -- upvalues: u29 (copy), u30 (copy)
                    configureAnimationSet(u29, u30);
                end));
                u12[u29][v35] = {};
                u12[u29][v35].anim = child;
                local Weight = child:FindFirstChild("Weight");

                if Weight == nil then
                    u12[u29][v35].weight = 1;
                else
                    u12[u29][v35].weight = Weight.Value;
                end;

                u12[u29].count = u12[u29].count + 1;
                u12[u29].totalWeight = u12[u29].totalWeight + u12[u29][v35].weight;
                v35 = v35 + 1;
            end;
        end;
    end;

    if u12[u29].count <= 0 then
        for i, v in pairs(u30) do
            u12[u29][i] = {};
            u12[u29][i].anim = Instance.new("Animation");
            u12[u29][i].anim.Name = u29;
            u12[u29][i].anim.AnimationId = v.id;
            u12[u29][i].weight = v.weight;
            u12[u29].count = u12[u29].count + 1;
            u12[u29].totalWeight = u12[u29].totalWeight + v.weight;
        end;
    end;

    if u15 then
        for _, v in pairs(u12) do
            for i = 1, v.count do
                Humanoid:LoadAnimation(v[i].anim);
            end;
        end;
    end;
end;

function scriptChildModified(p37)
    -- upvalues: u13 (copy)
    local v38 = u13[p37.Name];

    if v38 ~= nil then
        configureAnimationSet(p37.Name, v38);
    end;
end;

Parent.ChildAdded:connect(scriptChildModified);
Parent.ChildRemoved:connect(scriptChildModified);

for i, v in pairs(u13) do
    configureAnimationSet(i, v);
end;

local u39 = "None";
local u40 = 0;
local u41 = 0;
local u42 = false;

function stopAllAnimations()
    -- upvalues: u5 (ref), u14 (copy), u4 (copy), u42 (ref), u6 (ref), u8 (ref), u7 (ref), u11 (ref), u10 (ref)
    local v43 = u5;
    local v44 = u14[v43] ~= nil and u14[v43] == false and "idle" or v43;

    if u4 and u42 then
        v44 = "idle";
        u42 = false;
    end;

    u5 = "";
    u6 = nil;

    if u8 ~= nil then
        u8:disconnect();
    end;

    if u7 ~= nil then
        u7:Stop();
        u7:Destroy();
        u7 = nil;
    end;

    if u11 ~= nil then
        u11:disconnect();
    end;

    if u10 ~= nil then
        u10:Stop();
        u10:Destroy();
        u10 = nil;
    end;

    return v44;
end;

function getHeightScale()
    -- upvalues: Humanoid (copy), u3 (copy), ScaleDampeningPercent (ref), Parent (copy)
    if not Humanoid then
        return 1;
    end;

    if not Humanoid.AutomaticScalingEnabled then
        return 1;
    end;

    local v45 = Humanoid.HipHeight / 2;

    if u3 then
        if ScaleDampeningPercent == nil then
            ScaleDampeningPercent = Parent:FindFirstChild("ScaleDampeningPercent");
        end;

        if ScaleDampeningPercent ~= nil then
            v45 = 1 + (Humanoid.HipHeight - 2) * ScaleDampeningPercent.Value / 2;
        end;
    end;

    return v45;
end;

function setRunSpeed(p46)
    -- upvalues: u9 (ref), u7 (ref), u10 (ref)
    local v47 = p46 * 1.25 / getHeightScale();

    if v47 ~= u9 then
        if v47 < 0.33 then
            u7:AdjustWeight(1);
            u10:AdjustWeight(0.0001);
        elseif v47 < 0.66 then
            local v48 = (v47 - 0.33) / 0.33;
            u7:AdjustWeight(1 - v48 + 0.0001);
            u10:AdjustWeight(v48 + 0.0001);
        else
            u7:AdjustWeight(0.0001);
            u10:AdjustWeight(1);
        end;

        u9 = v47;
        u10:AdjustSpeed(v47);
        u7:AdjustSpeed(v47);
    end;
end;

function setAnimationSpeed(p49)
    -- upvalues: u5 (ref), u9 (ref), u7 (ref)
    if u5 == "walk" then
        setRunSpeed(p49);

        return;
    end;

    if p49 ~= u9 then
        u9 = p49;
        u7:AdjustSpeed(u9);
    end;
end;

function keyFrameReachedFunc(p50)
    -- upvalues: u5 (ref), u2 (copy), u10 (ref), u7 (ref), u14 (copy), u4 (copy), u42 (ref), u9 (ref), Humanoid (copy)
    if p50 == "End" then
        if u5 == "walk" then
            if u2 ~= true then
                u10.TimePosition = 0;
                u7.TimePosition = 0;

                return;
            end;

            if u10.Looped ~= true then
                u10.TimePosition = 0;
            end;

            if u7.Looped ~= true then
                u7.TimePosition = 0;
            end;
        else
            local v51 = u5;
            local v52 = u14[v51] ~= nil and u14[v51] == false and "idle" or v51;

            if u4 and u42 then
                if u7.Looped then
                    return;
                end;

                v52 = "idle";
                u42 = false;
            end;

            playAnimation(v52, 0.15, Humanoid);
            setAnimationSpeed(u9);
        end;
    end;
end;

function rollAnimation(p53)
    -- upvalues: u12 (copy)
    local v54 = math.random(1, u12[p53].totalWeight);
    local v55 = 1;

    while u12[p53][v55].weight < v54 do
        v54 = v54 - u12[p53][v55].weight;
        v55 = v55 + 1;
    end;

    return v55;
end;

local function switchToAnim(p56, p57, p58, p59) -- Line: 442
    -- upvalues: u6 (ref), u7 (ref), u10 (ref), u2 (copy), u9 (ref), u5 (ref), u8 (ref), u12 (copy), u11 (ref)
    if p56 ~= u6 then
        if u7 ~= nil then
            u7:Stop(p58);
            u7:Destroy();
        end;

        if u10 ~= nil then
            u10:Stop(p58);
            u10:Destroy();

            if u2 == true then
                u10 = nil;
            end;
        end;

        u9 = 1;
        u7 = p59:LoadAnimation(p56);
        u7.Priority = Enum.AnimationPriority.Core;
        u7:Play(p58);
        u5 = p57;
        u6 = p56;

        if u8 ~= nil then
            u8:disconnect();
        end;

        u8 = u7.KeyframeReached:connect(keyFrameReachedFunc);

        if p57 == "walk" then
            local v60 = rollAnimation("run");
            u10 = p59:LoadAnimation(u12.run[v60].anim);
            u10.Priority = Enum.AnimationPriority.Core;
            u10:Play(p58);

            if u11 ~= nil then
                u11:disconnect();
            end;

            u11 = u10.KeyframeReached:connect(keyFrameReachedFunc);
        end;
    end;
end;

function playAnimation(p61, p62, p63)
    -- upvalues: u12 (copy), switchToAnim (copy), u42 (ref)
    local v64 = rollAnimation(p61);
    switchToAnim(u12[p61][v64].anim, p61, p62, p63);
    u42 = false;
end;

function playEmote(p65, p66, p67)
    -- upvalues: switchToAnim (copy), u42 (ref)
    switchToAnim(p65, p65.Name, p66, p67);
    u42 = true;
end;

local u68 = "";
local u69 = nil;
local u70 = nil;
local u71 = nil;

function toolKeyFrameReachedFunc(p72)
    -- upvalues: u68 (ref), Humanoid (copy)
    if p72 == "End" then
        playToolAnimation(u68, 0, Humanoid);
    end;
end;

function playToolAnimation(p73, p74, p75, p76)
    -- upvalues: u12 (copy), u70 (ref), u69 (ref), u68 (ref), u71 (ref)
    local v77 = rollAnimation(p73);
    local anim = u12[p73][v77].anim;

    if u70 ~= anim then
        if u69 ~= nil then
            u69:Stop();
            u69:Destroy();
            p74 = 0;
        end;

        u69 = p75:LoadAnimation(anim);

        if p76 then
            u69.Priority = p76;
        end;

        u69:Play(p74);
        u68 = p73;
        u70 = anim;
        u71 = u69.KeyframeReached:connect(toolKeyFrameReachedFunc);
    end;
end;

function stopToolAnimations()
    -- upvalues: u68 (ref), u71 (ref), u70 (ref), u69 (ref)
    local v78 = u68;

    if u71 ~= nil then
        u71:disconnect();
    end;

    u68 = "";
    u70 = nil;

    if u69 ~= nil then
        u69:Stop();
        u69:Destroy();
        u69 = nil;
    end;

    return v78;
end;

function onRunning(p79)
    -- upvalues: Humanoid (copy), u1 (ref), u14 (copy), u5 (ref), u42 (ref)
    if p79 <= 0.75 then
        if u14[u5] == nil and not u42 then
            playAnimation("idle", 0.2, Humanoid);
            u1 = "Standing";
        end;

        return;
    end;

    playAnimation("walk", 0.2, Humanoid);
    setAnimationSpeed(p79 / 16);
    u1 = "Running";
end;

function onDied()
    -- upvalues: u1 (ref)
    u1 = "Dead";
end;

function onJumping()
    -- upvalues: Humanoid (copy), u41 (ref), u1 (ref)
    playAnimation("jump", 0.1, Humanoid);
    u41 = 0.31;
    u1 = "Jumping";
end;

function onClimbing(p80)
    -- upvalues: Humanoid (copy), u1 (ref)
    playAnimation("climb", 0.1, Humanoid);
    setAnimationSpeed(p80 / 5);
    u1 = "Climbing";
end;

function onGettingUp()
    -- upvalues: u1 (ref)
    u1 = "GettingUp";
end;

function onFreeFall()
    -- upvalues: u41 (ref), Humanoid (copy), u1 (ref)
    if u41 <= 0 then
        playAnimation("fall", 0.2, Humanoid);
    end;

    u1 = "FreeFall";
end;

function onFallingDown()
    -- upvalues: u1 (ref)
    u1 = "FallingDown";
end;

function onSeated()
    -- upvalues: u1 (ref)
    u1 = "Seated";
end;

function onPlatformStanding()
    -- upvalues: u1 (ref)
    u1 = "PlatformStanding";
end;

function onSwimming(p81)
    -- upvalues: Humanoid (copy), u1 (ref)
    if p81 <= 1 then
        playAnimation("swimidle", 0.4, Humanoid);
        u1 = "Standing";

        return;
    end;

    playAnimation("swim", 0.4, Humanoid);
    setAnimationSpeed(p81 / 10);
    u1 = "Swimming";
end;

function animateTool()
    -- upvalues: u39 (ref), Humanoid (copy)
    if u39 == "None" then
        playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle);

        return;
    end;

    if u39 == "Slash" then
        playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action);

        return;
    end;

    if u39 ~= "Lunge" then
        return;
    end;

    playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action);
end;

function getToolAnim(p82)
    for _, child in ipairs(p82:GetChildren()) do
        if child.Name == "toolanim" and child.className == "StringValue" then
            return child;
        end;
    end;

    return nil;
end;

local u83 = 0;

function stepAnimate(p84)
    -- upvalues: u83 (ref), u41 (ref), u1 (ref), Humanoid (copy), Parent2 (copy), u39 (ref), u40 (ref), u70 (ref)
    local v85 = p84 - u83;
    u83 = p84;

    if u41 > 0 then
        u41 = u41 - v85;
    end;

    if u1 == "FreeFall" and u41 <= 0 then
        playAnimation("fall", 0.2, Humanoid);
    else
        if u1 == "Seated" then
            playAnimation("sit", 0.5, Humanoid);

            return;
        end;

        if u1 == "Running" then
            playAnimation("walk", 0.2, Humanoid);
        elseif u1 == "Dead" or (u1 == "GettingUp" or (u1 == "FallingDown" or (u1 == "Seated" or u1 == "PlatformStanding"))) then
            stopAllAnimations();
        end;
    end;

    local v86 = Parent2:FindFirstChildOfClass("Tool");

    if v86 and v86:FindFirstChild("Handle") then
        local v87 = getToolAnim(v86);

        if v87 then
            u39 = v87.Value;
            v87.Parent = nil;
            u40 = p84 + 0.3;
        end;

        if u40 < p84 then
            u40 = 0;
            u39 = "None";
        end;

        animateTool();

        return;
    end;

    stopToolAnimations();
    u39 = "None";
    u70 = nil;
    u40 = 0;
end;

local u88 = {};
local u89 = Humanoid;
local ReplicatedHumanoid = Parent:WaitForChild("ReplicatedHumanoid");

local function onUnhook() -- Line: 726
    -- upvalues: u88 (ref)
    for i = 1, #u88 do
        u88[i]:Disconnect();
    end;

    u88 = {};
end;

local function onHook() -- Line: 733
    -- upvalues: onUnhook (copy), u1 (ref), Humanoid (copy), u88 (ref), u89 (ref)
    onUnhook();
    u1 = Humanoid.Sit and "Seated" or "Standing";
    u88 = {
        u89.Died:connect(onDied),
        u89.Running:connect(onRunning),
        u89.Jumping:connect(onJumping),
        u89.Climbing:connect(onClimbing),
        u89.GettingUp:connect(onGettingUp),
        u89.FreeFalling:connect(onFreeFall),
        u89.FallingDown:connect(onFallingDown),
        u89.Seated:connect(onSeated),
        u89.PlatformStanding:connect(onPlatformStanding),
        u89.Swimming:connect(onSwimming)
    };
end;

ReplicatedHumanoid.Changed:Connect(function() -- Line: 752
    -- upvalues: u89 (ref), ReplicatedHumanoid (copy), onHook (copy)
    u89 = ReplicatedHumanoid.Value;
    onHook();
end);
ReplicatedHumanoid.Value = Humanoid;
game:GetService("Players").LocalPlayer.Chatted:connect(function(p90) -- Line: 760
    -- upvalues: u1 (ref), u14 (copy), Humanoid (copy)
    local v91 = "";

    if string.sub(p90, 1, 3) == "/e " then
        v91 = string.sub(p90, 4);
    elseif string.sub(p90, 1, 7) == "/emote " then
        v91 = string.sub(p90, 8);
    end;

    if u1 == "Standing" and u14[v91] ~= nil then
        playAnimation(v91, 0.1, Humanoid);
    end;
end);

if u4 then
    Parent:WaitForChild("PlayEmote").OnInvoke = function(p92) -- Line: 775
        -- upvalues: u1 (ref), u14 (copy), Humanoid (copy)
        if u1 == "Standing" then
            if u14[p92] ~= nil then
                playAnimation(p92, 0.1, Humanoid);

                return true;
            end;

            if typeof(p92) ~= "Instance" or not p92:IsA("Animation") then
                return false;
            end;

            playEmote(p92, 0.1, Humanoid);

            return true;
        end;
    end;
end;

playAnimation("idle", 0.1, Humanoid);
u1 = "Standing";
spawn(function() -- Line: 802
    -- upvalues: Parent2 (copy)
    while Parent2.Parent ~= nil do
        local _, v93 = wait(0.1);
        stepAnimate(v93);
    end;
end);

return {
    onRunning = onRunning,
    onDied = onDied,
    onJumping = onJumping,
    onClimbing = onClimbing,
    onGettingUp = onGettingUp,
    onFreeFall = onFreeFall,
    onFallingDown = onFallingDown,
    onSeated = onSeated,
    onPlatformStanding = onPlatformStanding,
    onHook = onHook,
    onUnhook = onUnhook
};