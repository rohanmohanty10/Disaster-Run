  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");
local TweenService = game:GetService("TweenService");

return function(p2, ...) -- Line: 8
    -- upvalues: u1 (copy), GenericModule (copy), TweenService (copy)
    for _, child in pairs(p2:GetChildren()) do
        if child:IsA("BasePart") then
            local v3 = u1["Killer Queen"].Death:Clone();

            for _, child2 in pairs(v3:GetChildren()) do
                child2.Parent = child;
            end;

            v3:Destroy();
            GenericModule.LoopedEmit({
                NoDestroy = true,
                ParentObject = child
            });
        end;
    end;

    for _, descendant in pairs(p2:GetDescendants()) do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            TweenService:Create(descendant, TweenInfo.new(0.2), {
                Transparency = 1
            }):Play();
        end;
    end;
end;