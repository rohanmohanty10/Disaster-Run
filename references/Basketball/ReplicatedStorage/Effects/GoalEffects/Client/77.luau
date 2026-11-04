 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v.ClassName == "ParticleEmitter" then
            v.Enabled = p2 or false;
        end;
    end;
end;

function EmitAll(p3: table)
    local v4 = 0;

    for _, v in next, p3 do
        if v.ClassName == "ParticleEmitter" then
            if v:GetAttribute("EmitDelay") then
                task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 26
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            else
                v:Emit(v:GetAttribute("EmitCount"));
            end;

            local v5 = (v:GetAttribute("EmitDelay") or 0) + v.Lifetime.Max;
            v4 = math.max(v4, v5);
        end;
    end;

    return v4;
end;

local function Destroy_Effect(u6: userdata, p7: number) -- Line: 40
    task.delay(p7, function() -- Line: 41
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);
end;

return function(p8, p9) -- Line: 46
    -- upvalues: SfxManager (copy)
    if p9.Preview then
        local Attachment = Instance.new("Attachment");
        Attachment.WorldCFrame = p9.CFrame;
        Attachment.Parent = workspace;
        SfxManager:playSound({
            Sound = "77SFX",
            Parent = Attachment
        }).Ended:Once(function() -- Line: 53
            -- upvalues: Attachment (copy)
            Attachment:Destroy();
        end);
    else
        SfxManager:playSound({
            Sound = "77SFX",
            Parent = workspace
        });
    end;

    local u10 = script.Model:Clone();
    u10.Parent = workspace.Debris;
    u10:PivotTo(p9.CFrame);

    if not p9.Preview then
        EmitAll(u10:GetDescendants());
        task.delay(6.5, function() -- Line: 41
            -- upvalues: u10 (copy)
            u10:Destroy();
        end);

        return;
    end;

    u10:ScaleTo(0.3333333333333333);
    EmitAll(u10:GetDescendants());
    task.delay(6.5, function() -- Line: 41
        -- upvalues: u10 (copy)
        u10:Destroy();
    end);
end;