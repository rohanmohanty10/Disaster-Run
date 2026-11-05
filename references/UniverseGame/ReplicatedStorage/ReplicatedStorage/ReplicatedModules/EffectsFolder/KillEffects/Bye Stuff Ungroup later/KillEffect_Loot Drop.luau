  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = { "rbxassetid://70698362791674", "rbxassetid://106135337819490", "rbxassetid://131886909191211", "rbxassetid://96135323353343", "rbxassetid://98423028280115", "rbxassetid://121963599350358", "rbxassetid://92981053712359", "rbxassetid://121270965028794", "rbxassetid://75482569808134", "rbxassetid://128367460757573", "rbxassetid://115333347167470", "rbxassetid://101113797029559", "rbxassetid://80070655912557", "rbxassetid://126628849858116", "rbxassetid://117608325189128", "rbxassetid://81684435578611", "rbxassetid://80108620306419" };

return function(p2) -- Line: 28
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), u1 (copy), TweenService (copy)
    local TargetCharacter = (p2 or {}).TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local u3 = Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    EffectsHandler.Wait(0.2);
    local Highlight = Instance.new("Highlight");
    Highlight.OutlineTransparency = 1;
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.Parent = TargetCharacter;
    EffectsHandler.Wait(1);
    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Loot Drop/Death",
        AbilityName = "KillEffects",
        Origin = CFrame2
    });

    for _ = 1, 15 do
        local u4 = AssetHandler.CloneAsset("Loot Drop/Item", {
            AbilityName = "KillEffects"
        });
        u4.BillboardGui.ImageLabel.Image = u1[math.random(1, #u1)];
        u4.CFrame = CFrame2;
        u4.Parent = workspace.Effects;
        task.delay(8, u4.Destroy, u4);
        local v5 = TweenService:Create(u4, TweenInfo.new(0.75), {
            CFrame = u4.CFrame * CFrame.new(u3:NextNumber(-3, 3), u3:NextNumber(-2.4, -2.1), u3:NextNumber(-3, 3))
        });
        v5:Play();
        v5.Completed:Connect(function() -- Line: 74
            -- upvalues: TweenService (ref), u4 (copy), u3 (copy), TargetCharacter (copy)
            local u6 = TweenService:Create(u4, TweenInfo.new(u3:NextNumber(0.45, 0.9), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, (1 / 0), true), {
                Position = u4.Position + Vector3.new(0, u3:NextNumber(0.1, 0.3))
            });
            u6:Play();
            local Character = game.Players.LocalPlayer.Character;

            if Character == TargetCharacter then
                return;
            end;

            local u7;

            if Character then
                u7 = Character:FindFirstChild("HumanoidRootPart");
            else
                u7 = Character;
            end;

            if not u7 then
                return;
            end;

            local u8 = false;
            local u9 = nil;
            u9 = game["Run Service"].RenderStepped:Connect(function() -- Line: 88
                -- upvalues: u8 (ref), Character (copy), u4 (ref), u9 (ref), u7 (copy), u6 (copy), TweenService (ref)
                if not u8 and (Character:IsDescendantOf(game) and u4:IsDescendantOf(game)) then
                    if (u4.Position - u7.Position).Magnitude < 6 then
                        u8 = true;

                        if u6 then
                            u6:Pause();
                        end;

                        TweenService:Create(u4, TweenInfo.new(0.08, Enum.EasingStyle.Linear), {
                            Position = u7.Position
                        }):Play();
                        task.delay(0.08, function() -- Line: 107
                            -- upvalues: u4 (ref)
                            u4:Destroy();
                        end);
                    end;

                    return;
                end;

                u9:Disconnect();
                u9 = nil;
            end);
        end);
    end;
end;