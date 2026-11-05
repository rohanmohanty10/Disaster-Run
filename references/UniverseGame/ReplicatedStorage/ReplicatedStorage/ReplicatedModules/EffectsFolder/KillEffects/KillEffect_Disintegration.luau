  

 

require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 4
    local TargetCharacter = p1.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    print("Attempt");
    task.delay(0.3, function(p2) -- Line: 10
        -- upvalues: TargetCharacter (copy)
        local v3 = next;
        local v4, v5 = TargetCharacter:GetDescendants();

        for _, v in v3, v4, v5 do
            if v:IsA("Part") or (v:IsA("Decal") or v:IsA("Texture")) then
                game.TweenService:Create(v, TweenInfo.new(0.8, Enum.EasingStyle.Cubic), {
                    Transparency = 1
                }):Play();
                task.wait(0.075);
            end;
        end;
    end);
end;