  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);

return function(u1) -- Line: 10
    -- upvalues: EffectsHandler (copy), TweenService (copy)
    local u2 = 0.425 / u1.Speed;
    local v3 = TweenInfo.new(u2 / 3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
    local v4 = TweenInfo.new(u2 / 5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
    local v5 = EffectsHandler.CallEffect("Neon AfterImage", {
        VertexMultiplier = 4,
        Character = u1.Character,
        Vertex = u1.Vertex or Vector3.new(1, 1, 1),
        Duration = u2,
        CustomCFrame = u1.Origin
    });
    u1.Character:SetAttribute("Invisible", true);
    EffectsHandler.CallEffect("Invisibility", u1.Character, {
        Transparency = 1
    });
    task.spawn(function() -- Line: 27
        -- upvalues: EffectsHandler (ref), u2 (copy), u1 (copy)
        EffectsHandler.Wait(u2 / 2.5);

        if u1.Character then
            u1.Character:SetAttribute("Invisible", nil);
            EffectsHandler.CallEffect("NS_Distort", {
                StartPercentage = 2,
                Rate = 7,
                Character = u1.Character
            });
            EffectsHandler.CallEffect("Neon AfterImage", {
                VertexMultiplier = 5,
                Character = u1.Character,
                Vertex = u1.Vertex or Vector3.new(1, 1, 1),
                Duration = 0.35 / u1.Speed
            });
        end;
    end);
    local v6 = { {}, {}, {} };

    for _, child in v5:GetChildren() do
        local v7 = child:FindFirstChildOfClass("SpecialMesh");

        if v7 then
            local v8 = v6[1];
            local v9 = {
                Scale = Vector3.new(v7.Scale.X + 7.5, v7.Scale.Y / 2, v7.Scale.Z)
            };
            table.insert(v8, TweenService:Create(v7, v3, v9));
            local v10 = v6[2];
            local v11 = {
                Scale = Vector3.new(v7.Scale.X, v7.Scale.Y / 1.5, v7.Scale.Z)
            };
            table.insert(v10, TweenService:Create(v7, v4, v11));
            local v12 = v6[3];
            local v13 = {
                Scale = Vector3.new(v7.Scale.X / 2, v7.Scale.Y + 12.5, v7.Scale.Z / 2)
            };
            table.insert(v12, TweenService:Create(v7, v3, v13));
        end;
    end;

    for i = 1, #v6 do
        local v14 = v6[i];

        for i2, v in v14 do
            v:Play();

            if i2 == #v14 then
                v.Completed:Wait();
            end;
        end;
    end;

    table.clear(v6);
end;