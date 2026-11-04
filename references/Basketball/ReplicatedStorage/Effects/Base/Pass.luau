 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);

return function(p1, p2) -- Line: 7
    -- upvalues: TweenService (copy)
    local Char = p2.Char;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.FillColor = Color3.new(1, 1, 1);
    Highlight.FillTransparency = 0.35;
    Highlight.Name = "PassHighlight";
    Highlight.Parent = Char;
    TweenService:Create(Highlight, TweenInfo.new(1.4), {
        FillTransparency = 1
    }):Play();
    task.delay(1.4, function() -- Line: 23
        -- upvalues: Highlight (copy)
        Highlight:Destroy();
    end);
    local u3 = script.PassGUI:Clone();
    u3.Parent = Char:FindFirstChild("HumanoidRootPart");
    u3.StudsOffset = Vector3.new(0, 3, 0);
    TweenService:Create(u3, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        StudsOffset = Vector3.new(0, 5, 0)
    }):Play();
    task.delay(1, function() -- Line: 31
        -- upvalues: TweenService (ref), u3 (copy)
        TweenService:Create(u3.Frame.TextLabel, TweenInfo.new(1), {
            TextTransparency = 1
        }):Play();
        TweenService:Create(u3.Frame.TextLabel.UIStroke, TweenInfo.new(1), {
            Transparency = 1
        }):Play();
        task.wait(1);
        u3:Destroy();
    end);
end;