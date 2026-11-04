 
 

local u1 = {};
game:GetService("ServerStorage");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("RunService");
local wiki = require(ReplicatedStorage.wiki);

function u1.getstate(p2) -- Line: 9
    if p2 and p2:FindFirstChild("state") then
        return p2.state;
    end;
end;

function u1.checksameTeam(p3, p4) -- Line: 15
    if typeof(p3) == "Instance" and (p3:IsDescendantOf(game) and (p3:FindFirstChild("state") and (typeof(p4) == "Instance" and (p4:IsDescendantOf(game) and p4:FindFirstChild("state"))))) then
        return p3.state.team.Value == p4.state.team.Value;
    end;

    return false;
end;

function u1.checkteam(p5) -- Line: 28
    if p5:IsDescendantOf(game) and p5:FindFirstChild("state") then
        return p5.state.team.Value;
    end;

    return false;
end;

function u1.checkball(p6) -- Line: 35
    -- upvalues: ReplicatedStorage (copy)
    return ReplicatedStorage.workspace.ballHolder.Value == p6;
end;

function u1.ballHolder() -- Line: 39
    -- upvalues: ReplicatedStorage (copy)
    return ReplicatedStorage.workspace.ballHolder.Value;
end;

function u1.checkflow(p7) -- Line: 43
    return p7:GetAttribute("FlowActive") and true or false;
end;

function u1.getRole(p8) -- Line: 47
    if not (p8 and (p8.Parent and p8:FindFirstChild("state"))) then
        return;
    end;

    if p8.state:FindFirstChild("role") then
        local state = p8.state;

        return state.role.Value, state;
    end;
end;

function u1.checkGK(p9) -- Line: 54
    -- upvalues: u1 (copy)
    local Role, v10 = u1.getRole(p9);

    if Role then
        local workspace2 = u1.getworkspace();

        if workspace2 then
            workspace2 = workspace2:FindFirstChild("disableGK");
        end;

        if workspace2 and workspace2.Value then
            return false;
        end;

        return Role == "GK" and (v10.nearGoal.Value and v10.nearGoal.Value == v10.team.Value) and true or false;
    end;
end;

function u1.checkCM(p11) -- Line: 67
    if p11 and (p11.Parent and p11:FindFirstChild("state")) then
        return p11.state.role.Value == "CM";
    end;

    return false;
end;

function u1.checkStyle(p12) -- Line: 74
    -- upvalues: Players (copy)
    if typeof(p12) ~= "Instance" then
        return;
    end;

    local Attribute = p12:GetAttribute("style");

    if p12:IsDescendantOf(game) then
        if not Attribute and (p12:IsA("Model") and p12:IsDescendantOf(workspace)) then
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(p12);

            if PlayerFromCharacter then
                Attribute = PlayerFromCharacter:GetAttribute("style");
            else
                local state = p12:FindFirstChild("state");

                if not state then
                    return;
                end;

                if state:FindFirstChild("style") then
                    Attribute = state.style.Value;
                else
                    Attribute = nil;
                end;
            end;

            if not Attribute then
                return;
            end;
        end;

        return Attribute;
    end;
end;

function u1.checkforStyles(p13, p14) -- Line: 94
    if not p13 then
        return;
    end;

    local Attribute = p13:GetAttribute("style");

    if Attribute then
        return p13:IsDescendantOf(game) and table.find(p14, Attribute) and true or false;
    end;
end;

function u1.checkReleaseStyle(p15) -- Line: 103
    -- upvalues: u1 (copy), Players (copy), ReplicatedStorage (copy), wiki (copy)
    if not p15 then
        return "new";
    end;

    local v16 = u1.checkStyle(Players:GetPlayerFromCharacter(p15));

    if not v16 then
        return "new";
    end;

    local v17 = ReplicatedStorage:FindFirstChild("modifiers") and ReplicatedStorage.modifiers:FindFirstChild("legacymode");
    local v18 = v16:split("legacy");
    local v19;

    if v17 or v16:find("legacy") then
        if v18 then
            v16 = v18[2] or v16;
        end;

        local v20 = wiki.styles[v16];

        if not (v20 and v20.legacyStyle) then
            return "new";
        end;

        v19 = v20.legacyStyle;
    else
        v19 = "new";
    end;

    return v19;
