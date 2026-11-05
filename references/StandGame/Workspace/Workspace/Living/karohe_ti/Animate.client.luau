 

 

local l__Parent__1 = script.Parent;
local l__Humanoid__2 = l__Parent__1:WaitForChild("Humanoid");
local u1 = "Standing";
local function u2() --[[ Line: 5 ]]
    -- upvalues: l__Parent__1 (copy)
    return l__Parent__1:GetScale();
end;
local u3 = script:FindFirstChild("ScaleDampeningPercent");
local v4, v5 = pcall(function() --[[ Line: 14 ]]
    return UserSettings():IsUserFeatureEnabled("UserAnimateRemoveEmoteChatHook");
end);
local v6 = v4 and v5;
local u7 = "";
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = 1;
local u12 = nil;
local u13 = nil;
local u14 = {};
local u15 = {};
local u16 = {
    idle = {
        {
            id = "http://www.roblox.com/asset/?id=507766666",
            weight = 1
        },
        {
            id = "http://www.roblox.com/asset/?id=507766951",
            weight = 1
        },
        {
            id = "http://www.roblox.com/asset/?id=507766388",
            weight = 9
        }
    },
    walk = {
        {
            id = "http://www.roblox.com/asset/?id=507777826",
            weight = 10
        }
    },
    run = {
        {
            id = "http://www.roblox.com/asset/?id=507767714",
            weight = 10
        }
    },
    swim = {
        {
            id = "http://www.roblox.com/asset/?id=507784897",
            weight = 10
        }
    },
    swimidle = {
        {
            id = "http://www.roblox.com/asset/?id=507785072",
            weight = 10
        }
    },
    jump = {
        {
            id = "http://www.roblox.com/asset/?id=507765000",
            weight = 10
        }
    },
    fall = {
        {
            id = "http://www.roblox.com/asset/?id=507767968",
            weight = 10
        }
    },
    climb = {
        {
            id = "http://www.roblox.com/asset/?id=507765644",
            weight = 10
        }
    },
    sit = {
        {
            id = "http://www.roblox.com/asset/?id=2506281703",
            weight = 10
        }
    },
    toolnone = {
        {
            id = "http://www.roblox.com/asset/?id=507768375",
            weight = 10
        }
    },
    toolslash = {
        {
            id = "http://www.roblox.com/asset/?id=522635514",
            weight = 10
        }
    },
    toollunge = {
        {
            id = "http://www.roblox.com/asset/?id=522638767",
            weight = 10
        }
    },
    wave = {
        {
            id = "http://www.roblox.com/asset/?id=507770239",
            weight = 10
        }
    },
    point = {
        {
            id = "http://www.roblox.com/asset/?id=507770453",
            weight = 10
        }
    },
    dance = {
        {
            id = "http://www.roblox.com/asset/?id=507771019",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=507771955",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=507772104",
            weight = 10
        }
    },
    dance2 = {
        {
            id = "http://www.roblox.com/asset/?id=507776043",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=507776720",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=507776879",
            weight = 10
        }
    },
    dance3 = {
        {
            id = "http://www.roblox.com/asset/?id=507777268",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=507777451",
            weight = 10
        },
        {
            id = "http://www.roblox.com/asset/?id=507777623",
            weight = 10
        }
    },
    laugh = {
        {
            id = "http://www.roblox.com/asset/?id=507770818",
            weight = 10
        }
    },
    cheer = {
        {
            id = "http://www.roblox.com/asset/?id=507770677",
            weight = 10
        }
    }
};
local u17 = {
    wave = false,
    point = false,
    dance = true,
    dance2 = true,
    dance3 = true,
    laugh = false,
    cheer = false
};
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local v23, v24 = pcall(function() --[[ Line: 122 ]]
    return UserSettings():IsUserFeatureEnabled("UserAnimationAbilityManagerFixed");
end);
local u25 = v23 and v24;
function resetManagerListeners()
    -- upvalues: u18 (ref), u19 (ref), u20 (ref)
    if u18 then
        u18:Disconnect();
        u18 = nil;
    end;
    if u19 then
        u19:Disconnect();
        u19 = nil;
    end;
    if u20 then
        u20:Disconnect();
        u20 = nil;
    end;
