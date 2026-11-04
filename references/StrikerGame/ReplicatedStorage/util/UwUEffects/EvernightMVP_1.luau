 
 

game:GetService("TweenService");
game:GetService("Lighting");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

local function setScene(p1, p2) -- Line: 5
    if not p1 then
        return;
    end;

    for _, descendant in ipairs(p1:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Transparency = p2 and 0 or 1;

            if descendant:IsA("MeshPart") then
                descendant.Transparency = p2 and 0 or 1;
            end;
        elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
            descendant.Transparency = p2 and 0 or 1;
        elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
            descendant.Enabled = p2;
        elseif descendant:IsA("Beam") then
            descendant.Enabled = p2;
        elseif descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("SurfaceLight")) then
            descendant.Enabled = p2;
        end;
    end;
end;

local vfxUtil = require(ReplicatedStorage.util.vfxUtil);

return {
    [0] = function(p3) -- Line: 30
        -- upvalues: setScene (copy)
        setScene(p3.VFX:FindFirstChild("FirstScene"), true);
        setScene(p3.VFX:FindFirstChild("SecondScene"), false);
    end,

    [3.67] = function(p4) -- Line: 35
        -- upvalues: vfxUtil (copy)
        vfxUtil.enableEffects(p4.Camera.camera, true, "#Speedlines");
    end,

    [4.08] = function(p5) -- Line: 38
        shared.vfx.emit(p5.VFX.Explosion2);
    end,

    [8.75] = function(p6) -- Line: 42
        shared.vfx.emit(p6.VFX.Explosion);
    end,

    [4.03] = function(p7) -- Line: 45
        -- upvalues: vfxUtil (copy)
        vfxUtil.enableEffects(p7.Camera.camera, false, "#Speedlines");
    end,

    [5.42] = function(p8) -- Line: 48
        shared.vfx.emit(p8.VFX.Explosion2);
    end,

    [13.3] = function(p9) -- Line: 51
        -- upvalues: vfxUtil (copy)
        vfxUtil.enableEffects(p9.VFX.Windaround, true, "ParticleEmitter,Beam");
    end,

    [15.2] = function(p10) -- Line: 54
        -- upvalues: vfxUtil (copy)
        vfxUtil.enableEffects(p10.VFX.Windaround, false, "ParticleEmitter,Beam");
    end,

    [15.23] = function(p11) -- Line: 57
        -- upvalues: setScene (copy)
        setScene(p11.VFX:FindFirstChild("FirstScene"), false);
        setScene(p11.VFX:FindFirstChild("SecondScene"), true);
    end
};