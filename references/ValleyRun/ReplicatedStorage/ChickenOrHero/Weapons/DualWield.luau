 

 

local DaggerGrip = require(script.Parent.DaggerGrip);
local KnifeClips = require(script.Parent.KnifeClips);
local KnifeChains = require(script.Parent.KnifeChains);
local u1 = {};

local function mirror(p2, p3) -- Line: 16
    local Components, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 = p2:GetComponents();
    local CFrame_new_ret = CFrame.new(-Components, v4, v5, v6, -v7, -v8, -v9, v10, v11, -v12, v13, v14);

    if p3.Z <= p3.X and p3.Z <= p3.Y then
        return CFrame_new_ret * CFrame.Angles(0, 3.141592653589793, 0);
    end;

    if p3.Y <= p3.X then
        return CFrame_new_ret * CFrame.Angles(0, 0, 3.141592653589793);
    end;

    return CFrame_new_ret;
end;

function u1.grip(p15, p16) -- Line: 29
    -- upvalues: KnifeClips (copy), mirror (copy), DaggerGrip (copy)
    local Attribute = p15:GetAttribute("LeftGrip");

    if typeof(Attribute) == "CFrame" then
        return Attribute;
    end;

    local v17 = not KnifeClips.animated(p15) and p15:GetAttribute("IdleGrip");
    local BladeWeld = p15.Handle.BladeWeld;
    local v18 = DaggerGrip.c0(p15);

    if typeof(v17) ~= "CFrame" then
        v17 = CFrame.identity;
    end;

    return mirror(v18 * v17 * p15:GetAttribute("GripC1"):Inverse() * BladeWeld.C0 * BladeWeld.C1:Inverse(), (p16 or p15.Blade).Size);
end;

local function lookOnly(u19) -- Line: 49
    local function inside(p20) -- Line: 50
        -- upvalues: u19 (copy)
        local v21;

        if p20 == nil then
            v21 = false;
        else
            v21 = p20 == u19 and true or p20:IsDescendantOf(u19);
        end;

        return v21;
    end;

    for _, v in { u19, table.unpack(u19:GetDescendants()) } do
        if v:IsA("JointInstance") or v:IsA("WeldConstraint") then
            local Part0 = v.Part0;
            local v22;

            if Part0 == nil then
                v22 = false;
            else
                v22 = Part0 == u19 and true or Part0:IsDescendantOf(u19);
            end;

            if v22 then
                local Part1 = v.Part1;
                local v23;

                if Part1 == nil then
                    v23 = false;
                else
                    v23 = Part1 == u19 and true or Part1:IsDescendantOf(u19);
                end;

                if not v23 then
                    v:Destroy();
                end;
            else
                v:Destroy();
            end;
        elseif v:IsA("Constraint") then
            v:Destroy();
        elseif v:IsA("Trail") or v:IsA("Beam") then
            local Attachment0 = v.Attachment0;
            local Attachment1 = v.Attachment1;

            if Attachment0 and not Attachment0:IsDescendantOf(u19) or Attachment1 and not Attachment1:IsDescendantOf(u19) then
                v:Destroy();
            end;
        elseif v:IsA("BasePart") then
            v.Anchored = false;
            v.CanCollide = false;
            v.CanTouch = false;
            v.CanQuery = false;
            v.Massless = true;
        end;
    end;

    return u19;
end;

