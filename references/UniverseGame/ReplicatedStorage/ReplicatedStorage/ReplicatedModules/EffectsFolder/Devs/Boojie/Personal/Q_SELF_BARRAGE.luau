  

 

local Stands = require(game.ReplicatedStorage.ReplicatedModules.Stands);
local Skins = require(game.ReplicatedStorage.ReplicatedModules.Skins);
local u1 = Random.new();

return function(p2, p3, p4) -- Line: 6
    -- upvalues: Stands (copy), Skins (copy), u1 (copy)
    if typeof(p3) == "number" then
        p3 = Stands[p3];
    end;

    if not p3 then
        return;
    end;

    local v5 = p4 or (game.Players:GetPlayerFromCharacter(p2) or p4);
    local v6 = type(v5) == "string" and v5 and v5 or nil;

    if not v6 and (typeof(v5) == "Instance" and (v5:IsA("Player") and v5:FindFirstChild("Data"))) then
        v6 = Skins.Funcs.GetSkin(v5.Data.Ability.Value, v5.Data.Skin.Value) or v6;
    end;

    local v7 = p2:FindFirstChild("HumanoidRootPart") or p2:FindFirstChildWhichIsA("BasePart");

    if not v7 then
        return;
    end;

    local v8 = game.ReplicatedStorage["Client Assets"]:FindFirstChild(p3);

    if not v8 then
        return;
    end;

    for _ = 1, 2 do
        if type(v6) == "string" then
            v8 = v8:FindFirstChild(v6) or v8;
        end;

        local v9;

        if u1:NextInteger(1, 2) == 1 then
            v9 = v8:FindFirstChild("Stand Right Arm") or v8:FindFirstChild("Stand RightArm");
        else
            v9 = v8:FindFirstChild("Stand Left Arm") or v8:FindFirstChild("Stand LeftArm");
        end;

        if v9 then
            local v10 = v9:Clone();
            v10.Transparency = 0;

            for _, descendant in pairs(v10:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.Transparency = 0;
                end;
            end;

            v10.Parent = workspace.Effects;
            local Angles = CFrame.Angles;
            local v11 = u1:NextNumber(-360, 360);
            local v12 = math.rad(v11);
            local v13 = u1:NextNumber(-360, 360);
            local v14 = math.rad(v13);
            local v15 = u1:NextNumber(-360, 360);
            local v16 = Angles(v12, v14, (math.rad(v15)));
            local v17 = CFrame.new(0, 0, 0) * v16 * CFrame.new(0, 0, -5);
            local v18 = CFrame.new(0, 0, 0) * v16 * CFrame.new(0, 0, 4.25);
            local v19 = os.clock();
            local v20 = false;

            while os.clock() - v19 <= 0.3 do
                if os.clock() - v19 >= 0.15 and not v20 then
                    game:GetService("TweenService"):Create(v10, TweenInfo.new(0.15), {
                        Transparency = 1
                    }):Play();
                    v20 = true;

                    for _, descendant in pairs(v10:GetDescendants()) do
                        if descendant:IsA("BasePart") then
                            game:GetService("TweenService"):Create(descendant, TweenInfo.new(0.15), {
                                Transparency = 1
                            }):Play();
                        end;
                    end;
                end;

                local v21 = (os.clock() - v19) / 0.3;
                local v22 = math.clamp(v21, 0, 0.3);
                v10:PivotTo((CFrame.new(v7.Position) * v17 * CFrame.Angles(-1.5707963267948966, 0, 0)):Lerp(CFrame.new(v7.Position) * v18 * CFrame.Angles(-1.5707963267948966, 0, 0), v22));
                task.wait();
            end;

            v10:Destroy();
        end;
    end;
end;