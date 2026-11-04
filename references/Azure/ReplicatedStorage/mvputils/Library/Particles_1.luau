 
 

local TweenService = game:GetService("TweenService");
local v1 = {};
local u2 = {
    Rock = { Enum.Material.Slate, Enum.Material.Concrete, Enum.Material.Rock },
    Grass = { Enum.Material.Grass },
    Smoke = {
        Enum.Material.Grass,
        Enum.Material.Slate,
        Enum.Material.Concrete,
        Enum.Material.Rock
    }
};

local function GroundCast(p3) -- Line: 11
    local v4;

    if p3:IsA("Model") then
        v4 = p3.PrimaryPart.CFrame;
    elseif p3:IsA("BasePart") then
        v4 = p3.CFrame;
    else
        v4 = p3.WorldCFrame;
    end;

    local Ignore = workspace:FindFirstChild("Ignore");
    local Live = workspace:FindFirstChild("Live");
    local Effects = workspace:FindFirstChild("Effects");
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { Ignore, Live, Effects };
    local v5 = workspace:Raycast(v4.Position, Vector3.new(0, -5, 0), RaycastParams_new_ret);

    if v5 and v5.Instance then
        return {
            Color = v5.Instance.Color,
            Material = v5.Material
        };
    end;
end;

function v1.GetEmitCount(p6: table, p7: userdata) -- Line: 38
    local GameSettings = UserSettings().GameSettings;
    local Attribute = p7:GetAttribute("EmitCount");

    if GameSettings.SavedQualityLevel.Value < 10 then
        Attribute = Attribute / (GameSettings.SavedQualityLevel.Value <= 5 and 7 or 2);
    end;

    return Attribute;
end;

function v1.Emit(u8: table, u9: userdata) -- Line: 51
    -- upvalues: GroundCast (copy)
    local _, result = pcall(function() -- Line: 52
        -- upvalues: GroundCast (ref), u9 (copy)
        return GroundCast(u9);
    end);

    for _, descendant in u9:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            local v10 = descendant:GetAttribute("EmitDelay") or 0;
            task.delay(v10, function() -- Line: 61
                -- upvalues: descendant (copy), result (copy), u8 (copy)
                if descendant.Name == "Smoke" or (descendant.Name == "Rock" or descendant.Name == "Grass") then
                    if not result then
                        return;
                    end;

                    descendant.Color = ColorSequence.new(result.Color);
                end;

                local EmitCount = u8:GetEmitCount(descendant);
                descendant:Emit((math.max(EmitCount, 1)));
            end);
        end;
    end;
end;

function v1.Enable(p11: table, p12: userdata, p13: number?) -- Line: 73
    -- upvalues: GroundCast (copy), u2 (copy)
    for _, descendant in p12:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            if descendant.Name == "Smoke" or (descendant.Name == "Rock" or descendant.Name == "Grass") then
                task.spawn(function() -- Line: 77
                    -- upvalues: descendant (copy), GroundCast (ref), u2 (ref)
                    while descendant and descendant.Parent ~= nil do
                        local v14 = GroundCast(descendant.Parent);

                        if not v14 then
                            descendant.Enabled = false;
                        end;

                        if v14 and u2[descendant.Name][v14.Material] then
                            descendant.Enabled = true;
                            descendant.Color = v14.Color;
                        end;

                        task.wait(0.25);
                    end;
                end);
            else
                descendant.Enabled = true;

                if p13 then
                    task.delay(p13, function() -- Line: 96
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        elseif descendant:IsA("Beam") or descendant:IsA("Trail") then
            descendant.Enabled = true;

            if p13 then
                task.delay(p13, function() -- Line: 103
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end;
end;

function v1.Disable(p15: table, p16: userdata) -- Line: 111
    for _, descendant in p16:GetDescendants() do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
            descendant.Enabled = false;
        end;
    end;
end;

function v1.Freeze(p17: table, p18: userdata, p19: number?, p20: boolean?, u21: number?) -- Line: 118
    -- upvalues: TweenService (copy)
    for _, descendant in p18:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            TweenService:Create(descendant, TweenInfo.new(p19 or 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                TimeScale = 0
            }):Play();

            if p20 then
                task.delay(p20, function() -- Line: 125
                    -- upvalues: TweenService (ref), descendant (copy), u21 (copy)
                    TweenService:Create(descendant, TweenInfo.new(u21 or 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        TimeScale = 1
                    }):Play();
                end);
            end;
        elseif descendant:IsA("Beam") then
            local TextureSpeed = descendant.TextureSpeed;
            TweenService:Create(descendant, TweenInfo.new(p19 or 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                TextureSpeed = 0
            }):Play();

            if p20 then
                task.delay(p20, function() -- Line: 137
                    -- upvalues: TweenService (ref), descendant (copy), u21 (copy), TextureSpeed (copy)
                    TweenService:Create(descendant, TweenInfo.new(u21 or 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        TextureSpeed = TextureSpeed
                    }):Play();
                end);
            end;
        end;
    end;
end;

function v1.Slow(p22: table, p23: userdata, p24: number?, p25: number?, p26: number?, u27: number?) -- Line: 147
    -- upvalues: TweenService (copy)
    for _, descendant in p23:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            TweenService:Create(descendant, TweenInfo.new(p24 or 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                TimeScale = p25 or 0.5
            }):Play();

            if p26 then
                task.delay(p26, function() -- Line: 154
                    -- upvalues: TweenService (ref), descendant (copy), u27 (copy)
                    TweenService:Create(descendant, TweenInfo.new(u27 or 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        TimeScale = 1
                    }):Play();
                end);
            end;
        elseif descendant:IsA("Beam") then
            local TextureSpeed = descendant.TextureSpeed;
            TweenService:Create(descendant, TweenInfo.new(p24 or 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                TextureSpeed = p25 or 0.5
            }):Play();

            if p26 then
                task.delay(p26, function() -- Line: 166
                    -- upvalues: TweenService (ref), descendant (copy), u27 (copy), TextureSpeed (copy)
                    TweenService:Create(descendant, TweenInfo.new(u27 or 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                        TextureSpeed = TextureSpeed
                    }):Play();
                end);
            end;
        end;
    end;
end;

return v1;