  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local u1 = require(ReplicatedStorage.ReplicatedModules.EffectsHandler).GetEffect("ranInt");

return function(p2, p3, p4, p5) -- Line: 7
    -- upvalues: ReplicatedStorage (copy), u1 (copy), TweenService (copy)
    local u6 = p5 or {};
    local HumanoidRootPart = p2.HumanoidRootPart;
    local v7 = u6.Amount or 10;
    local u8 = u6.Offset or 2;
    local u9 = u6.Distance or 3;
    local u10 = u6.RayLength or 0.5;
    local u11 = u6.Speed or 0.2;
    local u12 = u6.LifeTime or 0.15;
    local u13 = u6.Size or Vector3.new(0.1, 0.1, 0.1);
    local u14 = u6.Color or Color3.fromRGB(255, 255, 255);

    if u6.Blood == true then
        for _, child in pairs(ReplicatedStorage["Client Assets"].Universal.BloodSplatter:GetChildren()) do
            local v15 = child:Clone();
            v15.Parent = HumanoidRootPart;
            v15.Lifetime = NumberRange.new(u12 + u11);
            v15:Emit(v7);
            game.Debris:AddItem(v15, u12 + u11 + 0.5);
        end;
    end;

    local v16 = ReplicatedStorage["Client Assets"].Universal.HitParticle:Clone();
    v16.Parent = HumanoidRootPart;
    v16.Lifetime = NumberRange.new(u12 + u11);
    v16.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, u9 * 2), NumberSequenceKeypoint.new(1, 0.01) });

    if u6.ColorSequence then
        local v17 = {};

        for i = 1, #u6.ColorSequence do
            table.insert(v17, ColorSequenceKeypoint.new((i - 1) / (#u6.ColorSequence - 1), u6.ColorSequence[i]));
        end;

        v16.Color = ColorSequence.new({ unpack(v17) });
    else
        v16.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, u14), ColorSequenceKeypoint.new(1, u14) });
    end;

    v16:Emit(1);
    game.Debris:AddItem(v16, u12 + u11 + 0.5);
    wait(u12 / 2);

    for _ = 1, v7 do
        coroutine.wrap(function() -- Line: 53
            -- upvalues: ReplicatedStorage (ref), u11 (copy), u12 (copy), HumanoidRootPart (copy), u1 (ref), u8 (copy), u14 (copy), u13 (copy), u10 (copy), u9 (copy), u6 (copy), TweenService (ref)
            local u18 = ReplicatedStorage["Client Assets"].Universal.Spark:Clone();
            game.Debris:AddItem(u18, u11 + u12);
            local new = CFrame.new;
            local Position = HumanoidRootPart.Position;
            local v19 = u1(-u8, u8);
            local v20 = u1(-u8, u8);
            u18.CFrame = new(Position + Vector3.new(v19, v20, u1(-u8, u8)), HumanoidRootPart.Position);
            u18.Parent = workspace.Effects;
            u18.Color = u14;
            u18.Size = u13;
            local u21 = u11 * u1(8, 12) / 10;
            local v22 = u10 * u1(10, 20) / 10;
            local v23 = u18.Position + u18.CFrame.lookVector * -u9;
            local v24 = Vector3.new(u18.Size.X * 1.25, u18.Size.Y * 1.25, u9 * v22);
            local v25 = v23 + u18.CFrame.lookVector * -v24.Z / 2;

            if u6.ColorSequence then
                local u26 = #u6.ColorSequence - 1;

                if u26 > 0 then
                    u18.Color = u6.ColorSequence[1];

                    for i = 1, u26 do
                        coroutine.wrap(function() -- Line: 72
                            -- upvalues: TweenService (ref), u18 (copy), u21 (copy), u26 (copy), u6 (ref), i (copy)
                            TweenService:Create(u18, TweenInfo.new(u21 / u26), {
                                Color = u6.ColorSequence[i + 1]
                            }):Play();
                            wait(u21 / u26);
                        end)();
                    end;
                elseif u26 == 0 then
                    TweenService:Create(u18, TweenInfo.new(u21 / u26), {
                        Color = u6.ColorSequence[1]
                    }):Play();
                end;
            end;

            TweenService:Create(u18, TweenInfo.new(u21, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                Size = v24,
                Position = v23
            }):Play();
            wait(u21);
            TweenService:Create(u18, TweenInfo.new(u12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Transparency = 1,
                Size = u13,
                Position = v25
            }):Play();
        end)();
    end;
end;