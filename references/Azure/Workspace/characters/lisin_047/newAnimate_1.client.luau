 
 

local script_Parent = script.Parent;
local Torso = script_Parent:WaitForChild("Torso");
local u1 = Torso:WaitForChild("Right Shoulder");
local u2 = Torso:WaitForChild("Left Shoulder");
local u3 = Torso:WaitForChild("Right Hip");
local u4 = Torso:WaitForChild("Left Hip");
Torso:WaitForChild("Neck");
local Humanoid = script_Parent:WaitForChild("Humanoid");
local u5 = "Standing";
local success, result = pcall(function() -- Line: 15
    return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun");
end);
local u6 = success and result;

local function getRigScale() -- Line: 18
    -- upvalues: u6 (copy), script_Parent (copy)
    return not u6 and 1 or script_Parent:GetScale();
end;

local u7 = "";
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = 1;
local u12 = {};
local u13 = {
    idle = { {
            id = "http://www.roblox.com/asset/?id=180435571",
            weight = 9
        }, {
            id = "http://www.roblox.com/asset/?id=180435792",
            weight = 1
        } },
    walk = { {
            id = "http://www.roblox.com/asset/?id=180426354",
            weight = 10
        } },
    run = { {
            id = "run.xml",
            weight = 10
        } },
    jump = { {
            id = "http://www.roblox.com/asset/?id=125750702",
            weight = 10
        } },
    fall = { {
            id = "http://www.roblox.com/asset/?id=180436148",
            weight = 10
        } },
    climb = { {
            id = "http://www.roblox.com/asset/?id=180436334",
            weight = 10
        } },
    sit = { {
            id = "http://www.roblox.com/asset/?id=178130996",
            weight = 10
        } },
    toolnone = { {
            id = "http://www.roblox.com/asset/?id=182393478",
            weight = 10
        } },
    toolslash = { {
            id = "http://www.roblox.com/asset/?id=129967390",
            weight = 10
        } },
    toollunge = { {
            id = "http://www.roblox.com/asset/?id=129967478",
            weight = 10
        } },
    wave = { {
            id = "http://www.roblox.com/asset/?id=128777973",
            weight = 10
        } },
    point = { {
            id = "http://www.roblox.com/asset/?id=128853357",
            weight = 10
        } },
    dance1 = { {
            id = "http://www.roblox.com/asset/?id=182435998",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=182491037",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=182491065",
            weight = 10
        } },
    dance2 = { {
            id = "http://www.roblox.com/asset/?id=182436842",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=182491248",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=182491277",
            weight = 10
        } },
    dance3 = { {
            id = "http://www.roblox.com/asset/?id=182436935",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=182491368",
            weight = 10
        }, {
            id = "http://www.roblox.com/asset/?id=182491423",
            weight = 10
        } },
    laugh = { {
            id = "http://www.roblox.com/asset/?id=129423131",
            weight = 10
        } },
    cheer = { {
            id = "http://www.roblox.com/asset/?id=129423030",
            weight = 10
        } }
};

function configureAnimationSet(u14, u15)
    -- upvalues: u12 (copy)
    if u12[u14] ~= nil then
        for _, v in pairs(u12[u14].connections) do
            v:disconnect();
        end;
    end;

    u12[u14] = {};
    u12[u14].count = 0;
    u12[u14].totalWeight = 0;
    u12[u14].connections = {};
    local v16 = script:FindFirstChild(u14);

    if v16 ~= nil then
        table.insert(u12[u14].connections, v16.ChildAdded:connect(function(p17) -- Line: 111
            -- upvalues: u14 (copy), u15 (copy)
            configureAnimationSet(u14, u15);
        end));
        table.insert(u12[u14].connections, v16.ChildRemoved:connect(function(p18) -- Line: 112
            -- upvalues: u14 (copy), u15 (copy)
            configureAnimationSet(u14, u15);
        end));
        local v19 = 1;

        for _, child in pairs(v16:GetChildren()) do
            if child:IsA("Animation") then
                table.insert(u12[u14].connections, child.Changed:connect(function(p20) -- Line: 116
                    -- upvalues: u14 (copy), u15 (copy)
                    configureAnimationSet(u14, u15);
                end));
                u12[u14][v19] = {};
                u12[u14][v19].anim = child;
                local Weight = child:FindFirstChild("Weight");

                if Weight == nil then
                    u12[u14][v19].weight = 1;
                else
                    u12[u14][v19].weight = Weight.Value;
                end;

                u12[u14].count = u12[u14].count + 1;
                u12[u14].totalWeight = u12[u14].totalWeight + u12[u14][v19].weight;
                v19 = v19 + 1;
            end;
        end;
    end;

    if u12[u14].count <= 0 then
        for i, v in pairs(u15) do
            u12[u14][i] = {};
            u12[u14][i].anim = Instance.new("Animation");
            u12[u14][i].anim.Name = u14;
            u12[u14][i].anim.AnimationId = v.id;
            u12[u14][i].weight = v.weight;
            u12[u14].count = u12[u14].count + 1;
            u12[u14].totalWeight = u12[u14].totalWeight + v.weight;
        end;
    end;
