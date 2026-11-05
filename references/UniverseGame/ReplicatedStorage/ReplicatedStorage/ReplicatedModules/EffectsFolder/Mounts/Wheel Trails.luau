  

 

local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p2, p3, p4) -- Line: 7
    -- upvalues: u1 (copy), ParticleHandler (copy)
    if not p2 then
        return;
    end;

    local HumanoidRootPart = p2.HumanoidRootPart;

    while true do
        local v5 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -7, 0), u1);

        for _, v in p3 do
            local v6 = HumanoidRootPart.Velocity * Vector3.new(1, 0, 1);
            local v7;

            if v5 == nil then
                v7 = false;
            else
                v7 = v6.Magnitude > 5;
            end;

            ParticleHandler.EnableAllParticles(v, v7);

            if v7 then
                local v8, v9, v10 = v5.Instance.Color:ToHSV();

                for _, descendant in v:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Color = ParticleHandler.HSVShift(descendant.Color, {
                            Hue = v8,
                            Saturation = v9,
                            Value = v10
                        });
                    end;
                end;
            end;
        end;

        task.wait(0.1);

        if not p2:IsDescendantOf(game) then
            return;
        end;
    end;
end;