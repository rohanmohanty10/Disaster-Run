  

 

local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
Random.new();

return function(u1) -- Line: 8
    -- upvalues: CollectionService (copy), TweenService (copy), EffectsHandler (copy)
    if not u1 then
        return;
    end;

    u1:FindFirstChild("HumanoidRootPart");
    local Torso = u1:FindFirstChild("Torso");
    local u2 = TweenInfo.new(0.4);
    local Position = Torso.Position;
    local v3 = 0;
    local u4 = {
        Transparency = 1
    };
    local u5 = { "Humanoid", "BodyColors", "Folder", "Accessory" };

    while CollectionService:HasTag(u1, "Gear 5") and u1.Parent do
        if (Torso.Position - Position).Magnitude > 0.5 and os.clock() - v3 >= 0.2 then
            v3 = os.clock();
            task.spawn(function() -- Line: 32
                -- upvalues: u1 (copy), TweenService (ref), u2 (copy), u4 (copy), u5 (copy)
                local v6 = u1:Clone();
                v6.Parent = workspace.Effects;
                task.delay(1, v6.Destroy, v6);
                v6:FindFirstChild("HumanoidRootPart");

                for _, descendant in v6:GetDescendants() do
                    if descendant:IsA("MeshPart") then
                        descendant.TextureID = "";
                    elseif descendant:IsA("Texture") or descendant:IsA("Decal") then
                        descendant:Destroy();
                    end;

                    if descendant:IsA("BasePart") then
                        if descendant:GetAttribute("G1Part") then
                            descendant:Destroy();
                        else
                            descendant.CanCollide = false;
                            descendant.CanTouch = false;
                            descendant.Massless = true;
                            descendant.Anchored = true;
                            descendant.Material = Enum.Material.ForceField;

                            if descendant.Name ~= "Head" then
                                descendant.Transparency = 0.7;
                            end;

                            task.delay(0.2, function() -- Line: 58
                                -- upvalues: TweenService (ref), descendant (copy), u2 (ref), u4 (ref)
                                TweenService:Create(descendant, u2, u4):Play();
                            end);
                        end;
                    end;
                end;

                for _, v in u5 do
                    if v6:FindFirstChild(v) then
                        v6:FindFirstChild(v):Destroy();
                    end;

                    if v6:FindFirstChildWhichIsA(v) then
                        v6:FindFirstChildWhichIsA(v):Destroy();
                    end;
                end;
            end);
        end;

        Position = Torso.Position;
        EffectsHandler.Wait();
    end;
end;