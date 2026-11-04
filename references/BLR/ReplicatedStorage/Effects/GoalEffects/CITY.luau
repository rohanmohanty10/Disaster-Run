  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local Random_new_ret = Random.new(os.clock());

return function(p1) -- Line: 11
    -- upvalues: SpectatorController (copy), ReplicatedStorage (copy), VfxManager (copy), TweenService (copy), Random_new_ret (copy)
    local LocalPlayer = game.Players.LocalPlayer;

    if LocalPlayer.Team == game.Teams.Visitor and (LocalPlayer.PlayerGui.Misc.CloseLimited.Visible == false and (LocalPlayer.PlayerGui.Customization.Enabled == false and not SpectatorController.IsSpectating)) then
        return;
    end;

    local v2 = ReplicatedStorage.Assets.GoalEffects.CITY.StreetExplosion:Clone();
    v2.Parent = workspace;
    v2.CFrame = p1.Pos;
    VfxManager.Emit(v2);
    local u3 = ReplicatedStorage.Assets.GoalEffects.StreetVfx:Clone();
    u3.Parent = workspace.Debris;
    v2.Parent = u3;

    for _, child in u3:GetChildren() do
        if child:IsA("Model") ~= false then
            local PrimaryPart = child.PrimaryPart;
            local v4 = TweenService:Create(PrimaryPart, TweenInfo.new(1), {
                CFrame = PrimaryPart.CFrame
            });
            PrimaryPart.CFrame = PrimaryPart.CFrame - Vector3.new(0, 100, 0);
            v4:Play();

            for _, child2 in child.Cars:GetChildren() do
                local v5 = child2.CFrame * CFrame.new(0, 0, 500);
                local u6 = child2.CFrame * CFrame.new(0, 0, -500);
                local v7 = Random_new_ret:NextNumber(1, 3);
                child2.CFrame = v5;
                task.delay(v7, function() -- Line: 38
                    -- upvalues: TweenService (ref), child2 (copy), Random_new_ret (ref), u6 (copy)
                    TweenService:Create(child2, TweenInfo.new(Random_new_ret:NextNumber(3.5, 5)), {
                        CFrame = u6
                    }):Play();
                end);
                child2.Touched:Connect(function(p8) -- Line: 42
                    -- upvalues: LocalPlayer (copy)
                    if p8.Parent == LocalPlayer.Character then
                        LocalPlayer.Character.IsRagdoll.Value = true;
                        LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 50, 0);
                        task.delay(1, function() -- Line: 48
                            -- upvalues: LocalPlayer (ref)
                            LocalPlayer.Character.IsRagdoll.Value = false;
                        end);
                    end;
                end);
            end;
        end;
    end;

    task.delay(8, function() -- Line: 56
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
end;