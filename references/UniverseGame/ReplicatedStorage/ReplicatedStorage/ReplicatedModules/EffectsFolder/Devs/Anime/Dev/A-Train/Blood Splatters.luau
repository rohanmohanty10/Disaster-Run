  

 

game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Random.new();
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };
local u3 = script.Splatters:GetChildren();
local u4 = script.Sounds:GetChildren();

return function(p5) -- Line: 17
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), u4 (copy), SoundService (copy), AssetHandler (copy), TweenService (copy)
    local v6 = p5 or {};
    local Character = v6.Character;
    local Attribute = v6.Attribute;
    local v7 = v6.Interval or 1;
    local v8 = v6.Offset or CFrame.identity;
    local v9 = v6.Lifetime or Vector2.new(3, 3.5);

    if not (Character and Attribute) then
        return;
    end;

    local HumanoidRootPart = Character.HumanoidRootPart;
    local v10 = os.clock();
    local v11 = 1;

    while true do
        if v7 < os.clock() - v10 then
            local v12 = HumanoidRootPart.CFrame * v8 * CFrame.new(u1:NextNumber(-5, 5), 0, u1:NextNumber(-3, 3));
            local v13 = workspace:Raycast(v12.Position, v12.UpVector * -15, u2);

            if v13 then
                v10 = os.clock();
                v11 = v11 + 1;
                local v14 = u1:NextNumber(v9.X, v9.Y);
                local u15 = u3[math.random(1, #u3)]:Clone();
                u15.Name = "Splatter";
                u15.CFrame = CFrame.new(v13.Position, v13.Position + v13.Normal) * CFrame.Angles(-1.5707963267948966, u1:NextNumber(0, 6.283185307179586), 0);
                u15.Parent = workspace.Effects;
                local v16 = u15:FindFirstChildOfClass("Decal");
                v16.Color3 = Color3.fromRGB(72, 0, 0);

                if v6.PlaySounds and v11 % 3 == 0 then
                    local v17 = u4[math.random(1, #u4)]:Clone();
                    v17.SoundGroup = SoundService.StandSounds;
                    v17.Parent = u15;
                    v17:Play();
                end;

                AssetHandler.ScaleAsset(u15, {
                    Scale = u1:NextNumber(0.7, 1.1)
                });
                local v18 = TweenService:Create(v16, TweenInfo.new(v14 * 0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, v14 * 0.75), {
                    Transparency = 1,
                    Color3 = Color3.fromRGB(25, 0, 0)
                });
                v18.Completed:Connect(function() -- Line: 67
                    -- upvalues: u15 (copy)
                    u15:Destroy();
                end);
                v18:Play();
            end;
        end;

        task.wait();

        if not (Character:IsDescendantOf(game) and Character:GetAttribute(Attribute)) then
            return;
        end;
    end;
end;