 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 10
    -- upvalues: SfxManager (copy), Debris (copy), Lighting (copy), TweenService (copy), VfxManager (copy)
    SfxManager:playSound({
        Sound = "NukeSFX",
        Parent = workspace
    });
    local u3 = script.Nuke:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame * CFrame.Angles(0, 1.5707963267948966, 0));
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u4 = ColorCorrection:Clone();
    u4.Name = "CC";
    u4.Parent = Lighting;
    u4.Enabled = true;
    task.delay(4.7135, function() -- Line: 25
        -- upvalues: u4 (copy), Lighting (ref), ColorCorrection (copy)
        u4:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    Lighting:FindFirstChild("Bloom").Enabled = false;
    TweenService:Create(u3.Nuke, TweenInfo.new(0.9, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        Position = p2.CFrame.Position
    }):Play();
    VfxManager.Enable(u3.Nuke, true);
    VfxManager.Enable(u3.Aim, true);
    task.delay(0.36666666666666664, function() -- Line: 40
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Emit(u3.Start);
        VfxManager.Enable(u3.Aim, false);
    end);
    task.delay(0.9, function() -- Line: 45
        -- upvalues: u3 (copy), VfxManager (ref)
        u3.Nuke.Transparency = 1;
        VfxManager.Emit(u3.Emit);
        VfxManager.Enable(u3.Nuke, false);
    end);
    VfxManager.DestroyEffect(u3, 4);
end;