  

local v1 = {};
game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local Essentials = require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 7
    -- upvalues: Essentials (copy), CollectionService (copy)
    local v4 = script.BodyPart:FindFirstChildWhichIsA("BasePart");
    local Name = v4.Name;
    local v5 = script.Item.wings:Clone();
    v5:PivotTo(p2[Name].CFrame * v4.CFrame:ToObjectSpace(v5:GetPivot()));
    v5.Parent = p2;
    Essentials:Weld(p2[Name], v5.PrimaryPart, v5);
    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://123694881317917";
    v5.AnimationController.Animator:LoadAnimation(Animation):Play();
    CollectionService:AddTag(v5, (`Cosmetic{p3}`));
end;

return v1;