end;

function scriptChildModified(p21)
    -- upvalues: u13 (copy)
    local v22 = u13[p21.Name];

    if v22 ~= nil then
        configureAnimationSet(p21.Name, v22);
    end;
end;

script.ChildAdded:connect(scriptChildModified);
script.ChildRemoved:connect(scriptChildModified);
local v23;

if Humanoid then
    v23 = Humanoid:FindFirstChildOfClass("Animator");
else
    v23 = nil;
end;

if v23 then
    local PlayingAnimationTracks = v23:GetPlayingAnimationTracks();

    for _, v in ipairs(PlayingAnimationTracks) do
        v:Stop(0);
        v:Destroy();
    end;
end;

for i, v in pairs(u13) do
    configureAnimationSet(i, v);
end;

local u24 = "None";
local u25 = 0;
local u26 = 0;

function stopAllAnimations()
    -- upvalues: u7 (ref), u8 (ref), u10 (ref), u9 (ref)
    local v27 = u7;
    u7 = "";
    u8 = nil;

    if u10 ~= nil then
        u10:disconnect();
    end;

    if u9 ~= nil then
        u9:Stop();
        u9:Destroy();
        u9 = nil;
    end;

    return v27;
end;

function setAnimationSpeed(p28)
    -- upvalues: u11 (ref), u9 (ref)
    if p28 ~= u11 then
        u11 = p28;
        u9:AdjustSpeed(u11);
    end;
end;

function keyFrameReachedFunc(p29)
    -- upvalues: u7 (ref), u11 (ref), Humanoid (copy)
    if p29 == "End" then
        playAnimation(u7, 0, Humanoid);
        setAnimationSpeed(u11);
    end;
end;

function playAnimation(p30, p31, p32)
    -- upvalues: u12 (copy), u8 (ref), u9 (ref), u11 (ref), u7 (ref), u10 (ref)
    local math_random_ret = math.random(1, u12[p30].totalWeight);
    local v33 = 1;

    while u12[p30][v33].weight < math_random_ret do
        math_random_ret = math_random_ret - u12[p30][v33].weight;
        v33 = v33 + 1;
    end;

    local anim = u12[p30][v33].anim;

    if anim ~= u8 then
        if u9 ~= nil then
            u9:Stop(p31);
            u9:Destroy();
        end;

        u11 = 1;
        u9 = p32:LoadAnimation(anim);
        u9.Priority = Enum.AnimationPriority.Core;
        u9:Play(p31);
        u7 = p30;
        u8 = anim;

        if u10 ~= nil then
            u10:disconnect();
        end;

        u10 = u9.KeyframeReached:connect(keyFrameReachedFunc);
    end;
end;

local u34 = "";
local u35 = nil;
local u36 = nil;
local u37 = nil;

function toolKeyFrameReachedFunc(p38)
    -- upvalues: u34 (ref), Humanoid (copy)
    if p38 == "End" then
        playToolAnimation(u34, 0, Humanoid);
    end;
end;

function playToolAnimation(p39, p40, p41, p42)
    -- upvalues: u12 (copy), u36 (ref), u35 (ref), u34 (ref), u37 (ref)
    local math_random_ret = math.random(1, u12[p39].totalWeight);
    local v43 = 1;

    while u12[p39][v43].weight < math_random_ret do
        math_random_ret = math_random_ret - u12[p39][v43].weight;
        v43 = v43 + 1;
    end;

    local anim = u12[p39][v43].anim;

    if u36 ~= anim then
        if u35 ~= nil then
            u35:Stop();
            u35:Destroy();
            p40 = 0;
        end;

        u35 = p41:LoadAnimation(anim);

        if p42 then
            u35.Priority = p42;
        end;

        u35:Play(p40);
        u34 = p39;
        u36 = anim;
        u37 = u35.KeyframeReached:connect(toolKeyFrameReachedFunc);
    end;
end;

function stopToolAnimations()
    -- upvalues: u34 (ref), u37 (ref), u36 (ref), u35 (ref)
    local v44 = u34;

    if u37 ~= nil then
        u37:disconnect();
    end;

    u34 = "";
    u36 = nil;

    if u35 ~= nil then
        u35:Stop();
        u35:Destroy();
        u35 = nil;
    end;

    return v44;
end;

function onRunning(p45)
    -- upvalues: u6 (copy), script_Parent (copy), Humanoid (copy), u8 (ref), u5 (ref)
    local v46 = p45 / (not u6 and 1 or script_Parent:GetScale());

    if v46 <= 0.01 then
        playAnimation("idle", 0.1, Humanoid);
        u5 = "Standing";

        return;
    end;

    playAnimation("walk", 0.1, Humanoid);

    if u8 and u8.AnimationId == "http://www.roblox.com/asset/?id=180426354" then
        setAnimationSpeed(v46 / 14.5);
    end;

    u5 = "Running";
end;

function onDied()
    -- upvalues: u5 (ref)
    u5 = "Dead";
