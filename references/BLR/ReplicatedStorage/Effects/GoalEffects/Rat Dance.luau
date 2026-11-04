  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 9
    -- upvalues: ReplicatedStorage (copy), VfxManager (copy)
    local v2 = ReplicatedStorage.Assets.GoalEffects["Rat Dance"]:Clone();
    local RatdanceEmit = v2.RatdanceEmit;
    local RatdanceEnabled = v2.RatdanceEnabled;
    RatdanceEmit.Parent = workspace.Debris;
    RatdanceEnabled.Parent = workspace.Debris;
    RatdanceEmit.Attachment.Sound:Play();
    RatdanceEmit:PivotTo(p1.Pos * CFrame.new(0, 10, 0));
    RatdanceEnabled:PivotTo(p1.Pos * CFrame.new(0, 10, 0));
    VfxManager.Enable(RatdanceEnabled, true);
    VfxManager.Emit(RatdanceEmit);
    task.wait(8);
    VfxManager.Enable(RatdanceEnabled, false);
    task.wait(2);
    v2:Destroy();
    RatdanceEmit:Destroy();
    RatdanceEnabled:Destroy();
end;