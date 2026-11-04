 

 

game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Random_new_ret = Random.new();
local TweenInfo_new_ret = TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0);

return function(u1) -- Line: 13
    -- upvalues: Random_new_ret (copy), TweenService (copy), TweenInfo_new_ret (copy), Debris (copy)
    local Character = u1.Character;
    local Amount = u1.Amount;
    local Type = u1.Type;

    if Character then
        coroutine.resume(coroutine.create(function() -- Line: 19
            -- upvalues: Amount (copy), Type (copy), u1 (copy), Random_new_ret (ref), Character (copy), TweenService (ref), TweenInfo_new_ret (ref), Debris (ref)
            for i = 1, Amount do
                local v2 = script.Sphere:Clone();
                v2.Anchored = true;
                v2.CanCollide = false;
                v2.Material = "Neon";
                v2.Name = "ImpactLines";

                if Type == "volleyblall" then
                    v2.BrickColor = math.random(1, 2) == 1 and BrickColor.new("Institutional white") or BrickColor.new("Black");
                else
                    v2.BrickColor = u1.Color or BrickColor.new("Institutional white");
                end;

                v2.Transparency = Random_new_ret:NextNumber(0.2, 0.5);
                v2.Size = Vector3.new(0.11, 0.11, Random_new_ret:NextNumber(3, 4.5));
                local v3 = Character.PrimaryPart.Position + Vector3.new(0, 2, 0);
                local v4 = Random_new_ret:NextNumber(-4, 4);
                local v5 = Random_new_ret:NextNumber(-7, 4);
                v2.Position = v3 + Vector3.new(v4, v5, Random_new_ret:NextNumber(-4, 4));
                v2.CFrame = CFrame.new(v2.Position, Character.PrimaryPart.Position + Character.PrimaryPart.Velocity * 100);
                v2.Parent = workspace.Effects;
                local v6 = TweenService:Create(v2, TweenInfo_new_ret, {
                    Transparency = 1,
                    Position = v2.Position + v2.CFrame.lookVector * -Random_new_ret:NextNumber(-5, -Amount),
                    Size = v2.Size / 2
                });
                v6:Play();
                v6:Destroy();
                Debris:AddItem(v2, 0.8);
                wait(u1.Delay or 0);
                local _ = i;
            end;
        end));
    end;
end;