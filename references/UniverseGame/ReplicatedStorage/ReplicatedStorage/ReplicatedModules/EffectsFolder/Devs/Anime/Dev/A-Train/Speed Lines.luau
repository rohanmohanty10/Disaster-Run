  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local u1 = ReplicatedStorage:FindFirstChild("Client Assets");
require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u2 = Random.new();

return function(p3) -- Line: 12
    -- upvalues: u1 (copy), u2 (copy), TweenService (copy)
    local v4 = p3 or {};
    local Character = v4.Character;
    local Attribute = v4.Attribute;

    if not (Character and Attribute) then
        return;
    end;

    local HumanoidRootPart = Character.HumanoidRootPart;
    local v5 = os.clock();

    while true do
        if os.clock() - v5 > 0.022 then
            v5 = os.clock();
            local Unit = HumanoidRootPart.AssemblyLinearVelocity.Unit;

            if Unit == Vector3.new(0, 0, 0) then
                Unit = HumanoidRootPart.CFrame.LookVector;
            end;

            local v6 = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + Unit);
            local u7 = u1.Pirates.Cutlass.PierceMeshes.SpeedLine:Clone();
            local X = u7.Size.X;
            local v8 = u2:NextNumber(0.2, 0.3);
            u7.Size = Vector3.new(X, v8, u2:NextNumber(0.2, 0.3));
            u7.Size = u7.Size * u2:NextNumber(0.75, 1.1);
            u7.CFrame = v6 * CFrame.new(u2:NextNumber(-4, 4), u2:NextNumber(-2, 4), 0) * CFrame.Angles(0, -1.5707963267948966, 0);
            u7.Parent = workspace.Effects;

            if math.random(1, 2) == 1 then
                u7.Color = Color3.new(0, 0, 0);
            end;

            local v9 = TweenService:Create(u7, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = 1,
                Size = Vector3.new(u7.Size.X * 1.4, 0, u7.Size.Z * 1.4)
            });
            v9.Completed:Connect(function() -- Line: 51
                -- upvalues: u7 (copy)
                u7:Destroy();
            end);
            v9:Play();
        end;

        task.wait();

        if not (Character:IsDescendantOf(game) and Character:GetAttribute(Attribute)) then
            return;
        end;
    end;
end;