function u1.attach(p24, p25) -- Line: 74
    -- upvalues: KnifeChains (copy), lookOnly (copy), u1 (copy)
    if p24:GetAttribute("IsDualWield") ~= true or (not p25 or KnifeChains.holds(p24, "Left Arm")) then
        return nil;
    end;

    local LeftBlade = p24:FindFirstChild("LeftBlade");
    local v26;

    if LeftBlade then
        v26 = LeftBlade:FindFirstChild("LeftGrip");
    else
        v26 = LeftBlade;
    end;

    if LeftBlade and (LeftBlade:IsA("BasePart") and (v26 and (v26:IsA("Motor6D") and v26.Part1 == LeftBlade))) then
        v26.Part0 = p25;

        return LeftBlade;
    end;

    if LeftBlade then
        LeftBlade:Destroy();
    end;

    local Attribute = p24:GetAttribute("LeftBladeFrom");
    local Models = script.Parent:FindFirstChild("Models");

    if typeof(Attribute) == "string" then
        if Models then
            Models = Models:FindFirstChild(Attribute);
        end;
    else
        Models = false;
    end;

    if Models then
        Models = Models:FindFirstChild("Blade");
    end;

    if not (Models and Models:IsA("BasePart")) then
        Models = p24.Blade;
    end;

    local v27 = lookOnly(Models:Clone());
    v27.Name = "LeftBlade";
    local Motor6D = Instance.new("Motor6D");
    Motor6D.Name = "LeftGrip";
    Motor6D.Part0 = p25;
    Motor6D.Part1 = v27;
    Motor6D.C0 = u1.grip(p24, v27);
    v27.CFrame = p25.CFrame * Motor6D.C0;
    Motor6D.Parent = v27;
    v27.Parent = p24;

    return v27;
end;

function u1.stow(p28, p29) -- Line: 112
    -- upvalues: KnifeChains (copy), lookOnly (copy), mirror (copy)
    local StowedBlade = p28:FindFirstChild("StowedBlade");
    local Attribute = p28:GetAttribute("StowedOffset");

    if p28:GetAttribute("IsDualWield") ~= true or not (p29 and (not KnifeChains.has(p28) and (StowedBlade and (StowedBlade:IsA("BasePart") and typeof(Attribute) == "CFrame")))) then
        return nil;
    end;

    local LeftStowedBlade = p28:FindFirstChild("LeftStowedBlade");
    local v30;

    if LeftStowedBlade then
        v30 = LeftStowedBlade:FindFirstChild("LeftStowedDagger");
    else
        v30 = LeftStowedBlade;
    end;

    if LeftStowedBlade and (LeftStowedBlade:IsA("BasePart") and (v30 and (v30:IsA("JointInstance") and v30.Part1 == LeftStowedBlade))) then
        v30.Part0 = p29;

        return LeftStowedBlade;
    end;

    if LeftStowedBlade then
        LeftStowedBlade:Destroy();
    end;

    local Attribute2 = p28:GetAttribute("LeftBladeFrom");
    local Models = script.Parent:FindFirstChild("Models");

    if typeof(Attribute2) == "string" then
        if Models then
            Models = Models:FindFirstChild(Attribute2);
        end;
    else
        Models = false;
    end;

    if Models then
        Models = Models:FindFirstChild("StowedBlade");
    end;

    if Models then
        if not Models:IsA("BasePart") then
            Models = StowedBlade;
        end;
    else
        Models = StowedBlade;
    end;

    local v31 = lookOnly(Models:Clone());
    v31.Name = "LeftStowedBlade";
    local Attribute3 = p28:GetAttribute("LeftStowedOffset");
    local Weld = Instance.new("Weld");
    Weld.Name = "LeftStowedDagger";
    Weld.Part0 = p29;
    Weld.Part1 = v31;

    if typeof(Attribute3) ~= "CFrame" then
        Attribute3 = mirror(Attribute, v31.Size);
    end;

    Weld.C0 = Attribute3;
    v31.CFrame = p29.CFrame * Weld.C0;
    Weld.Parent = v31;
    v31.Parent = p28;

    return v31;
end;

function u1.stowHealthy(p32, p33, p34) -- Line: 152
    local LeftStowedDagger = p32:FindFirstChild("LeftStowedDagger");
    local v35;

    if p32.Parent == p33 and (p34 ~= nil and (LeftStowedDagger ~= nil and LeftStowedDagger.Part0 == p34)) then
        v35 = LeftStowedDagger.Part1 == p32;
    else
        v35 = false;
    end;

    return v35;
end;

function u1.healthy(p36, p37, p38) -- Line: 158
    local LeftGrip = p36:FindFirstChild("LeftGrip");
    local v39;

    if p36.Parent == p37 and (p38 ~= nil and (LeftGrip ~= nil and LeftGrip.Part0 == p38)) then
        v39 = LeftGrip.Part1 == p36;
    else
        v39 = false;
    end;

    return v39;
end;

return table.freeze(u1);