end;
function teardownManager()
    -- upvalues: u21 (ref), u22 (ref)
    resetManagerListeners();
    u21 = nil;
    u22 = nil;
end;
function processIfManagerBelongsToCharacter(u26)
    -- upvalues: l__Parent__1 (copy), u22 (ref), u21 (ref), u18 (ref), u19 (ref), u20 (ref)
    if u26.RootPart ~= l__Parent__1.PrimaryPart then
        return false;
    end;
    if u22 ~= u26 then
        resetManagerListeners();
        u21 = u26.GroundSensor;
        u18 = u26:GetPropertyChangedSignal("GroundSensor"):Connect(function() --[[ Line: 159 ]]
            -- upvalues: u26 (copy), u18 (ref)
            if processIfManagerBelongsToCharacter(u26) then
                u18:Disconnect();
                u18 = nil;
            end;
        end);
        u19 = u26:GetPropertyChangedSignal("RootPart"):Connect(function() --[[ Line: 165 ]]
            -- upvalues: u26 (copy), u19 (ref)
            if processIfManagerBelongsToCharacter(u26) then
                u19:Disconnect();
                u19 = nil;
            end;
        end);
        u20 = u26.AncestryChanged:Connect(function(_, p27) --[[ Line: 171 ]]
            if p27 == nil then
                resetManagerListeners();
                lookForControllerManager();
            end;
        end);
        u22 = u26;
    end;
    return true;
end;
function setupManager(u28)
    -- upvalues: u22 (ref), u21 (ref), u18 (ref), u19 (ref), l__Parent__1 (copy), u20 (ref)
    u22 = u28;
    u21 = u28.GroundSensor;
    u18 = u28:GetPropertyChangedSignal("GroundSensor"):Connect(function() --[[ Line: 190 ]]
        -- upvalues: u21 (ref), u22 (ref)
        u21 = u22.GroundSensor;
    end);
    u19 = u28:GetPropertyChangedSignal("RootPart"):Connect(function() --[[ Line: 194 ]]
        -- upvalues: u28 (copy), l__Parent__1 (ref)
        if u28.RootPart ~= l__Parent__1.PrimaryPart then
            teardownManager();
            lookForControllerManager();
        end;
    end);
    u20 = u28.AncestryChanged:Connect(function(_, p29) --[[ Line: 201 ]]
        if p29 == nil then
            teardownManager();
            lookForControllerManager();
        end;
    end);
end;
function lookForControllerManager()
    -- upvalues: u25 (ref), l__Parent__1 (copy), u21 (ref), u22 (ref)
    if u25 then
        local u30 = l__Parent__1:FindFirstChildOfClass("ControllerManager");
        if u30 then
            if u30.RootPart == l__Parent__1.PrimaryPart then
                setupManager(u30);
            else
                local u31 = nil;
                u31 = u30:GetPropertyChangedSignal("RootPart"):Connect(function() --[[ Line: 221 ]]
                    -- upvalues: u30 (copy), l__Parent__1 (ref), u31 (ref)
                    if u30.RootPart == l__Parent__1.PrimaryPart then
                        u31:Disconnect();
                        setupManager(u30);
                    end;
                end);
            end;
        else
            local u32 = nil;
            u32 = l__Parent__1.ChildAdded:Connect(function(p33) --[[ Line: 230 ]]
                -- upvalues: u32 (ref)
                if p33:IsA("ControllerManager") then
                    u32:Disconnect();
                    lookForControllerManager();
                end;
            end);
        end;
    else
        u21 = nil;
        u22 = nil;
        local v34 = l__Parent__1:FindFirstChildOfClass("ControllerManager");
        if v34 then
            processIfManagerBelongsToCharacter(v34);
        end;
        if u22 == nil then
            local u35 = nil;
            u35 = l__Parent__1.ChildAdded:Connect(function(p36) --[[ Line: 249 ]]
                -- upvalues: u35 (ref)
                if p36:IsA("ControllerManager") and processIfManagerBelongsToCharacter(p36) then
                    u35:Disconnect();
                    u35 = nil;
                end;
            end);
        end;
    end;
end;
lookForControllerManager();
math.randomseed(tick());
function findExistingAnimationInSet(p37, p38)
    if p37 == nil or p38 == nil then
        return 0;
    end;
    for v39 = 1, p37.count do
        if p37[v39].anim.AnimationId == p38.AnimationId then
            return v39;
        end;
    end;
    return 0;
