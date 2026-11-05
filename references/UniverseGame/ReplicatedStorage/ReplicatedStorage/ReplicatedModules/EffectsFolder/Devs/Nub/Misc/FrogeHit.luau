  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local TweenService = game:GetService("TweenService");

return function(p2) -- Line: 3
    -- upvalues: u1 (copy), TweenService (copy)
    if not (p2 and p2:IsDescendantOf(workspace)) then
        return;
    end;

    local Parent = p2.Parent;
    local v3 = { "Head", "Right Arm", "Left Arm", "Left Leg", "Right Leg", "Torso" };
    local v4 = {};

    for _, child in ipairs(Parent:GetChildren()) do
        if table.find(v3, child.Name) then
            table.insert(v4, child);
        end;
    end;

    local u5 = v4[math.random(#v4)];
    local v6 = u1.Assets.Abilities["Weather Report"].SmokeHit:Clone();
    v6.Parent = workspace.Effects;
    v6.CFrame = p2.CFrame * CFrame.new(math.random(-2, 2), math.random(-2, 2), math.random(-2, 2));
    local v7 = TweenService:Create(v6.SmokeGui, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(10, 0, 10, 0)
    });
    local v8 = TweenService:Create(v6.SmokeGui.Smoke, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        ImageTransparency = 1,
        ImageColor3 = Color3.fromRGB(152, 79, 255)
    });
    v7:Play();
    v8:Play();

    if not p2:FindFirstChild("Spots") then
        local v9 = u1.Assets.Abilities["Weather Report"].Spots:Clone();
        v9.Color = p2.Color;
        v9.Weld.Part1 = Parent.HumanoidRootPart;
        v9.Parent = p2;
        task.delay(2, v9.Destroy, v9);
    end;

    for _ = 1, 4 do
        local u10;

        if u5.Name == "Head" and (u5:FindFirstChild("face") and u5.face.Texture ~= "rbxassetid://6347057989") then
            u10 = u5.face.Texture;
            u5.face.Texture = "rbxassetid://6347057989";
        else
            u10 = nil;
        end;

        local v11 = { -0.3, 0.3 };
        local u12 = u1.Assets.Abilities["Weather Report"].SkinBall:Clone();
        u12.Parent = p2.Parent;
        u12.Color = u5.Color;
        local Weld = Instance.new("Weld");
        Weld.Parent = u5;
        Weld.Part0 = u5;
        Weld.Part1 = u12;
        Weld.C0 = Weld.C0 * CFrame.new(math.random(-10, 10) / 20, math.random(-1, 1) / 2, v11[math.random(#v11)]);
        TweenService:Create(Weld.Part1, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = Weld.Part1.Size * math.random(11, 13)
        }):Play();
        task.spawn(function() -- Line: 46
            -- upvalues: Weld (copy), u12 (copy), u10 (ref), u5 (copy)
            wait(1);
            Weld:Destroy();
            u12:Destroy();
            wait(5);

            if u10 then
                u5.face.Texture = u10;
            end;
        end);
    end;

    task.delay(2, v6.Destroy, v6);
end;