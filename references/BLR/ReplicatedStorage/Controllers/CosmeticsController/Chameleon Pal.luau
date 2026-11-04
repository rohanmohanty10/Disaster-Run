  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local Essentials = require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 7
    -- upvalues: Essentials (copy), CollectionService (copy)
    local v4 = script:FindFirstChildWhichIsA("BasePart");

    for _, child in script.Item:GetChildren() do
        if child:IsA("Model") then
            local v5 = child:Clone();
            local PrimaryPart = v5.PrimaryPart;

            if PrimaryPart then
                v5:PivotTo(p2[v4.Name].CFrame * v4.CFrame:ToObjectSpace(PrimaryPart.CFrame));

                for _, descendant in v5:GetDescendants() do
                    if descendant:IsA("BasePart") then
                        descendant.Massless = true;
                        descendant.Anchored = false;
                        descendant.CanCollide = false;
                    end;
                end;

                v5.Parent = p2;
                Essentials:Weld(p2[v4.Name], PrimaryPart, PrimaryPart);
                local v6 = v5:FindFirstChildWhichIsA("Animator", true);

                if not v6 then
                    local v7 = v5:FindFirstChildWhichIsA("AnimationController") or v5:FindFirstChildWhichIsA("Humanoid");

                    if not v7 then
                        v7 = Instance.new("AnimationController");
                        v7.Parent = v5;
                    end;

                    v6 = Instance.new("Animator");
                    v6.Parent = v7;
                end;

                local Animation = Instance.new("Animation");
                Animation.AnimationId = "rbxassetid://126786204539898";
                local v8 = v6:LoadAnimation(Animation);
                v8.Looped = true;
                v8:Play();
                CollectionService:AddTag(v5, (`Cosmetic{p3}`));
            end;
        else
            local v9 = child:Clone();
            v9.CFrame = p2[v4.Name].CFrame * v4.CFrame:ToObjectSpace(v9.CFrame);
            v9.Massless = true;
            v9.Anchored = false;
            v9.CanCollide = false;
            v9.Parent = p2;
            Essentials:Weld(p2[v4.Name], v9, v9);
            CollectionService:AddTag(v9, (`Cosmetic{p3}`));
        end;
    end;
end;

return v1;