end;

function onJumping()
    -- upvalues: Humanoid (copy), u26 (ref), u5 (ref)
    playAnimation("jump", 0.1, Humanoid);
    u26 = 0.3;
    u5 = "Jumping";
end;

function onClimbing(p47)
    -- upvalues: u6 (copy), script_Parent (copy), Humanoid (copy), u5 (ref)
    local v48 = p47 / (not u6 and 1 or script_Parent:GetScale());
    playAnimation("climb", 0.1, Humanoid);
    setAnimationSpeed(v48 / 12);
    u5 = "Climbing";
end;

function onGettingUp()
    -- upvalues: u5 (ref)
    u5 = "GettingUp";
end;

function onFreeFall()
    -- upvalues: u26 (ref), Humanoid (copy), u5 (ref)
    if u26 <= 0 then
        playAnimation("fall", 0.3, Humanoid);
    end;

    u5 = "FreeFall";
end;

function onFallingDown()
    -- upvalues: u5 (ref)
    u5 = "FallingDown";
end;

function onSeated()
    -- upvalues: u5 (ref)
    u5 = "Seated";
end;

function onPlatformStanding()
    -- upvalues: u5 (ref)
    u5 = "PlatformStanding";
end;

function onSwimming(p49)
    -- upvalues: u5 (ref)
    if p49 > 0 then
        u5 = "Running";

        return;
    end;

    u5 = "Standing";
end;

function getTool()
    -- upvalues: script_Parent (copy)
    for _, child in ipairs(script_Parent:GetChildren()) do
        if child.className == "Tool" then
            return child;
        end;
    end;

    return nil;
end;

function getToolAnim(p50)
    for _, child in ipairs(p50:GetChildren()) do
        if child.Name == "toolanim" and child.className == "StringValue" then
            return child;
        end;
    end;

    return nil;
end;

function animateTool()
    -- upvalues: u24 (ref), Humanoid (copy)
    if u24 == "None" then
        playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle);

        return;
    end;

    if u24 == "Slash" then
        playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action);

        return;
    end;

    if u24 ~= "Lunge" then
        return;
    end;

    playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action);
end;

function moveSit()
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), u4 (copy)
    u1.MaxVelocity = 0.15;
    u2.MaxVelocity = 0.15;
    u1:SetDesiredAngle(1.57);
    u2:SetDesiredAngle(-1.57);
    u3:SetDesiredAngle(1.57);
    u4:SetDesiredAngle(-1.57);
end;

local u51 = 0;

function move(p52)
    -- upvalues: u51 (ref), u26 (ref), u5 (ref), Humanoid (copy), u1 (copy), u2 (copy), u3 (copy), u4 (copy), u24 (ref), u25 (ref), u36 (ref)
    local v53 = 1;
    local v54 = 1;
    local v55 = p52 - u51;
    u51 = p52;
    local v56 = false;

    if u26 > 0 then
        u26 = u26 - v55;
    end;

    if u5 == "FreeFall" and u26 <= 0 then
        playAnimation("fall", 0.3, Humanoid);
    else
        if u5 == "Seated" then
            playAnimation("sit", 0.5, Humanoid);

            return;
        end;

        if u5 == "Running" then
            playAnimation("walk", 0.1, Humanoid);
        elseif u5 == "Dead" or (u5 == "GettingUp" or (u5 == "FallingDown" or (u5 == "Seated" or u5 == "PlatformStanding"))) then
            stopAllAnimations();
            v56 = true;
            v54 = 1;
            v53 = 0.1;
        end;
    end;

    if v56 then
        local v57 = v53 * math.sin(p52 * v54);
        u1:SetDesiredAngle(v57 + 0);
        u2:SetDesiredAngle(v57 - 0);
        u3:SetDesiredAngle(-v57);
        u4:SetDesiredAngle(-v57);
    end;

    local v58 = getTool();

    if v58 and v58:FindFirstChild("Handle") then
        local v59 = getToolAnim(v58);

        if v59 then
            u24 = v59.Value;
            v59.Parent = nil;
            u25 = p52 + 0.3;
        end;

        if u25 < p52 then
            u25 = 0;
            u24 = "None";
        end;

        animateTool();

        return;
    end;

    stopToolAnimations();
    u24 = "None";
    u36 = nil;
    u25 = 0;
end;

Humanoid.Died:connect(onDied);
Humanoid.Running:connect(onRunning);
Humanoid.Jumping:connect(onJumping);
Humanoid.Climbing:connect(onClimbing);
Humanoid.GettingUp:connect(onGettingUp);
Humanoid.FreeFalling:connect(onFreeFall);
Humanoid.FallingDown:connect(onFallingDown);
Humanoid.Seated:connect(onSeated);
Humanoid.PlatformStanding:connect(onPlatformStanding);
Humanoid.Swimming:connect(onSwimming);
playAnimation("idle", 0.1, Humanoid);
u5 = "Standing";

while script_Parent.Parent ~= nil do
    local _, v60 = wait(0.1);
    move(v60);
end;