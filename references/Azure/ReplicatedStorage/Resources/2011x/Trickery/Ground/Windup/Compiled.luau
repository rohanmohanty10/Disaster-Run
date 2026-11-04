 

 

local Part_Icles = require(game:GetService("ReplicatedStorage").Part_Icles);
local LocalPlayer = game:GetService("Players").LocalPlayer;

local function emit(...) -- Line: 4
    -- upvalues: LocalPlayer (copy), Part_Icles (copy)
    local v1 = LocalPlayer and LocalPlayer:FindFirstChild("setting");

    if v1 then
        v1 = v1:FindFirstChild("NoVFXAtAll");
    end;

    if v1 and v1.Value then
        return;
    end;

    for _, v in { ... } do
        Part_Icles:AbsoluteEmit(v);
    end;
end;

return {
    { 0, function(p2, p3, p4, p5) -- Line: 18
            -- upvalues: emit (copy)
            emit(p2["TP GLITCH"], p2.Lightning, p2.Aura, p3.TP);

            if p5 then
                emit(p4.EffectStart, p2.Camshake, p2.CameraEffect2);
            end;
        end },
    { 16, function(p6, p7) -- Line: 26
            -- upvalues: emit (copy)
            p6.Step:PivotTo(p7.HumanoidRootPart.CFrame * CFrame.new(0.55, -2.85, -0.5));
            emit(p6.Step, p7.Step);
        end },
    { 43, function(p8, p9) -- Line: 32
            -- upvalues: emit (copy)
            p8.Step2:PivotTo(p9.HumanoidRootPart.CFrame * CFrame.new(-0.61, -2.85, -0.5));
            emit(p8.Step2, p9.Step);
        end },
    { 67, function(p10, p11) -- Line: 38
            -- upvalues: emit (copy)
            p10.Step3:PivotTo(p11.HumanoidRootPart.CFrame * CFrame.new(0.55, -2.85, -0.5));
            emit(p10.Step3, p11.Step);
        end },
    { 84, function(p12, p13, p14, p15) -- Line: 44
            -- upvalues: emit (copy)
            emit(p12["TP GLITCH"], p12.SmearFrames);

            if p15 then
                emit(p12.CameraEffect, p14.Effect);
            end;
        end }
};