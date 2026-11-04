 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, u2) -- Line: 11
    -- upvalues: SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy), TweenService (copy)
    SfxManager:playSound({
        Sound = "Ranked Crown",
        Parent = workspace
    });
    local u3 = script.Crown:Clone();
    u3.Parent = Debris;
    u3:PivotTo(u2.CFrame);
    local Highlight = Instance.new("Highlight", u3);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = script:GetAttribute("Color");
    Highlight.FillTransparency = 0.9;
    Highlight.OutlineColor = script:GetAttribute("Color");
    Highlight.OutlineTransparency = 0;
    local NumberValue = Instance.new("NumberValue", u3);
    NumberValue.Changed:Connect(function() -- Line: 26
        -- upvalues: NumberValue (copy), u3 (copy), u2 (copy)
        if NumberValue.Value > 0 then
            u3:ScaleTo(NumberValue.Value);
            u3:PivotTo(u2.CFrame * CFrame.new(0, 0, -1.5 * NumberValue.Value));
        end;
    end);
    u3.Humanoid:LoadAnimation(script.Animation):Play();
    local v4 = script.Emit:Clone();
    v4.Parent = Debris;
    v4.CFrame = u3.Crown.CFrame;
    Essentials:Weld(v4, u3.Crown);
    VfxManager.Emit(v4);
    VfxManager.DestroyEffect(v4, 2);
    NumberValue.Value = 0;
    TweenService:Create(NumberValue, TweenInfo.new(0.5333333333333333), {
        Value = 1
    }):Play();
    task.delay(0.23333333333333334, function() -- Line: 46
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Enable(u3, true);
    end);
    task.delay(3.65, function() -- Line: 50
        -- upvalues: VfxManager (ref), u3 (copy), TweenService (ref), NumberValue (copy)
        VfxManager.Enable(u3, false);
        TweenService:Create(NumberValue, TweenInfo.new(0.85), {
            Value = 0
        }):Play();
    end);
    VfxManager.DestroyEffect(u3, 8);
end;