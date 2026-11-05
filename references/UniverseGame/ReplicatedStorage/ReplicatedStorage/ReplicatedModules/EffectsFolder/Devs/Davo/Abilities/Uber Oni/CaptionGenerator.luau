  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(u1) -- Line: 7
    -- upvalues: LocalPlayer (copy), TweenService (copy), EffectsHandler (copy)
    local u2 = script.TheCaption:Clone();
    u2.Parent = LocalPlayer.PlayerGui;
    local Frame = u2.Frame;
    local TextLabel = Frame.TextLabel;
    local v3 = TweenInfo.new(u1.TweenIn or 1, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    local v4 = TweenInfo.new(u1.TweenOut or 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v5 = TweenService:Create(Frame, v3, {
        Position = UDim2.fromScale(0, 0)
    });
    local u6 = TweenService:Create(Frame, v4, {
        Position = UDim2.fromScale(0, -1)
    });
    Frame.Position = UDim2.fromScale(0, -1);
    TextLabel.Text = u1.Text;
    u2.Enabled = true;
    v5:Play();

    if not u1.Permanent then
        v5.Completed:Once(function() -- Line: 26
            -- upvalues: EffectsHandler (ref), u1 (copy), u6 (copy), u2 (copy)
            EffectsHandler.Wait(u1.Time or 1);
            u6:Play();
            u6.Completed:Once(function() -- Line: 29
                -- upvalues: u2 (ref)
                if u2 then
                    u2:Destroy();
                end;
            end);
        end);
    end;
end;