  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");

return function(p2, p3) -- Line: 11
    -- upvalues: Trove (copy), u1 (copy), TableUtil (copy), ParticleHandler (copy)
    local u4 = p3 or {};
    local DisplayProjectile = u4.DisplayProjectile;
    local Offset = u4.Offset;
    local Props = u4.Props;
    local v5 = workspace.Effects:WaitForChild(p2, 1);

    if not (v5 and (v5:IsDescendantOf(workspace) and DisplayProjectile)) then
        return;
    end;

    local v6 = Trove.new();
    v6:AttachToInstance(v5);
    local u7 = DisplayProjectile:Clone();
    local u8;

    if u7:IsA("Model") then
        u8 = u4.PrimaryPart and u7:FindFirstChild(u4.PrimaryPart) or u7.PrimaryPart;
    else
        u8 = u7;
    end;

    local u9 = nil;
    v6:Add(function() -- Line: 34
        -- upvalues: u9 (ref), u8 (ref), u7 (copy), u4 (ref), u1 (ref)
        u9 = true;
        u8.Anchored = true;

        if u7:IsA("Model") then
            for _, descendant in ipairs(u7:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.Transparency = 1;
                end;
            end;
        elseif u7:IsA("BasePart") then
            u7.Transparency = 1;
        end;

        local v10 = 1;

        for _, descendant in ipairs(u7:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                if v10 < descendant.Lifetime.Max then
                    v10 = descendant.Lifetime.Max;
                end;

                descendant.Enabled = false;
            elseif descendant:IsA("BasePart") then
                descendant.Transparency = 1;
            elseif descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        if u4.EmitProjectile == "OnDestroy" then
            u1({
                Destroy = false,
                Clone = false,
                Transparency = false,
                MaxRenderDistance = u4.MaxRenderDistance,
                Origin = u8.CFrame,
                Particle = u7
            });
        end;

        if not u4.Debug then
            task.delay(u4.Lifetime or v10, u7.Destroy, u7);
        end;
    end);
    u8.Anchored = false;
    u8.CanCollide = false;
    local Weld = Instance.new("Weld");
    Weld.Part0 = u8;
    Weld.Part1 = v5;

    if Offset then
        Weld.C0 = Offset;
    end;

    Weld.Parent = u8;

    if Props then
        for i, v in pairs(Props) do
            local v11 = i == "Self" and u7 and u7 or u7:FindFirstChild(i, true);

            for i2, v2 in pairs(v) do
                v11[i2] = v2;
            end;
        end;
    end;

    if u4.ShowModel and u7:IsA("Model") then
        for _, descendant in ipairs(u7:GetDescendants()) do
            pcall(function() -- Line: 96
                -- upvalues: descendant (copy)
                descendant.Transparency = 0;
            end);
            pcall(function() -- Line: 99
                -- upvalues: descendant (copy)
                descendant.Visible = true;
            end);
            pcall(function() -- Line: 102
                -- upvalues: descendant (copy)
                descendant.Enabled = true;
            end);
        end;
    end;

    if u4.Emit then
        u1(TableUtil.Reconcile(u4.Emit, {
            Origin = u8.CFrame
        }));
    end;

    if u4.EmitProjectile == "OnSpawn" then
        u1({
            Destroy = false,
            Clone = false,
            Transparency = false,
            MaxRenderDistance = u4.MaxRenderDistance,
            Origin = u8.CFrame,
            Particle = u7
        });
    end;

    local v12 = ParticleHandler.GetSkinInfo(u4.SkinName);

    if type(v12) == "table" then
        local v13 = (v12[u7.Name] or {}).HSVShift or (v12.Metadata or {}).HSVShift;

        if v13 then
            ParticleHandler.HSVShiftParticles(u7, v13);

            if u4.HSVShiftProjectile then
                for _, descendant in ipairs(u7:GetDescendants()) do
                    if descendant:IsA("BasePart") then
                        descendant.Color = ParticleHandler.HSVShift(descendant.Color, v13);
                    end;
                end;

                if u7:IsA("BasePart") then
                    u7.Color = ParticleHandler.HSVShift(u7.Color, v13);
                end;
            end;
        end;
    end;

    if u4.HSVData then
        ParticleHandler.Unusualify(u7, {
            IncludeParts = true,
            HSVData = u4.HSVData
        });
    end;

    if u4.UnusualHueShift then
        local v14 = {
            HueShift = u4.UnusualHueShift
        };
        ParticleHandler.HSVShiftParticles(u7, v14);

        if u4.HSVShiftProjectile then
            for _, descendant in ipairs(u7:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.Color = ParticleHandler.HSVShift(descendant.Color, v14);
                end;
            end;

            if u7:IsA("BasePart") then
                u7.Color = ParticleHandler.HSVShift(u7.Color, v14);
            end;
        end;
    end;

    if u4.Scale then
        if u7:IsA("Model") then
            u7:ScaleTo(u7:GetScale() * u4.Scale);
        elseif u7:IsA("BasePart") then
            u7.Size = u7.Size * u4.Scale;

            for _, descendant in u7:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.Size = descendant.Size * u4.Scale;
                end;
            end;
        end;

        ParticleHandler.ScaleParticle(u7, u4.Scale);
    end;

    u7.Parent = workspace.Effects;
    local AngleOffset = u4.AngleOffset;

    if not AngleOffset then
        return;
    end;

    local v15, v16, v17 = AngleOffset:ToOrientation();

    while not u9 and u7.Parent do
        local v18 = task.wait();
        Weld.C0 = Weld.C0 * (AngleOffset * CFrame.fromOrientation(v15 * v18, v16 * v18, v17 * v18));
    end;
end;