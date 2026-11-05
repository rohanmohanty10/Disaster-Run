  

 

local TweenService = game:GetService("TweenService");
game:GetService("ReplicatedStorage"):FindFirstChild("Client Assets");
local Part = Instance.new("Part");
Part.Anchored = false;
Part.CanCollide = true;
Part.Massless = true;
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u2 = Random.new();

return function(p3) -- Line: 19
    -- upvalues: Part (copy), u1 (copy), u2 (copy), TweenService (copy), EffectsHandler (copy)
    if p3.Origin == nil then
        return;
    end;

    local v4 = typeof(p3.Origin) == "CFrame" and p3.Origin.Position or p3.Origin;
    local v5 = p3.Amount or 6;
    local v6 = p3.Force or Vector3.new(25, 25, 25);
    local v7 = p3.Preset or Part;
    local v8 = p3.Inconsistent or false;
    local v9 = {};

    for i = 1, v5 do
        local v10 = workspace:Raycast(v4, Vector3.new(0, -8.5, 0), u1);

        if v10 then
            local u11 = v8 and u2:NextNumber(1.9, 3) or 1;
            local u12 = v7:Clone();
            u12.Size = u12.Size * u11;
            local Size = u12.Size;
            local Size2 = u12.Size;
            local v13 = u12.Size.Y * u2:NextNumber(1.75, 2.5);
            u12.Size = Size2 + Vector3.new(0, v13, 0);
            u12.CanCollide = true;
            u12.CanQuery = true;
            u12.CanTouch = true;
            u12.CFrame = CFrame.new(v10.Position + Vector3.new(0, 2.5, 0));
            u12.Parent = workspace.Effects;
            TweenService:Create(u12, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = Size
            }):Play();
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000);
            local v14 = math.sin(i * 2 * 3.141592653589793 / v5);
            local v15 = math.cos(i * 2 * 3.141592653589793 / v5);
            BodyVelocity.Velocity = v6 * Vector3.new(v14, 1, v15) * (v8 and u2:NextNumber(0.9, 2) or 1);
            BodyVelocity.Parent = u12;
            task.delay(u2:NextNumber(0.18, 0.33), BodyVelocity.Destroy, BodyVelocity);
            local u16 = os.clock();
            local u17 = nil;
            u17 = u12.Touched:Connect(function(p18) -- Line: 63
                -- upvalues: u16 (copy), u12 (copy), u17 (ref), u1 (ref), EffectsHandler (ref), u11 (copy)
                if os.clock() - u16 > 0.25 and (p18.Parent and (p18:IsDescendantOf(workspace.Map) and (u12:IsDescendantOf(game) and (p18.CollisionGroup ~= "Ghosted" and p18.CanCollide)))) then
                    if u17 then
                        u17:Disconnect();
                        u17 = nil;
                    end;

                    u12:Destroy();
                    local v19 = workspace:Raycast(u12.Position, Vector3.new(0, -100, 0), u1);

                    if v19 then
                        EffectsHandler.CallEffect("Emit Particle V3", {
                            Path = "Particles/Splash",
                            PlaySounds = true,
                            AutoSerialize = true,
                            AbilityName = "UGrain",
                            BypassRenderCap = true,
                            Origin = CFrame.new(v19.Position, v19.Position + v19.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0),
                            Scale = u11
                        });
                    end;
                end;
            end);
            table.insert(v9, u12);
        end;
    end;
end;