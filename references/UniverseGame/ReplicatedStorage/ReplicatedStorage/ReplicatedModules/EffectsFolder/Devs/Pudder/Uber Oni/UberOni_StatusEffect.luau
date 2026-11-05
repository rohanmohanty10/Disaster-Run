  

 

game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Trove);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Hud = game.ReplicatedStorage["Client Assets"].Assets.Abilities["Uber Oni"].Particles.Hud;
local u1 = {};

return function(p2) -- Line: 16
    -- upvalues: u1 (copy), TweenService (copy), Hud (copy)
    local Lifetime = p2.Lifetime;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Head");

    if not HumanoidRootPart then
        return;
    end;

    local u3 = TweenInfo.new(0.5);

    if not u1[Character] then
        if not u1[Character] then
            print("NEW");
            local u4 = Hud:Clone();

            for _, descendant in u4:GetDescendants() do
                if descendant:IsA("Frame") and descendant.Name ~= "Content" then
                    descendant.BackgroundTransparency = 1;
                    TweenService:Create(descendant, u3, {
                        BackgroundTransparency = 0
                    }):Play();
                end;
            end;

            u4.Parent = HumanoidRootPart;
            local v5 = TweenService:Create(u4.Content.Health.Percent, TweenInfo.new(Lifetime, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                Size = UDim2.fromScale(0, 1)
            });
            v5:Play();
            local Highlight = Instance.new("Highlight");
            Highlight.OutlineColor = Color3.new(1, 1, 1);
            Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
            Highlight.OutlineTransparency = 1;
            Highlight.FillTransparency = 1;
            Highlight.Parent = Character;
            TweenService:Create(Highlight, u3, {
                OutlineTransparency = 0
            }):Play();
            u1[Character] = {
                Hud = u4,
                Tween = v5,
                Highlight = Highlight,
                Connection = v5.Completed:Connect(function() -- Line: 119
                    -- upvalues: u4 (copy), u1 (ref), Character (copy), TweenService (ref), Highlight (copy), u3 (copy)
                    if u4.Content.Health.Percent.Size.X.Scale == 0 then
                        u1[Character] = nil;
                        local v6 = TweenService:Create(Highlight, TweenInfo.new(0.5), {
                            OutlineTransparency = 1
                        });
                        v6:Play();

                        for _, descendant in u4:GetDescendants() do
                            if descendant:IsA("Frame") and descendant.Name ~= "Content" then
                                TweenService:Create(descendant, u3, {
                                    BackgroundTransparency = 1
                                }):Play();
                            end;
                        end;

                        v6.Completed:Connect(function() -- Line: 139
                            -- upvalues: u4 (ref), Highlight (ref)
                            u4:Destroy();
                            Highlight:Destroy();
                        end);
                    end;
                end)
            };
        end;

        return;
    end;

    local v7 = u1[Character];
    local Hud2 = v7.Hud;
    local Tween = v7.Tween;
    local Highlight = v7.Highlight;
    v7.Connection:Disconnect();
    Tween:Cancel();
    Hud2.Content.Health.Percent.Size = UDim2.fromScale(1, 1);
    local v8 = TweenService:Create(Hud2.Content.Health.Percent, TweenInfo.new(Lifetime, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
        Size = UDim2.fromScale(0, 1)
    });
    v8:Play();
    print("REPLACE REPLACE");
    u1[Character] = {
        Hud = Hud2,
        Tween = v8,
        Highlight = Highlight,
        Connection = v8.Completed:Connect(function() -- Line: 50
            -- upvalues: Hud2 (copy), u1 (ref), Character (copy), TweenService (ref), Highlight (copy), u3 (copy)
            if Hud2.Content.Health.Percent.Size.X.Scale == 0 then
                u1[Character] = nil;
                local v9 = TweenService:Create(Highlight, TweenInfo.new(0.5), {
                    OutlineTransparency = 1
                });
                v9:Play();

                for _, descendant in Hud2:GetDescendants() do
                    if descendant:IsA("Frame") and descendant.Name ~= "Content" then
                        TweenService:Create(descendant, u3, {
                            BackgroundTransparency = 1
                        }):Play();
                    end;
                end;

                v9.Completed:Connect(function() -- Line: 70
                    -- upvalues: Hud2 (ref), Highlight (ref)
                    Hud2:Destroy();
                    Highlight:Destroy();
                end);
            end;
        end)
    };
end;