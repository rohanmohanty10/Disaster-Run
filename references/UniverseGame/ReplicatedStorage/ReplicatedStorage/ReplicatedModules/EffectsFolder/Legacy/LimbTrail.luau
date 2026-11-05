  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1, p2, p3, p4, p5) -- Line: 6
    -- upvalues: ParticleHandler (copy)
    if p3 ~= nil then
        local v6 = ParticleHandler.GetUnusualHSVData({
            Player = p4,
            Character = p5
        });

        if v6 ~= nil then
            p3 = ParticleHandler.HSVShift(p3, v6);
        end;
    end;

    local v7 = { Vector3.new(0.5, -1, 0.5), Vector3.new(-0.5, -1, 0.5), Vector3.new(-0.5, -1, -0.5), Vector3.new(0.5, -1, -0.5) };
    local v8 = {};

    for i = 1, #v7 do
        local Attachment = Instance.new("Attachment");
        Attachment.Position = v7[i];
        Attachment.Parent = p1;
        table.insert(v8, Attachment);
    end;

    local Trail = game.ReplicatedStorage["Client Assets"].LimbTrail.Trail;

    for i = 1, #v8 do
        local v9 = Trail:Clone();

        if p3 then
            v9.Color = p3;
        end;

        v9.Attachment0 = v8[i];

        if i == #v8 then
            v9.Attachment1 = v8[1];
        else
            v9.Attachment1 = v8[i + 1];
        end;

        v9.Parent = p1;
        game.Debris:AddItem(v8[i], p2);
        game.Debris:AddItem(v9, p2);
    end;
end;