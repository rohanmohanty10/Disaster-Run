 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);

return function(p1, p2) -- Line: 11
    -- upvalues: SfxManager (copy), VfxManager (copy)
    if p2.Preview then
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = workspace.Terrain;
        Attachment.WorldPosition = p2.CFrame.Position;
        SfxManager:playSound({
            Sound = "Perfect GoalSFX",
            Parent = Attachment
        }).Ended:Once(function() -- Line: 18
            -- upvalues: Attachment (copy)
            Attachment:Destroy();
        end);
    else
        SfxManager:playSound({
            Sound = "Perfect GoalSFX",
            Parent = workspace
        });
    end;

    local v3 = script.Emit:Clone();
    v3.Parent = workspace.Debris;
    v3:PivotTo(p2.CFrame);

    if p2.Preview then
        local Model = Instance.new("Model");
        v3.Parent = Model;
        Model.PrimaryPart = v3;
        Model:ScaleTo(0.3333333333333333);
        v3.Parent = workspace.Debris;
        v3.ScreenEffect:Destroy();
        Model:Destroy();
    end;

    VfxManager.DestroyEffect(v3, 8);
    shared.vfx.emit(v3);
end;