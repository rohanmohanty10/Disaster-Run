  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u1 = TweenInfo.new(0.875, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u2 = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u3 = TweenInfo.new(0.425, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
local u4 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0.525);

return function(p5) -- Line: 15
    -- upvalues: AssetHandler (copy), LocalPlayer (copy), TweenService (copy), u1 (copy), u3 (copy), u4 (copy), u2 (copy), Debris (copy)
    local v6 = AssetHandler.CloneAsset("UIs/KanjisUI", {
        AbilityName = "Uber Oni"
    });
    v6.Parent = LocalPlayer.PlayerGui;
    v6.Enabled = true;

    for _, child in v6:GetChildren() do
        if child:IsA("TextLabel") then
            local u7 = AssetHandler.CloneAsset("UIs/KanjisEffectText", {
                AbilityName = "Uber Oni"
            });
            u7.Parent = child;
            u7.Text = child.Text;
            u7.Visible = true;
            u7.TextColor3 = p5 or Color3.new(1, 1, 1);
            local Position = child.Position;
            local v8 = TweenService:Create(u7, u1, {
                TextTransparency = 0.5,
                Size = UDim2.fromScale(1, 1),
                TextColor3 = Color3.new(0, 0, 0)
            });
            local v9 = TweenService:Create(child, u3, {
                TextStrokeTransparency = 0.5,
                TextTransparency = 0,
                TextColor3 = p5 or Color3.new(1, 1, 1),
                Position = Position
            });
            child.Position = UDim2.fromScale(0.5, 0.5);
            v9:Play();
            v9.Completed:Once(function() -- Line: 50
                -- upvalues: TweenService (ref), child (copy), u4 (ref), Position (copy)
                TweenService:Create(child, u4, {
                    TextTransparency = 1,
                    TextStrokeTransparency = 1,
                    TextColor3 = Color3.new(0, 0, 0),
                    Position = UDim2.fromScale(Position.X.Scale > 0.5 and 1.5 or -1.5, Position.Y.Scale > 0.5 and 1.5 or -1.5)
                }):Play();
            end);
            v8:Play();
            v8.Completed:Once(function() -- Line: 59
                -- upvalues: TweenService (ref), u7 (copy), u2 (ref)
                TweenService:Create(u7, u2, {
                    TextTransparency = 1,
                    Size = UDim2.fromScale(1.1, 1.1)
                }):Play();
            end);
        end;
    end;

    Debris:AddItem(v6, 10);
end;