end;

function u1.getworkspace() -- Line: 129
    -- upvalues: ReplicatedStorage (copy)
    return ReplicatedStorage:FindFirstChild("workspace");
end;

u1.m = "Model";

function u1.ingame(p21) -- Line: 135
    -- upvalues: u1 (copy)
    local state = u1.getstate(p21);

    if state then
        return state.ingame.Value;
    end;
end;

function u1.isTackling(p22) -- Line: 141
    return p22:GetAttribute("Tackling") == true;
end;

function u1.isStunned(p23) -- Line: 145
    -- upvalues: u1 (copy)
    if typeof(p23) ~= "Instance" or not p23:FindFirstChild("state") then
        return true;
    end;

    local v24 = p23:FindFirstChildWhichIsA("Humanoid");

    if not v24 or v24.Health <= 0 then
        return true;
    end;

    local workspace2 = u1.getworkspace();

    if not workspace2 or workspace2.disabled.Value then
        return true;
    end;

    local state = p23.state;
    local v25 = {};

    for _, v in { "ragdoll", "stun", "knockback" } do
        if state:FindFirstChild(v) and state:FindFirstChild(v).Value then
            table.insert(v25, v);
        end;
    end;

    return #v25 > 0, v25;
end;

function u1.statecheck(p26, p27, p28) -- Line: 162
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    if not (p26 and (p26:FindFirstChild("state") and (p26:FindFirstChildOfClass("Humanoid").Health > 0 and (not u1.is_disabled() and (p28 or ReplicatedStorage.workspace.roundstart.Value))))) then
        return true;
    end;

    local state = p26.state;
    local v29 = p27 or {};

    for _, v in { "actived", "ragdoll", "stun", "knockback" } do
        if state:FindFirstChild(v) and (not table.find(v29, v) and state:FindFirstChild(v).Value) then
            return true;
        end;
    end;
end;

function u1.getRandomizedForPlayer(p30) -- Line: 189
    -- upvalues: ReplicatedStorage (copy)
    if typeof(p30) ~= "Instance" or not p30:IsA("Player") then
        return;
    end;

    if ReplicatedStorage:FindFirstChild("modifiers") and ReplicatedStorage.modifiers:FindFirstChild("randomizer") then
        return ReplicatedStorage.modifiers.randomizer:FindFirstChild((tostring(p30.UserId)));
    end;
end;

function u1.getRandomized(p31, p32) -- Line: 195
    -- upvalues: u1 (copy)
    local RandomizedForPlayer = u1.getRandomizedForPlayer(p31);

    if RandomizedForPlayer then
        if p32:sub(1, 5) == "skill" then
            p32 = p32:sub(6);
        end;

        return RandomizedForPlayer:FindFirstChild(p32);
    end;
end;

function u1.getMoveInfoForRandomized(p33) -- Line: 205
    -- upvalues: wiki (copy)
    if not p33 then
        return;
    end;

    local skill = p33:FindFirstChild("skill");
    local style = p33:FindFirstChild("style");

    if not (style and skill) then
        return;
    end;

    local Value = style.Value;

    if wiki.styles[Value] and wiki.styles[Value].movesets then
        local v34 = wiki.styles[Value];
        local v35 = tonumber(skill.Value);
        local v36 = v34.movesets[v35];
        local v37 = `skill{tostring(v35)}`;
        local v38 = `skill{p33.Name}`;

        if not v35 then
            v36 = v34[skill.Value];
            v37 = p33.Name;
            v38 = v37;
        end;

        return { v37, v36, v38 }, style.Value;
    end;
end;

