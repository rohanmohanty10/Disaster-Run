  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);

return function(p1) -- Line: 11
    -- upvalues: Debris (copy), VfxManager (copy)
    local Char = p1.Char;
    local v2 = p1.Air and Char.Head or Char.HumanoidRootPart;

    for _, child in script.HumanoidRootPart:GetChildren() do
        local v3 = child:Clone();
        v3.Parent = v2;
        Debris:AddItem(v3, 3);
    end;

    task.wait(0.1);
    VfxManager.Emit(v2.att1);
    VfxManager.Emit(v2.att2);
end;