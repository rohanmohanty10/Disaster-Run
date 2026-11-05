  

 

local LocalPlayer = game.Players.LocalPlayer;
local u1 = game.ReplicatedStorage["Client Assets"];
local TweenService = game:GetService("TweenService");

return function(p2, u3) -- Line: 4
    -- upvalues: LocalPlayer (copy), u1 (copy), TweenService (copy)
    if LocalPlayer.Settings.Gore.Value == false then
        return;
    end;

    local u4 = p2["Left Arm"];
    local u5 = u1["D4C: Love Train"].HalfLeftArm:Clone();
    u5.Parent = p2;
    u4.Transparency = 1;
    u5:PivotTo(u4.CFrame);
    local Motor6D = Instance.new("Motor6D");
    Motor6D.Part0 = u5.Top.TopArm;
    Motor6D.Part1 = u4;
    Motor6D.Parent = u5.Top.TopArm;

    for _, descendant in pairs(u5:GetDescendants()) do
        if p2:FindFirstChildOfClass("Shirt") and descendant.Name == "ShirtTexture" then
            descendant.TextureId = p2:FindFirstChildOfClass("Shirt").ShirtTemplate;
        end;

        if descendant.Name == "BottomArm" or descendant.Name == "TopArm" then
            descendant.Color = u4.Color;
        end;
    end;

    for _, child in pairs(u5.Top.CutTop.Attachment:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            child.Enabled = true;
        end;
    end;

    coroutine.wrap(function() -- Line: 37
        -- upvalues: u5 (copy), TweenService (ref), u3 (copy)
        local v6 = tick();

        while true do
            wait(0.75);

            if u5 and #u5:GetDescendants() > 3 then
                coroutine.wrap(function() -- Line: 42
                    -- upvalues: u5 (ref), TweenService (ref)
                    local v7 = { game.Workspace.Living, game.Workspace.Effects, game.Workspace.NPCS };
                    local v8 = Ray.new(u5.Bottom.BottomArm.Position, Vector3.new(0, -15, 0));
                    local v9, v10 = game.Workspace:FindPartOnRayWithIgnoreList(v8, v7);

                    if v9 then
                        local v11 = game.ReplicatedStorage["Client Assets"]["King Crimson"].Blood:Clone();
                        v11.Parent = game.Workspace.Effects;
                        v11.Material = Enum.Material.Glass;
                        local v12 = math.random(-1, 1);
                        v11.Position = v10 + Vector3.new(v12, 0, math.random(-1, 1));
                        TweenService:Create(v11, TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Size = v11.Size * math.random(2, 5)
                        }):Play();
                        wait(2.2);
                        TweenService:Create(v11, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Transparency = 1
                        }):Play();
                        wait(0.5);
                        v11:Destroy();
                    end;
                end)();
            end;

            if u3 < tick() - v6 then
                return;
            end;
        end;
    end)();
    coroutine.wrap(function() -- Line: 62
        -- upvalues: u3 (copy), u4 (copy), u5 (copy)
        wait(u3);
        u4.Transparency = 0;

        for _, child in pairs(u5.Top.CutTop.Attachment:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child.Enabled = false;
            end;
        end;

        wait(0.3);
        u5:Destroy();
    end)();
end;