end;
function configureAnimationSet(u40, u41)
    -- upvalues: u15 (copy), u14 (copy), l__Humanoid__2 (copy)
    if u15[u40] ~= nil then
        for _, v42 in pairs(u15[u40].connections) do
            v42:disconnect();
        end;
    end;
    u15[u40] = {};
    u15[u40].count = 0;
    u15[u40].totalWeight = 0;
    u15[u40].connections = {};
    local u43 = true;
    local v44, _ = pcall(function() --[[ Line: 291 ]]
        -- upvalues: u43 (ref)
        u43 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    u43 = not v44 and true or u43;
    local v45 = script:FindFirstChild(u40);
    if u43 and v45 ~= nil then
        table.insert(u15[u40].connections, v45.ChildAdded:connect(function(_) --[[ Line: 299 ]]
            -- upvalues: u40 (copy), u41 (copy)
            configureAnimationSet(u40, u41);
        end));
        table.insert(u15[u40].connections, v45.ChildRemoved:connect(function(_) --[[ Line: 300 ]]
            -- upvalues: u40 (copy), u41 (copy)
            configureAnimationSet(u40, u41);
        end));
        for _, v46 in pairs(v45:GetChildren()) do
            if v46:IsA("Animation") then
                local v47 = v46:FindFirstChild("Weight");
                local v48 = v47 == nil and 1 or v47.Value;
                u15[u40].count = u15[u40].count + 1;
                local l__count__3 = u15[u40].count;
                u15[u40][l__count__3] = {};
                u15[u40][l__count__3].anim = v46;
                u15[u40][l__count__3].weight = v48;
                u15[u40].totalWeight = u15[u40].totalWeight + u15[u40][l__count__3].weight;
                table.insert(u15[u40].connections, v46.Changed:connect(function(_) --[[ Line: 316 ]]
                    -- upvalues: u40 (copy), u41 (copy)
                    configureAnimationSet(u40, u41);
                end));
                table.insert(u15[u40].connections, v46.ChildAdded:connect(function(_) --[[ Line: 317 ]]
                    -- upvalues: u40 (copy), u41 (copy)
                    configureAnimationSet(u40, u41);
                end));
                table.insert(u15[u40].connections, v46.ChildRemoved:connect(function(_) --[[ Line: 318 ]]
                    -- upvalues: u40 (copy), u41 (copy)
                    configureAnimationSet(u40, u41);
                end));
            end;
        end;
    end;
    if u15[u40].count <= 0 then
        for v49, v50 in pairs(u41) do
            u15[u40][v49] = {};
            u15[u40][v49].anim = Instance.new("Animation");
            u15[u40][v49].anim.Name = u40;
            u15[u40][v49].anim.AnimationId = v50.id;
            u15[u40][v49].weight = v50.weight;
            u15[u40].count = u15[u40].count + 1;
            u15[u40].totalWeight = u15[u40].totalWeight + v50.weight;
        end;
    end;
    for _, v51 in pairs(u15) do
        for v52 = 1, v51.count do
            if u14[v51[v52].anim.AnimationId] == nil then
                l__Humanoid__2:LoadAnimation(v51[v52].anim);
                u14[v51[v52].anim.AnimationId] = true;
            end;
        end;
    end;
end;
function configureAnimationSetOld(u53, u54)
    -- upvalues: u15 (copy), l__Humanoid__2 (copy)
    if u15[u53] ~= nil then
        for _, v55 in pairs(u15[u53].connections) do
            v55:disconnect();
        end;
    end;
    u15[u53] = {};
    u15[u53].count = 0;
    u15[u53].totalWeight = 0;
    u15[u53].connections = {};
    local u56 = true;
    local v57, _ = pcall(function() --[[ Line: 362 ]]
        -- upvalues: u56 (ref)
        u56 = game:GetService("StarterPlayer").AllowCustomAnimations;
    end);
    u56 = not v57 and true or u56;
    local v58 = script:FindFirstChild(u53);
    if u56 and v58 ~= nil then
        table.insert(u15[u53].connections, v58.ChildAdded:connect(function(_) --[[ Line: 370 ]]
            -- upvalues: u53 (copy), u54 (copy)
            configureAnimationSet(u53, u54);
        end));
        table.insert(u15[u53].connections, v58.ChildRemoved:connect(function(_) --[[ Line: 371 ]]
            -- upvalues: u53 (copy), u54 (copy)
            configureAnimationSet(u53, u54);
        end));
        local v59 = 1;
        for _, v60 in pairs(v58:GetChildren()) do
            if v60:IsA("Animation") then
                table.insert(u15[u53].connections, v60.Changed:connect(function(_) --[[ Line: 375 ]]
                    -- upvalues: u53 (copy), u54 (copy)
                    configureAnimationSet(u53, u54);
                end));
                u15[u53][v59] = {};
                u15[u53][v59].anim = v60;
                local v61 = v60:FindFirstChild("Weight");
                if v61 == nil then
                    u15[u53][v59].weight = 1;
                else
                    u15[u53][v59].weight = v61.Value;
                end;
                u15[u53].count = u15[u53].count + 1;
                u15[u53].totalWeight = u15[u53].totalWeight + u15[u53][v59].weight;
                v59 = v59 + 1;
            end;
        end;
    end;
    if u15[u53].count <= 0 then
        for v62, v63 in pairs(u54) do
            u15[u53][v62] = {};
            u15[u53][v62].anim = Instance.new("Animation");
            u15[u53][v62].anim.Name = u53;
            u15[u53][v62].anim.AnimationId = v63.id;
            u15[u53][v62].weight = v63.weight;
            u15[u53].count = u15[u53].count + 1;
            u15[u53].totalWeight = u15[u53].totalWeight + v63.weight;
        end;
    end;
    for _, v64 in pairs(u15) do
        for v65 = 1, v64.count do
            l__Humanoid__2:LoadAnimation(v64[v65].anim);
        end;
    end;
end;
function scriptChildModified(p66)
    -- upvalues: u16 (copy)
    local v67 = u16[p66.Name];
    if v67 ~= nil then
        configureAnimationSet(p66.Name, v67);
    end;
end;
script.ChildAdded:connect(scriptChildModified);
script.ChildRemoved:connect(scriptChildModified);
local v68;
if l__Humanoid__2 then
    v68 = l__Humanoid__2:FindFirstChildOfClass("Animator");
else
    v68 = nil;
end;
local u69, u70;
if v68 then
    local v71 = v68:GetPlayingAnimationTracks();
    u69 = u22;
    u70 = u21;
    for _, v72 in ipairs(v71) do
        v72:Stop(0);
        v72:Destroy();
    end;
else
    u69 = u22;
    u70 = u21;
end;
for v73, v74 in pairs(u16) do
    configureAnimationSet(v73, v74);
end;
local u75 = "None";
local u76 = 0;
local u77 = 0;
local u78 = false;
function stopAllAnimations()
    -- upvalues: u7 (ref), u17 (copy), u78 (ref), u8 (ref), u10 (ref), u9 (ref), u13 (ref), u12 (ref)
    local v79 = u7;
    local v80 = u17[v79] ~= nil and u17[v79] == false and "idle" or v79;
    if u78 then
        v80 = "idle";
        u78 = false;
    end;
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
    if u13 ~= nil then
        u13:disconnect();
    end;
    if u12 ~= nil then
        u12:Stop();
        u12:Destroy();
        u12 = nil;
    end;
    return v80;
end;
function getHeightScale()
    -- upvalues: l__Humanoid__2 (copy), u2 (copy), u3 (ref)
    if not l__Humanoid__2 then
        return u2();
    end;
    if not l__Humanoid__2.AutomaticScalingEnabled then
        return u2();
    end;
    local v81 = l__Humanoid__2.HipHeight / 2;
    if u3 == nil then
        u3 = script:FindFirstChild("ScaleDampeningPercent");
    end;
    if u3 ~= nil then
        v81 = 1 + (l__Humanoid__2.HipHeight - 2) * u3.Value / 2;
    end;
    return v81;
end;
local function u87(p82) --[[ Line: 522 ]]
    -- upvalues: u9 (ref), u12 (ref)
    local v83 = p82 * 1.25 / getHeightScale();
    local v84 = 0.0001;
    local v85 = 0.0001;
    local v86 = 1;
    if v83 <= 0.5 then
        v86 = v83 / 0.5;
        v84 = 1;
    elseif v83 < 1 then
        v85 = (v83 - 0.5) / 0.5;
        v84 = 1 - v85;
    else
        v86 = v83 / 1;
        v85 = 1;
    end;
    u9:AdjustWeight(v84);
    u12:AdjustWeight(v85);
    u9:AdjustSpeed(v86);
    u12:AdjustSpeed(v86);
end;
function setAnimationSpeed(p88)
    -- upvalues: u7 (ref), u87 (copy), u11 (ref), u9 (ref)
    if u7 == "walk" then
        u87(p88);
    else
        if p88 ~= u11 then
            u11 = p88;
            u9:AdjustSpeed(u11);
        end;
    end;
end;
function keyFrameReachedFunc(p89)
    -- upvalues: u7 (ref), u12 (ref), u9 (ref), u17 (copy), u78 (ref), u11 (ref), l__Humanoid__2 (copy)
    if p89 == "End" then
        if u7 == "walk" then
            if u12.Looped ~= true then
                u12.TimePosition = 0;
            end;
            if u9.Looped ~= true then
                u9.TimePosition = 0;
            end;
        else
            local v90 = u7;
            local v91 = u17[v90] ~= nil and u17[v90] == false and "idle" or v90;
            if u78 then
                if u9.Looped then
                    return;
                end;
                v91 = "idle";
                u78 = false;
            end;
            local v92 = u11;
            playAnimation(v91, 0.15, l__Humanoid__2);
            setAnimationSpeed(v92);
        end;
    end;
end;
function rollAnimation(p93)
    -- upvalues: u15 (copy)
    local v94 = math.random(1, u15[p93].totalWeight);
    local v95 = 1;
    while u15[p93][v95].weight < v94 do
        v94 = v94 - u15[p93][v95].weight;
        v95 = v95 + 1;
    end;
    return v95;
end;
local function u101(p96, p97, p98, p99) --[[ Line: 603 ]]
    -- upvalues: u8 (ref), u9 (ref), u12 (ref), u11 (ref), u7 (ref), u10 (ref), u15 (copy), u13 (ref)
    if p96 ~= u8 then
        if u9 ~= nil then
            u9:Stop(p98);
            u9:Destroy();
        end;
        if u12 ~= nil then
            u12:Stop(p98);
            u12:Destroy();
            u12 = nil;
        end;
        u11 = 1;
        u9 = p99:LoadAnimation(p96);
        u9.Priority = Enum.AnimationPriority.Core;
        u9:Play(p98);
        u7 = p97;
        u8 = p96;
        if u10 ~= nil then
            u10:disconnect();
        end;
        u10 = u9.KeyframeReached:connect(keyFrameReachedFunc);
        if p97 == "walk" then
            local v100 = rollAnimation("run");
            u12 = p99:LoadAnimation(u15.run[v100].anim);
            u12.Priority = Enum.AnimationPriority.Core;
            u12:Play(p98);
            if u13 ~= nil then
                u13:disconnect();
            end;
            u13 = u12.KeyframeReached:connect(keyFrameReachedFunc);
        end;
    end;
end;
function playAnimation(p102, p103, p104)
    -- upvalues: u15 (copy), u101 (copy), u78 (ref)
    local v105 = rollAnimation(p102);
    u101(u15[p102][v105].anim, p102, p103, p104);
    u78 = false;
end;
function playEmote(p106, p107, p108)
    -- upvalues: u101 (copy), u78 (ref)
    u101(p106, p106.Name, p107, p108);
    u78 = true;
end;
local u109 = "";
local u110 = nil;
local u111 = nil;
local u112 = nil;
function toolKeyFrameReachedFunc(p113)
    -- upvalues: u109 (ref), l__Humanoid__2 (copy)
    if p113 == "End" then
        playToolAnimation(u109, 0, l__Humanoid__2);
    end;
end;
function playToolAnimation(p114, p115, p116, p117)
    -- upvalues: u15 (copy), u111 (ref), u110 (ref), u109 (ref), u112 (ref)
    local v118 = rollAnimation(p114);
    local l__anim__4 = u15[p114][v118].anim;
    if u111 ~= l__anim__4 then
        if u110 ~= nil then
            u110:Stop();
            u110:Destroy();
            p115 = 0;
        end;
        u110 = p116:LoadAnimation(l__anim__4);
        if p117 then
            u110.Priority = p117;
        end;
        u110:Play(p115);
        u109 = p114;
        u111 = l__anim__4;
        u112 = u110.KeyframeReached:connect(toolKeyFrameReachedFunc);
    end;
end;
function stopToolAnimations()
    -- upvalues: u109 (ref), u112 (ref), u111 (ref), u110 (ref)
    local v119 = u109;
    if u112 ~= nil then
        u112:disconnect();
    end;
    u109 = "";
    u111 = nil;
    if u110 ~= nil then
        u110:Stop();
        u110:Destroy();
        u110 = nil;
    end;
    return v119;
end;
function onRunning(p120)
    -- upvalues: u70 (ref), l__Humanoid__2 (copy), u69 (ref), u78 (ref), u1 (ref), u17 (copy), u7 (ref)
    local v121 = getHeightScale();
    if u70 ~= nil and l__Humanoid__2.EvaluateStateMachine == false then
        local l__RootPart__5 = l__Humanoid__2.RootPart;
        local l__SensedPart__6 = u70.SensedPart;
        if l__SensedPart__6 then
            local v122 = l__SensedPart__6:GetVelocityAtPosition(u70.HitFrame.Position);
            local l__AssemblyLinearVelocity__7 = l__RootPart__5.AssemblyLinearVelocity;
            local l__Magnitude__8 = Vector3.new(l__AssemblyLinearVelocity__7.X - v122.X, 0, l__AssemblyLinearVelocity__7.Z - v122.Z).Magnitude;
            local l__Magnitude__9 = u69.MovingDirection.Magnitude;
            if l__Magnitude__9 < 0.1 then
                l__Magnitude__8 = 0;
                l__Magnitude__9 = 0;
            elseif l__Magnitude__9 > 1 then
                l__Magnitude__9 = 1;
            end;
            p120 = l__Magnitude__8 * l__Magnitude__9;
        end;
    end;
    local v123 = u78;
    if v123 then
        v123 = l__Humanoid__2.MoveDirection == Vector3.new(0, 0, 0);
    end;
    if (v123 and (l__Humanoid__2.WalkSpeed / v121 or 0.75) or 0.75) * v121 < p120 then
        playAnimation("walk", 0.2, l__Humanoid__2);
        setAnimationSpeed(p120 / 16);
        u1 = "Running";
    else
        if u17[u7] == nil and not u78 then
            playAnimation("idle", 0.2, l__Humanoid__2);
            u1 = "Standing";
        end;
    end;
end;
function onDied()
    -- upvalues: u1 (ref)
    u1 = "Dead";
end;
function onJumping()
    -- upvalues: l__Humanoid__2 (copy), u77 (ref), u1 (ref)
    playAnimation("jump", 0.1, l__Humanoid__2);
    u77 = 0.31;
    u1 = "Jumping";
end;
function onClimbing(p124)
    -- upvalues: l__Humanoid__2 (copy), u1 (ref)
    local v125 = p124 / getHeightScale();
    playAnimation("climb", 0.1, l__Humanoid__2);
    setAnimationSpeed(v125 / 5);
    u1 = "Climbing";
end;
function onGettingUp()
    -- upvalues: u1 (ref)
    u1 = "GettingUp";
end;
function onFreeFall()
    -- upvalues: u77 (ref), l__Humanoid__2 (copy), u1 (ref)
    if u77 <= 0 then
        playAnimation("fall", 0.2, l__Humanoid__2);
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
function onSwimming(p126)
    -- upvalues: l__Humanoid__2 (copy), u1 (ref)
    local v127 = p126 / getHeightScale();
    if v127 > 1 then
        playAnimation("swim", 0.4, l__Humanoid__2);
        setAnimationSpeed(v127 / 10);
        u1 = "Swimming";
    else
        playAnimation("swimidle", 0.4, l__Humanoid__2);
        u1 = "Standing";
    end;
end;
function animateTool()
    -- upvalues: u75 (ref), l__Humanoid__2 (copy)
    if u75 == "None" then
        playToolAnimation("toolnone", 0.1, l__Humanoid__2, Enum.AnimationPriority.Idle);
    elseif u75 == "Slash" then
        playToolAnimation("toolslash", 0, l__Humanoid__2, Enum.AnimationPriority.Action);
    elseif u75 == "Lunge" then
        playToolAnimation("toollunge", 0, l__Humanoid__2, Enum.AnimationPriority.Action);
    end;
end;
function getToolAnim(p128)
    for _, v129 in ipairs(p128:GetChildren()) do
        if v129.Name == "toolanim" and v129.className == "StringValue" then
            return v129;
        end;
    end;
    return nil;
end;
local u130 = 0;
function stepAnimate(p131)
    -- upvalues: u130 (ref), u77 (ref), u1 (ref), l__Humanoid__2 (copy), l__Parent__1 (copy), u75 (ref), u76 (ref), u111 (ref)
    local v132 = p131 - u130;
    u130 = p131;
    if u77 > 0 then
        u77 = u77 - v132;
    end;
    if u1 == "FreeFall" and u77 <= 0 then
        playAnimation("fall", 0.2, l__Humanoid__2);
    else
        if u1 == "Seated" then
            playAnimation("sit", 0.5, l__Humanoid__2);
            return;
        end;
        if u1 == "Running" then
            playAnimation("walk", 0.2, l__Humanoid__2);
        elseif u1 == "Dead" or (u1 == "GettingUp" or (u1 == "FallingDown" or (u1 == "Seated" or u1 == "PlatformStanding"))) then
            stopAllAnimations();
        end;
    end;
    local v133 = l__Parent__1:FindFirstChildOfClass("Tool");
    if v133 and v133:FindFirstChild("Handle") then
        local v134 = getToolAnim(v133);
        if v134 then
            u75 = v134.Value;
            v134.Parent = nil;
            u76 = p131 + 0.3;
        end;
        if u76 < p131 then
            u76 = 0;
            u75 = "None";
        end;
        animateTool();
    else
        stopToolAnimations();
        u75 = "None";
        u111 = nil;
        u76 = 0;
    end;
end;
l__Humanoid__2.Died:connect(onDied);
l__Humanoid__2.Running:connect(onRunning);
l__Humanoid__2.Jumping:connect(onJumping);
l__Humanoid__2.Climbing:connect(onClimbing);
l__Humanoid__2.GettingUp:connect(onGettingUp);
l__Humanoid__2.FreeFalling:connect(onFreeFall);
l__Humanoid__2.FallingDown:connect(onFallingDown);
l__Humanoid__2.Seated:connect(onSeated);
l__Humanoid__2.PlatformStanding:connect(onPlatformStanding);
l__Humanoid__2.Swimming:connect(onSwimming);
if not v6 then
    game:GetService("Players").LocalPlayer.Chatted:connect(function(p135) --[[ Line: 924 ]]
        -- upvalues: u1 (ref), u17 (copy), l__Humanoid__2 (copy)
        local v136 = "";
        if string.sub(p135, 1, 3) == "/e " then
            v136 = string.sub(p135, 4);
        elseif string.sub(p135, 1, 7) == "/emote " then
            v136 = string.sub(p135, 8);
        end;
        if u1 == "Standing" and u17[v136] ~= nil then
            playAnimation(v136, 0.1, l__Humanoid__2);
        end;
    end);
end;
script:WaitForChild("PlayEmote").OnInvoke = function(p137) --[[ Line: 939 ]]
    -- upvalues: u1 (ref), u17 (copy), l__Humanoid__2 (copy), u9 (ref)
    if u1 == "Standing" then
        if u17[p137] ~= nil then
            playAnimation(p137, 0.1, l__Humanoid__2);
            return true, u9;
        end;
        if typeof(p137) ~= "Instance" or not p137:IsA("Animation") then
            return false;
        end;
        playEmote(p137, 0.1, l__Humanoid__2);
        return true, u9;
    end;
end;
if l__Parent__1.Parent ~= nil then
    playAnimation("idle", 0.1, l__Humanoid__2);
    local _ = "Standing";
end;
while l__Parent__1.Parent ~= nil do
    local _, v138 = wait(0.1);
    stepAnimate(v138);
end;