 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local _ = game.Players.LocalPlayer;

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v.ClassName == "ParticleEmitter" then
            v.Enabled = p2 or false;
        end;
    end;
end;

function EmitAll(p3: table)
    for _, v in next, p3 do
        if v.ClassName == "ParticleEmitter" then
            if v:GetAttribute("EmitDelay") then
                task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 22
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            else
                v:Emit(v:GetAttribute("EmitCount"));
            end;
        end;
    end;
end;

return function(p4, p5) -- Line: 32
    -- upvalues: VfxManager (copy)
    local v6 = script.WaterEmit:Clone();
    v6.CFrame = p5.CFrame * CFrame.Angles(0, 1.5707963267948966, 0);
    v6.Parent = workspace.Debris;
    VfxManager.Emit(v6);
    VfxManager.DestroyEffect(v6, 3);
    local u7 = script.WaterEnable:Clone();
    u7.CFrame = p5.CFrame * CFrame.new(-15, -16, 0);
    u7.Parent = workspace.Debris;
    VfxManager.Enable(u7, true);
    task.delay(1, function() -- Line: 44
        -- upvalues: u7 (copy), VfxManager (ref)
        if u7 then
            VfxManager.Enable(u7, false);
            VfxManager.DestroyEffect(u7, 3);
        end;
    end);
end;