  

 

local Debris = game:GetService("Debris");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1, p2, p3) -- Line: 7
    -- upvalues: ParticleHandler (copy), Debris (copy)
    local v4 = p3.HitData or p3;
    local v5 = v4.Particle or nil;
    local v6 = v4.EmitType or "Enabled";
    local u7 = v4.EmitDuration or 0.1;
    local v8 = v4.CustomParent or "PrimaryPart";
    local v9 = v4.Lifetime or 2.5;
    local FaceAttacker = v4.FaceAttacker;

    if not v5 then
        return;
    end;

    local v10;

    if p2 then
        v10 = ParticleHandler.GetUnusualHSVData({
            Character = p2
        });
    else
        v10 = nil;
    end;

    local v11 = {};
    local v12 = {};
    local v13 = nil;

    local function EmitParticles(p14) -- Line: 30
        if p14:IsA("ParticleEmitter") then
            p14:Emit(p14:GetAttribute(p14.EmitCount));

            return;
        end;

        for _, child in pairs(p14:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child:Emit(child:GetAttribute("EmitCount"));
            end;
        end;
    end;

    local function EnableParticles(u15) -- Line: 42
        -- upvalues: u7 (copy)
        if u15:IsA("ParticleEmitter") then
            coroutine.wrap(function() -- Line: 44
                -- upvalues: u15 (copy), u7 (ref)
                u15.Enabled = true;
                task.wait(u7);
                u15.Enabled = false;
            end)();

            return;
        end;

        for _, child in pairs(u15:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                coroutine.wrap(function() -- Line: 54
                    -- upvalues: child (copy), u7 (ref)
                    child.Enabled = true;
                    task.wait(u7);
                    child.Enabled = false;
                end)();
            end;
        end;
    end;

    if v5:IsA("BasePart") then
        for _, child in pairs(v5:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                local v16 = child:Clone();
                ParticleHandler.Unusualify({ v16 }, {
                    HSVData = v10
                });
                v16.Parent = p1[v8];
                Debris:AddItem(v16, v9);
                table.insert(v11, v16);
            end;

            if child:IsA("Attachment") then
                local v17 = child:Clone();
                ParticleHandler.Unusualify({ v17 }, {
                    HSVData = v10
                });
                v17.Parent = p1[v8];

                if FaceAttacker then
                    local Rotation = CFrame.lookAt(p2.HumanoidRootPart.Position, p1.HumanoidRootPart.Position).Rotation;
                    local v18 = math.deg(Rotation.X);
                    local v19 = math.deg(Rotation.Y);
                    local v20 = math.deg(Rotation.Z);
                    v17.Orientation = Vector3.new(v18, v19, v20);
                end;

                Debris:AddItem(v17, v9);
                table.insert(v12, v17);
            end;
        end;
    elseif v5:IsA("Attachment") then
        v13 = v5:Clone();
        ParticleHandler.Unusualify({ v13 }, {
            HSVData = v10
        });
        v13.Parent = p1[v8];

        if FaceAttacker then
            local Rotation = CFrame.lookAt(p2.HumanoidRootPart.Position, p1.HumanoidRootPart.Position).Rotation;
            local v21 = math.deg(Rotation.X);
            local v22 = math.deg(Rotation.Y);
            local v23 = math.deg(Rotation.Z);
            v13.Orientation = Vector3.new(v21, v22, v23);
        end;

        Debris:AddItem(v13, v9);
    end;

    if v13 ~= nil then
        if v6 == "Enabled" then
            EnableParticles(v13);
        elseif v6 == "Emit" then
            EmitParticles(v13);
        end;
    end;

    if #v11 > 0 and v6 == "Enabled" then
        for _, v in pairs(v11) do
            EnableParticles(v);
        end;
    elseif #v11 > 0 and v6 == "Emit" then
        for _, v in pairs(v12) do
            EmitParticles(v);
        end;
    end;

    if #v12 > 0 and v6 == "Enabled" then
        for _, v in pairs(v12) do
            EnableParticles(v);
        end;

        return;
    end;

    if #v12 > 0 and v6 == "Emit" then
        for _, v in pairs(v12) do
            EmitParticles(v);
        end;
    end;
end;