function u1.get_walkjump(p39: userdata, p40: any) -- Line: 225
    -- upvalues: wiki (copy), u1 (copy)
    local v41 = p39:GetScale() or 1;
    local v42 = p39 and p39:GetAttribute("NoScaleChange") and 1 or v41;
    local walkspeed = wiki.walkspeed;
    local v43 = (u1.checkGK(p39) or p39:GetAttribute("AI") and p39:GetAttribute("GoalKeeper")) and wiki.gkjumppower or wiki.jumppower;
    local runwalkspeed = wiki.runwalkspeed;
    local Humanoid = p39:FindFirstChild("Humanoid");

    if not Humanoid then
        return walkspeed, v43;
    end;

    local HumanoidRootPart = p39:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return walkspeed, v43;
    end;

    local movements = p39:FindFirstChild("movements");

    if not movements then
        return walkspeed, v43;
    end;

    local MoveDirection = Humanoid.MoveDirection;
    local v44 = MoveDirection.Magnitude <= 0 or HumanoidRootPart.CFrame.LookVector:Dot(MoveDirection) >= -0.5;

    if u1.checkStyle(p39) == "killua" then
        walkspeed = 30;
        runwalkspeed = 50;
    end;

    if p39:GetAttribute("KuronaSpeedBoost") then
        walkspeed = walkspeed * 1.1;
    end;

    local Attribute = p39:GetAttribute("lockWs");

    if p39:GetAttribute("frozen") then
        Attribute = 0;
        v43 = 0;
    elseif #movements:GetChildren() == 0 then
        if v44 then
            Attribute = runwalkspeed or walkspeed;
        else
            Attribute = walkspeed;
        end;
    elseif not Attribute then
        local v45 = {};
        local v46 = {};
        local v47 = 1;
        local v48 = 1;
        local v49 = false;

        for _, child in ipairs(movements:GetChildren()) do
            local Attribute2 = child:GetAttribute("speed");
            local Attribute3 = child:GetAttribute("jump");
            local Attribute4 = child:GetAttribute("speedMultiplier");
            local Attribute5 = child:GetAttribute("jumpMultiplier");

            if typeof(Attribute2) == "number" then
                table.insert(v45, Attribute2);
                v49 = child:GetAttribute("overrideSpeed") and true or v49;
            end;

            if typeof(Attribute3) == "number" then
                table.insert(v46, Attribute3);
            end;

            if typeof(Attribute4) == "number" then
                v48 = v48 * Attribute4;
            end;

            if typeof(Attribute5) == "number" then
                v47 = v47 * Attribute5;
            end;
        end;

        v43 = math.min(v43, unpack(v46)) * v47;

        if v44 then
            walkspeed = runwalkspeed or walkspeed;
        end;

        if #v45 == 0 then
            Attribute = walkspeed * v48;
        elseif v49 then
            Attribute = math.max(unpack(v45)) * v48;
        else
            Attribute = math.min(walkspeed, unpack(v45)) * v48;
        end;
    end;

    local v50 = Attribute * v42;

    if v42 > 1 then
        v42 = v42 / 1.25 or v42;
    end;

    return v50, v43 * v42;
end;

function u1.kuonIgnoreTeam(p51: userdata?) -- Line: 320
    -- upvalues: Players (copy)
    if not (p51 and p51:IsDescendantOf(game)) then
        return false;
    end;

    if p51:GetAttribute("Kuon") == true then
        return true;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p51);
    local v52;

    if PlayerFromCharacter == nil then
        v52 = false;
    else
        v52 = PlayerFromCharacter:GetAttribute("Kuon") == true;
    end;

    return v52;
end;

function u1.is_disabled() -- Line: 331
    -- upvalues: u1 (copy)
    return u1.getworkspace().disabled.Value;
end;

function u1.simulatesCharacter(p53: userdata?) -- Line: 336
    -- upvalues: Players (copy)
    if typeof(p53) ~= "Instance" then
        return false;
    end;

    if p53:GetAttribute("InMarble") then
        return false;
    end;

    local LocalPlayer = Players.LocalPlayer;

    if not LocalPlayer then
        return false;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p53);

    if PlayerFromCharacter then
        if LocalPlayer:GetAttribute("ControllingUserId") == PlayerFromCharacter.UserId then
            return true;
        end;

        if PlayerFromCharacter == LocalPlayer then
            return LocalPlayer:GetAttribute("BeingControlledBy") == nil;
        end;

        return false;
    end;

    local Attribute = p53:GetAttribute("DummyOwner");
    local v54;

    if Attribute == nil then
        v54 = false;
    else
        v54 = Attribute == LocalPlayer.Name;
    end;

    return v54;
end;

return u1;