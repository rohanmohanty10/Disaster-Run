 

 

local l__TweenService__1 = game:GetService("TweenService");
local u17 = {
    QuickWeld = function(_, p1, p2, p3, p4) --[[ Name: QuickWeld, Line 6 ]]
        local v5 = Instance.new("Weld");
        v5.Part0 = p1;
        v5.Part1 = p2;
        if p3 ~= nil then
            v5.C0 = p3;
        end;
        if p4 ~= nil then
            v5.C1 = p4;
        end;
        v5.Parent = p1;
        return v5;
    end,
    QuickMotor6d = function(_, p6, p7, p8, p9) --[[ Name: QuickMotor6d, Line 22 ]]
        local v10 = Instance.new("Motor6D");
        v10.Part0 = p6;
        v10.Part1 = p7;
        if p8 ~= nil then
            v10.C0 = p8;
        end;
        if p9 ~= nil then
            v10.C1 = p9;
        end;
        v10.Parent = p6;
        return v10;
    end,
    GetBodyParts = function(_, p11) --[[ Name: GetBodyParts, Line 38 ]]
        if p11 == "R6" then
            return {
                "Head",
                "Left Arm",
                "Left Leg",
                "Right Arm",
                "Right Leg",
                "Torso"
            };
        end;
        if p11 == "R15" then
            return {
                "RightUpperArm",
                "RightLowerArm",
                "RightHand",
                "LeftUpperArm",
                "LeftLowerArm",
                "LeftHand",
                "LeftUpperLeg",
                "LeftLowerLeg",
                "LeftFoot",
                "RightUpperLeg",
                "RightLowerLeg",
                "RightFoot",
                "Head",
                "UpperTorso",
                "LowerTorso"
            };
        end;
    end,
    AddItem = function(_, u12, p13) --[[ Name: AddItem, Line 69 ]]
        task.delay(p13, function() --[[ Line: 70 ]]
            -- upvalues: u12 (copy)
            u12:Destroy();
        end);
    end,
    Emit = function(_, p14, p15) --[[ Name: Emit, Line 75 ]]
        for _, v16 in ipairs(p14:GetDescendants()) do
            if v16:IsA("ParticleEmitter") then
                v16:Emit(v16:GetAttribute("EmitCount") or p15);
            end;
        end;
    end
};
function u17.DelayEmit(_, u18, p19) --[[ Line: 83 ]]
    -- upvalues: u17 (copy)
    task.delay(p19, function() --[[ Line: 84 ]]
        -- upvalues: u17 (ref), u18 (copy)
        u17:Emit(u18);
    end);
end;
function u17.ToggleEnabled(_, p20, p21) --[[ Line: 89 ]]
    for _, v22 in ipairs(p20:GetDescendants()) do
        if v22:IsA("ParticleEmitter") then
            v22.Enabled = p21;
        end;
    end;
end;
function u17.GetLerp(_, p23, p24, p25) --[[ Line: 98 ]]
    return p23 + (p24 - p23) * p25;
end;
function u17.GetQuadBezier(_, p26, p27, p28, p29) --[[ Line: 102 ]]
    -- upvalues: u17 (copy)
    return u17:GetLerp(u17:GetLerp(p27, p28, p26), u17:GetLerp(p28, p29, p26), p26);
end;
function u17.Tween(_, p30, p31, p32) --[[ Line: 109 ]]
    -- upvalues: l__TweenService__1 (copy)
    return l__TweenService__1:Create(p30, TweenInfo.new(p31[1] or 0.5, Enum.EasingStyle[p31[2]] or Enum.EasingStyle.Quad, Enum.EasingDirection[p31[3]] or Enum.EasingDirection.Out, p31[4] or 0, p31[5] or false, p31[6] or 0), p32);
end;
function u17.PlaySound(_, p33, p34) --[[ Line: 123 ]]
    -- upvalues: u17 (copy)
    local v35 = p33:Clone();
    v35.Parent = p34;
    v35:Play();
    u17:AddItem(v35, v35.TimeLength);
    return v35;
end;
return u17;