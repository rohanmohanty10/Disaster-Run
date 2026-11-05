  

 

local Parent = script.Parent;
local Parent2 = Parent.Parent;
local Torso = Parent2:WaitForChild("Torso");
local u1 = Torso:WaitForChild("Right Shoulder");
local u2 = Torso:WaitForChild("Left Shoulder");
local u3 = Torso:WaitForChild("Right Hip");
local u4 = Torso:WaitForChild("Left Hip");
Torso:WaitForChild("Neck");
local v5 = string.split(Parent2.Name, "_")[1];
local Humanoid = workspace.Living:WaitForChild(v5):WaitForChild("Humanoid");
local u6 = {};
local u7 = {
    idle = { {
            id = "http://www.roblox.com/asset/?id=11100354204",
            weight = 9
        }, {
            id = "http://www.roblox.com/asset/?id=11100354204",
            weight = 1
        } },
    walk = { {
            id = "http://www.roblox.com/asset/?id=11100355203",
            weight = 10
        } },
    run = { {
            id = "http://www.roblox.com/asset/?id=10044373365",
            weight = 10
        } },
    jump = { {
            id = "http://www.roblox.com/asset/?id=10044385336",
            weight = 10
        } },
    fall = { {
            id = "http://www.roblox.com/asset/?id=10044381049",
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

function configureAnimationSet(u8, u9)
    -- upvalues: u6 (copy), Parent (copy)
    if u6[u8] ~= nil then
        for _, v in pairs(u6[u8].connections) do
            v:disconnect();
        end;
    end;

    u6[u8] = {};
    u6[u8].count = 0;
    u6[u8].totalWeight = 0;
    u6[u8].connections = {};
    local v10 = Parent:FindFirstChild(u8);

    if v10 ~= nil then
        table.insert(u6[u8].connections, v10.ChildAdded:connect(function(p11) -- Line: 102
            -- upvalues: u8 (copy), u9 (copy)
            configureAnimationSet(u8, u9);
        end));
        table.insert(u6[u8].connections, v10.ChildRemoved:connect(function(p12) -- Line: 103
            -- upvalues: u8 (copy), u9 (copy)
            configureAnimationSet(u8, u9);
        end));
        local v13 = 1;

        for _, child in pairs(v10:GetChildren()) do
            if child:IsA("Animation") then
                table.insert(u6[u8].connections, child.Changed:connect(function(p14) -- Line: 107
                    -- upvalues: u8 (copy), u9 (copy)
                    configureAnimationSet(u8, u9);
                end));
                u6[u8][v13] = {};
                u6[u8][v13].anim = child;
                local Weight = child:FindFirstChild("Weight");

                if Weight == nil then
                    u6[u8][v13].weight = 1;
                else
                    u6[u8][v13].weight = Weight.Value;
                end;

                u6[u8].count = u6[u8].count + 1;
                u6[u8].totalWeight = u6[u8].totalWeight + u6[u8][v13].weight;
                v13 = v13 + 1;
            end;
        end;
    end;

    if u6[u8].count <= 0 then
        for i, v in pairs(u9) do
            u6[u8][i] = {};
            u6[u8][i].anim = Instance.new("Animation");
            u6[u8][i].anim.Name = u8;
            u6[u8][i].anim.AnimationId = v.id;
            u6[u8][i].weight = v.weight;
            u6[u8].count = u6[u8].count + 1;
            u6[u8].totalWeight = u6[u8].totalWeight + v.weight;
        end;
    end;
end;

function scriptChildModified(p15)
    -- upvalues: u7 (copy)
    local v16 = u7[p15.Name];

    if v16 ~= nil then
        configureAnimationSet(p15.Name, v16);
    end;
end;

Parent.ChildAdded:connect(scriptChildModified);
Parent.ChildRemoved:connect(scriptChildModified);
local u17 = { "dance1", "dance2", "dance3" };
local u18 = 0;
local u19 = nil;
local u20 = nil;
local u21 = "Standing";
local u22 = "";
local u23 = {
    wave = false,
    point = false,
    dance1 = true,
    dance2 = true,
    dance3 = true,
    laugh = false,
    cheer = false
};
local u24 = nil;
local u25 = 1;

for i, v in pairs(u7) do
    configureAnimationSet(i, v);
end;

local u26 = "None";
local u27 = 0;
local u28 = 0;

function stopAllAnimations()
    -- upvalues: u22 (ref), u23 (copy), u19 (ref), u20 (ref), u24 (ref)
    local v29 = u22;
    local v30 = u23[v29] ~= nil and u23[v29] == false and "idle" or v29;
    u22 = "";
    u19 = nil;

    if u20 ~= nil then
        u20:disconnect();
    end;

    if u24 ~= nil then
        u24:Stop();
        u24:Destroy();
        u24 = nil;
    end;

    return v30;
end;

function setAnimationSpeed(p31)
    -- upvalues: u25 (ref), u24 (ref)
    if p31 ~= u25 then
        u25 = p31;
        u24:AdjustSpeed(u25);
    end;
end;

function keyFrameReachedFunc(p32)
    -- upvalues: u22 (ref), u23 (copy), u25 (ref), Humanoid (copy)
    if p32 == "End" then
        local v33 = u22;
        playAnimation(u23[v33] ~= nil and u23[v33] == false and "idle" or v33, 0, Humanoid);
        setAnimationSpeed(u25);
    end;
end;

function playAnimation(p34, p35, p36)
    -- upvalues: u6 (copy), u19 (ref), u24 (ref), u25 (ref), u22 (ref), u20 (ref)
    local v37 = math.random(1, u6[p34].totalWeight);
    local v38 = 1;

    while u6[p34][v38].weight < v37 do
        v37 = v37 - u6[p34][v38].weight;
        v38 = v38 + 1;
    end;

    local anim = u6[p34][v38].anim;

    if anim ~= u19 then
        if u24 ~= nil then
            u24:Stop(p35);
            u24:Destroy();
        end;

        u25 = 1;
        u24 = p36:LoadAnimation(anim);
        u24.Priority = Enum.AnimationPriority.Core;
        u24:Play(p35);
        u22 = p34;
        u19 = anim;

        if u20 ~= nil then
            u20:disconnect();
        end;

        u20 = u24.KeyframeReached:connect(keyFrameReachedFunc);
    end;
end;

local u39 = "";
local u40 = nil;
local u41 = nil;
local u42 = nil;

function toolKeyFrameReachedFunc(p43)
    -- upvalues: u39 (ref), Humanoid (copy)
    if p43 == "End" then
        playToolAnimation(u39, 0, Humanoid);
    end;
end;

function playToolAnimation(p44, p45, p46, p47)
    -- upvalues: u6 (copy), u41 (ref), u40 (ref), u39 (ref), u42 (ref)
    local v48 = math.random(1, u6[p44].totalWeight);
    local v49 = 1;

    while u6[p44][v49].weight < v48 do
        v48 = v48 - u6[p44][v49].weight;
        v49 = v49 + 1;
    end;

    local anim = u6[p44][v49].anim;

    if u41 ~= anim then
        if u40 ~= nil then
            u40:Stop();
            u40:Destroy();
            p45 = 0;
        end;

        u40 = p46:LoadAnimation(anim);

        if p47 then
            u40.Priority = p47;
        end;

        u40:Play(p45);
        u39 = p44;
        u41 = anim;
        u42 = u40.KeyframeReached:connect(toolKeyFrameReachedFunc);
    end;
end;

function stopToolAnimations()
    -- upvalues: u39 (ref), u42 (ref), u41 (ref), u40 (ref)
    local v50 = u39;

    if u42 ~= nil then
        u42:disconnect();
    end;

    u39 = "";
    u41 = nil;

    if u40 ~= nil then
        u40:Stop();
        u40:Destroy();
        u40 = nil;
    end;

    return v50;
end;

local function resolveMoveAnim(p51) -- Line: 330
    return p51 >= 19 and "run" or "walk";
end;

function onRunning(p52)
    -- upvalues: u18 (ref), Humanoid (copy), u19 (ref), u21 (ref), u23 (copy), u22 (ref)
    u18 = p52;

    if p52 <= 0.01 then
        if u23[u22] == nil then
            playAnimation("idle", 0.1, Humanoid);
            u21 = "Standing";
        end;

        return;
    end;

    playAnimation(p52 >= 19 and "run" or "walk", 0.1, Humanoid);

    if u19 and u19.AnimationId == "http://www.roblox.com/asset/?id=180426354" then
        setAnimationSpeed(p52 / 14.5);
    end;

    u21 = "Running";
end;

function onDied()
    -- upvalues: u21 (ref)
    u21 = "Dead";
end;

function onJumping()
    -- upvalues: Humanoid (copy), u28 (ref), u21 (ref)
    playAnimation("jump", 0.1, Humanoid);
    u28 = 0.3;
    u21 = "Jumping";
end;

function onClimbing(p53)
    -- upvalues: Humanoid (copy), u21 (ref)
    playAnimation("climb", 0.1, Humanoid);
    setAnimationSpeed(p53 / 12);
    u21 = "Climbing";
end;

function onGettingUp()
    -- upvalues: u21 (ref)
    u21 = "GettingUp";
end;

function onFreeFall()
    -- upvalues: u28 (ref), Humanoid (copy), u21 (ref)
    if u28 <= 0 then
        playAnimation("fall", 0.3, Humanoid);
    end;

    u21 = "FreeFall";
end;

function onFallingDown()
    -- upvalues: u21 (ref)
    u21 = "FallingDown";
end;

function onSeated()
    -- upvalues: u21 (ref)
    u21 = "Seated";
end;

function onPlatformStanding()
    -- upvalues: u21 (ref)
    u21 = "PlatformStanding";
end;

function onSwimming(p54)
    -- upvalues: u21 (ref)
    if p54 > 0 then
        u21 = "Running";

        return;
    end;

    u21 = "Standing";
end;

function getTool()
    -- upvalues: Parent2 (copy)
    for _, child in ipairs(Parent2:GetChildren()) do
        if child.className == "Tool" then
            return child;
        end;
    end;

    return nil;
end;

function getToolAnim(p55)
    for _, child in ipairs(p55:GetChildren()) do
        if child.Name == "toolanim" and child.className == "StringValue" then
            return child;
        end;
    end;

    return nil;
end;

function animateTool()
    -- upvalues: u26 (ref), Humanoid (copy)
    if u26 == "None" then
        playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle);

        return;
    end;

    if u26 == "Slash" then
        playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action);

        return;
    end;

    if u26 ~= "Lunge" then
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

local u56 = 0;

function move(p57)
    -- upvalues: u56 (ref), u28 (ref), u21 (ref), Humanoid (copy), u18 (ref), u1 (copy), u2 (copy), u3 (copy), u4 (copy), u26 (ref), u27 (ref), u41 (ref)
    local v58 = 1;
    local v59 = 1;
    local v60 = p57 - u56;
    u56 = p57;
    local v61 = false;

    if u28 > 0 then
        u28 = u28 - v60;
    end;

    if u21 == "FreeFall" and u28 <= 0 then
        playAnimation("fall", 0.3, Humanoid);
    else
        if u21 == "Seated" then
            playAnimation("sit", 0.5, Humanoid);

            return;
        end;

        if u21 == "Running" then
            playAnimation(u18 >= 19 and "run" or "walk", 0.1, Humanoid);
        elseif u21 == "Dead" or (u21 == "GettingUp" or (u21 == "FallingDown" or (u21 == "Seated" or u21 == "PlatformStanding"))) then
            stopAllAnimations();
            v61 = true;
            v59 = 1;
            v58 = 0.1;
        end;
    end;

    if v61 then
        local v62 = v58 * math.sin(p57 * v59);
        u1:SetDesiredAngle(v62 + 0);
        u2:SetDesiredAngle(v62 - 0);
        u3:SetDesiredAngle(-v62);
        u4:SetDesiredAngle(-v62);
    end;

    local v63 = getTool();

    if v63 and v63:FindFirstChild("Handle") then
        local v64 = getToolAnim(v63);

        if v64 then
            u26 = v64.Value;
            v64.Parent = nil;
            u27 = p57 + 0.3;
        end;

        if u27 < p57 then
            u27 = 0;
            u26 = "None";
        end;

        animateTool();

        return;
    end;

    stopToolAnimations();
    u26 = "None";
    u41 = nil;
    u27 = 0;
end;

local u65 = {};
local u66 = Humanoid;
local ReplicatedHumanoid = Parent:WaitForChild("ReplicatedHumanoid");

local function onUnhook() -- Line: 514
    -- upvalues: u65 (ref)
    for i = 1, #u65 do
        u65[i]:Disconnect();
    end;

    u65 = {};
end;

local function onHook() -- Line: 521
    -- upvalues: onUnhook (copy), u21 (ref), u65 (ref), u66 (ref)
    onUnhook();
    u21 = "Standing";
    u65 = {
        u66.Died:connect(onDied),
        u66.Running:connect(onRunning),
        u66.Jumping:connect(onJumping),
        u66.Climbing:connect(onClimbing),
        u66.GettingUp:connect(onGettingUp),
        u66.FreeFalling:connect(onFreeFall),
        u66.FallingDown:connect(onFallingDown),
        u66.Seated:connect(onSeated),
        u66.PlatformStanding:connect(onPlatformStanding),
        u66.Swimming:connect(onSwimming)
    };
end;

ReplicatedHumanoid.Changed:Connect(function() -- Line: 540
    -- upvalues: u66 (ref), ReplicatedHumanoid (copy), onHook (copy)
    u66 = ReplicatedHumanoid.Value;
    onHook();
end);
ReplicatedHumanoid.Value = Humanoid;
game:GetService("Players").LocalPlayer.Chatted:connect(function(p67) -- Line: 548
    -- upvalues: u17 (copy), u21 (ref), u23 (copy), Humanoid (copy)
    local v68 = "";

    if p67 == "/e dance" then
        v68 = u17[math.random(1, #u17)];
    elseif string.sub(p67, 1, 3) == "/e " then
        v68 = string.sub(p67, 4);
    elseif string.sub(p67, 1, 7) == "/emote " then
        v68 = string.sub(p67, 8);
    end;

    if u21 == "Standing" and u23[v68] ~= nil then
        playAnimation(v68, 0.1, Humanoid);
    end;
end);
playAnimation("idle", 0.1, Humanoid);
u21 = "Standing";
spawn(function() -- Line: 571
    -- upvalues: Parent2 (copy)
    while Parent2.Parent ~= nil do
        local _, v69 = wait(0.1);
        move(v69);
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